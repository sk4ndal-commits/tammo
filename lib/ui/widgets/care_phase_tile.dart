import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../features/event/domain/care_narrative.dart';
import '../../features/event/domain/event.dart';
import '../../l10n/app_localizations.dart';
import 'localization_helpers.dart';

class CarePhaseTile extends StatefulWidget {
  final CarePhase phase;
  final Widget Function(Event) eventTileBuilder;

  const CarePhaseTile({
    super.key,
    required this.phase,
    required this.eventTileBuilder,
  });

  @override
  State<CarePhaseTile> createState() => _CarePhaseTileState();
}

class _CarePhaseTileState extends State<CarePhaseTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final dateFormat = DateFormat.yMd();

    final dateRange = widget.phase.isOngoing
        ? '${dateFormat.format(widget.phase.startDate)} - ${l10n.phaseOngoing}'
        : '${dateFormat.format(widget.phase.startDate)} - ${dateFormat.format(widget.phase.endDate!)}';

    final planCount = widget.phase.planIdsStarted.length + widget.phase.planIdsEnded.length;
    final summary = l10n.phaseSummary(widget.phase.events.length, planCount);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          l10n.phaseTitle(LocalizationHelpers.translateEventType(context, widget.phase.dominantTopic)),
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.onTertiaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (widget.phase.isResolved)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            l10n.phaseResolved,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      Icon(
                        _isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    dateRange,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    summary,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Container(
              color: theme.colorScheme.surfaceContainerLow.withAlpha(50),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: widget.phase.events
                    .map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: widget.eventTileBuilder(e),
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
