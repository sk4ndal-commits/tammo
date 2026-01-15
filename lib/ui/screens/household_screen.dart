import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import '../../features/household/application/household_service.dart';
import '../../features/household/domain/household.dart';
import '../../features/household/domain/household_member.dart';
import '../../features/household/domain/household_invitation.dart';
import '../../features/household/domain/household_role.dart';
import '../../features/backup/data/supabase_provider.dart';
import '../widgets/toast_utils.dart';

class HouseholdScreen extends ConsumerStatefulWidget {
  const HouseholdScreen({super.key});

  @override
  ConsumerState<HouseholdScreen> createState() => _HouseholdScreenState();
}

class _HouseholdScreenState extends ConsumerState<HouseholdScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = ref.watch(currentUserProvider);
    final householdAsync = ref.watch(currentHouseholdProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.householdTitle),
      ),
      body: user == null
          ? _buildNotLoggedIn(context, l10n)
          : householdAsync.when(
              data: (household) => household == null
                  ? _buildNoHousehold(context, l10n)
                  : _buildHouseholdView(context, l10n, household),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Fehler: $e')),
            ),
    );
  }

  Widget _buildNotLoggedIn(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.people_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              l10n.householdLoginRequired,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/backup'),
              child: Text(l10n.backupLogin),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoHousehold(BuildContext context, AppLocalizations l10n) {
    final invitationsAsync = ref.watch(myPendingInvitationsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.home_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            l10n.householdNoHousehold,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.householdNoHouseholdHint,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _isLoading ? null : () => _showCreateHouseholdDialog(context, l10n),
            icon: const Icon(Icons.add_home),
            label: Text(l10n.householdCreate),
          ),
          const SizedBox(height: 32),
          
          // Pending Invitations
          invitationsAsync.when(
            data: (invitations) {
              if (invitations.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.householdPendingInvitations,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  ...invitations.map((inv) => _buildInvitationCard(context, l10n, inv)),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildInvitationCard(BuildContext context, AppLocalizations l10n, HouseholdInvitation invitation) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.mail)),
        title: Text(l10n.householdInvitationFrom),
        subtitle: Text(invitation.message ?? l10n.householdInvitationRole(invitation.role.displayName)),
        trailing: ElevatedButton(
          onPressed: _isLoading ? null : () => _acceptInvitation(invitation.inviteToken),
          child: Text(l10n.householdAccept),
        ),
      ),
    );
  }

  Widget _buildHouseholdView(BuildContext context, AppLocalizations l10n, HouseholdWithMembers household) {
    final currentRole = ref.watch(currentUserRoleProvider);
    final invitationsAsync = ref.watch(householdInvitationsProvider);
    final canManage = currentRole.value?.canManageMembers ?? false;

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(currentHouseholdProvider);
        ref.invalidate(householdInvitationsProvider);
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Household Info Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.home, size: 32),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          household.household.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      if (canManage)
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showEditHouseholdDialog(context, l10n, household.household),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.householdMemberCount(household.activeMemberCount),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Members Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.householdMembers,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (canManage)
                TextButton.icon(
                  onPressed: () => _showInviteDialog(context, l10n),
                  icon: const Icon(Icons.person_add),
                  label: Text(l10n.householdInvite),
                ),
            ],
          ),
          const SizedBox(height: 8),
          ...household.members
              .where((m) => m.status == MemberStatus.active)
              .map((member) => _buildMemberTile(context, l10n, member, canManage)),

          // Pending Invitations (for admins)
          if (canManage) ...[
            const SizedBox(height: 24),
            invitationsAsync.when(
              data: (invitations) {
                if (invitations.isEmpty) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.householdPendingInvitations,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    ...invitations.map((inv) => _buildPendingInviteTile(context, l10n, inv)),
                  ],
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMemberTile(BuildContext context, AppLocalizations l10n, HouseholdMember member, bool canManage) {
    final user = ref.watch(currentUserProvider);
    final isCurrentUser = user?.id == member.userId;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getRoleColor(member.role),
          child: Text(
            member.initials,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                member.displayNameOrEmail,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isCurrentUser)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  l10n.householdYou,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Text(_getRoleDisplayName(l10n, member.role)),
        trailing: canManage && !isCurrentUser && member.role != HouseholdRole.owner
            ? PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'remove') {
                    _confirmRemoveMember(context, l10n, member);
                  } else if (value == 'change_role') {
                    _showChangeRoleDialog(context, l10n, member);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'change_role',
                    child: Text(l10n.householdChangeRole),
                  ),
                  PopupMenuItem(
                    value: 'remove',
                    child: Text(
                      l10n.householdRemove,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              )
            : null,
      ),
    );
  }

  Widget _buildPendingInviteTile(BuildContext context, AppLocalizations l10n, HouseholdInvitation invitation) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.orange.shade50,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.orange,
          child: Icon(Icons.hourglass_empty, color: Colors.white),
        ),
        title: Text(invitation.email),
        subtitle: Text('${_getRoleDisplayName(l10n, invitation.role)} • ${l10n.householdInvitePending}'),
        trailing: IconButton(
          icon: const Icon(Icons.close, color: Colors.red),
          onPressed: () => _revokeInvitation(invitation.inviteId),
        ),
      ),
    );
  }

  Color _getRoleColor(HouseholdRole role) {
    switch (role) {
      case HouseholdRole.owner:
        return Colors.purple;
      case HouseholdRole.admin:
        return Colors.blue;
      case HouseholdRole.caregiver:
        return Colors.green;
    }
  }

  String _getRoleDisplayName(AppLocalizations l10n, HouseholdRole role) {
    switch (role) {
      case HouseholdRole.owner:
        return l10n.householdRoleOwner;
      case HouseholdRole.admin:
        return l10n.householdRoleAdmin;
      case HouseholdRole.caregiver:
        return l10n.householdRoleCaregiver;
    }
  }

  // ============================================================================
  // Dialogs & Actions
  // ============================================================================

  Future<void> _showCreateHouseholdDialog(BuildContext context, AppLocalizations l10n) async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.householdCreate),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: l10n.householdName,
            hintText: l10n.householdNameHint,
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.undo),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: Text(l10n.householdCreate),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() => _isLoading = true);
      try {
        await ref.read(householdServiceProvider).createHousehold(result);
        if (mounted) ToastUtils.showSuccess(context, l10n.householdCreated);
      } catch (e) {
        if (mounted) ToastUtils.showError(context, e.toString());
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _showEditHouseholdDialog(BuildContext context, AppLocalizations l10n, Household household) async {
    final controller = TextEditingController(text: household.name);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.householdEdit),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: l10n.householdName),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.undo),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: Text(l10n.save),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty && result != household.name) {
      setState(() => _isLoading = true);
      try {
        await ref.read(householdServiceProvider).updateHouseholdName(household.householdId, result);
        if (mounted) ToastUtils.showSuccess(context, l10n.petUpdated);
      } catch (e) {
        if (mounted) ToastUtils.showError(context, e.toString());
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _showInviteDialog(BuildContext context, AppLocalizations l10n) async {
    final emailController = TextEditingController();
    HouseholdRole selectedRole = HouseholdRole.caregiver;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(l10n.householdInvite),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: l10n.backupEmail,
                  hintText: 'email@example.com',
                ),
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<HouseholdRole>(
                value: selectedRole,
                decoration: InputDecoration(labelText: l10n.householdRole),
                items: [
                  DropdownMenuItem(
                    value: HouseholdRole.caregiver,
                    child: Text(l10n.householdRoleCaregiver),
                  ),
                  DropdownMenuItem(
                    value: HouseholdRole.admin,
                    child: Text(l10n.householdRoleAdmin),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setDialogState(() => selectedRole = value);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.undo),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, {
                'email': emailController.text.trim(),
                'role': selectedRole,
              }),
              child: Text(l10n.householdInvite),
            ),
          ],
        ),
      ),
    );

    if (result != null && (result['email'] as String).isNotEmpty) {
      setState(() => _isLoading = true);
      try {
        await ref.read(householdServiceProvider).inviteMember(
              email: result['email'] as String,
              role: result['role'] as HouseholdRole,
            );
        if (mounted) ToastUtils.showSuccess(context, l10n.householdInviteSent);
      } catch (e) {
        if (mounted) ToastUtils.showError(context, e.toString());
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _showChangeRoleDialog(BuildContext context, AppLocalizations l10n, HouseholdMember member) async {
    HouseholdRole selectedRole = member.role;

    final result = await showDialog<HouseholdRole>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(l10n.householdChangeRole),
          content: DropdownButtonFormField<HouseholdRole>(
            value: selectedRole,
            decoration: InputDecoration(labelText: l10n.householdRole),
            items: [
              DropdownMenuItem(
                value: HouseholdRole.caregiver,
                child: Text(l10n.householdRoleCaregiver),
              ),
              DropdownMenuItem(
                value: HouseholdRole.admin,
                child: Text(l10n.householdRoleAdmin),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setDialogState(() => selectedRole = value);
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.undo),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, selectedRole),
              child: Text(l10n.save),
            ),
          ],
        ),
      ),
    );

    if (result != null && result != member.role) {
      setState(() => _isLoading = true);
      try {
        await ref.read(householdServiceProvider).updateMemberRole(member.memberId, result);
        if (mounted) ToastUtils.showSuccess(context, l10n.petUpdated);
      } catch (e) {
        if (mounted) ToastUtils.showError(context, e.toString());
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _confirmRemoveMember(BuildContext context, AppLocalizations l10n, HouseholdMember member) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.householdRemove),
        content: Text(l10n.householdRemoveConfirm(member.displayNameOrEmail)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.undo),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.householdRemove),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => _isLoading = true);
      try {
        await ref.read(householdServiceProvider).removeMember(member.memberId);
        if (mounted) ToastUtils.showSuccess(context, l10n.householdMemberRemoved);
      } catch (e) {
        if (mounted) ToastUtils.showError(context, e.toString());
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _acceptInvitation(String inviteToken) async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isLoading = true);
    try {
      await ref.read(householdServiceProvider).acceptInvitation(inviteToken);
      if (mounted) ToastUtils.showSuccess(context, l10n.householdJoined);
    } catch (e) {
      if (mounted) ToastUtils.showError(context, e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _revokeInvitation(String inviteId) async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isLoading = true);
    try {
      await ref.read(householdServiceProvider).revokeInvitation(inviteId);
      if (mounted) ToastUtils.showSuccess(context, l10n.householdInviteRevoked);
    } catch (e) {
      if (mounted) ToastUtils.showError(context, e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
