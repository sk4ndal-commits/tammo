import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import '../../features/backup/application/backup_service.dart';
import '../../features/backup/data/supabase_provider.dart';
import '../widgets/toast_utils.dart';

class BackupScreen extends ConsumerStatefulWidget {
  const BackupScreen({super.key});

  @override
  ConsumerState<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends ConsumerState<BackupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(backupServiceProvider).signIn(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
    } catch (e) {
      if (mounted) ToastUtils.showError(context, e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleSignUp() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(backupServiceProvider).signUp(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
      if (mounted) ToastUtils.showSuccess(context, "Account created successfully.");
    } catch (e) {
      if (mounted) ToastUtils.showError(context, e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleBackup() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(backupServiceProvider).uploadBackup(force: true);
      if (mounted) ToastUtils.showSuccess(context, AppLocalizations.of(context)!.backupSuccess);
    } catch (e) {
      if (mounted) ToastUtils.showError(context, e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleRestore() async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.backupRestore),
        content: Text(l10n.backupRestoreWarning),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.undo)),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.backupRestore)),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => _isLoading = true);
      try {
        await ref.read(backupServiceProvider).restoreBackup();
        if (mounted) ToastUtils.showSuccess(context, l10n.restoreSuccess);
      } catch (e) {
        if (mounted) ToastUtils.showError(context, e.toString());
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.backupTitle)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.cloud_done_outlined, size: 64, color: Colors.blue),
                  const SizedBox(height: 16),
                  Text(
                    l10n.backupSubtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 32),
                  if (user == null) ...[
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: l10n.backupEmail),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: l10n.backupPassword),
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _handleSignIn,
                      child: Text(l10n.backupLogin),
                    ),
                    TextButton(
                      onPressed: _handleSignUp,
                      child: Text(l10n.backupRegister),
                    ),
                  ] else ...[
                    Text(
                      l10n.loggedInAs(user.email ?? ""),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: _handleBackup,
                      icon: const Icon(Icons.cloud_upload),
                      label: Text(l10n.backupNow),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: _handleRestore,
                      icon: const Icon(Icons.cloud_download),
                      label: Text(l10n.backupRestore),
                    ),
                    const SizedBox(height: 32),
                    TextButton(
                      onPressed: () => ref.read(backupServiceProvider).signOut(),
                      child: Text(l10n.backupLogout),
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}
