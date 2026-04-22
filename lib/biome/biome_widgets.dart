import 'dart:ui';

import 'package:flutter/material.dart';

import 'biome_models.dart';

class BiomePageScaffold extends StatefulWidget {
  const BiomePageScaffold({
    required this.child,
    required this.title,
    super.key,
  });

  final Widget child;
  final String title;

  @override
  State<BiomePageScaffold> createState() => _BiomePageScaffoldState();
}

class _BiomePageScaffoldState extends State<BiomePageScaffold> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final normalized = ((width - 360.0) / (2200.0 - 360.0)).clamp(0.0, 1.0);
        // Parabolic ease-out keeps margin growth smooth and slows expansion
        // at very wide viewport sizes (including heavy zoom-out scenarios).
        final eased = 1.0 - (1.0 - normalized) * (1.0 - normalized);
        final marginRatio = 0.04 + (0.05 * eased);
        final horizontalPadding = 12.0 + (8.0 * eased);
        final contentMaxWidth = width * (1.0 - (marginRatio * 2.0));

        return ScrollConfiguration(
          behavior: const _BiomeScrollBehavior(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              16,
              horizontalPadding,
              24,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentMaxWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: width >= 900 ? 32 : 28,
                        fontWeight: FontWeight.w800,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    widget.child,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BiomeScrollBehavior extends MaterialScrollBehavior {
  const _BiomeScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.invertedStylus,
    PointerDeviceKind.trackpad,
  };

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
  }

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return StretchingOverscrollIndicator(
      axisDirection: details.direction,
      child: child,
    );
  }
}

class AnimatedInfoCard extends StatelessWidget {
  const AnimatedInfoCard({required this.index, required this.child, super.key});

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final duration = Duration(milliseconds: 450 + (index * 80));
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, value, content) {
        final opacity = value.clamp(0, 1).toDouble();
        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 14),
            child: content,
          ),
        );
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(padding: const EdgeInsets.all(12), child: child),
      ),
    );
  }
}

class AnimatedImageCard extends StatelessWidget {
  const AnimatedImageCard({
    required this.index,
    required this.title,
    required this.imageAsset,
    required this.caption,
    super.key,
  });

  final int index;
  final String title;
  final String imageAsset;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return AnimatedInfoCard(
      index: index,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    imageAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFFD4EDE4),
                        child: const Center(child: Icon(Icons.image, size: 32)),
                      );
                    },
                  ),
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 12,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          color: Colors.black.withValues(alpha: 0.25),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          child: Text(
                            caption,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ComparisonTable extends StatelessWidget {
  const ComparisonTable({required this.rows, super.key});

  final List<ComparisonRow> rows;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Main Terrestrial Biome Traits', style: textTheme.titleLarge),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          child: Column(
            children: [
              const TableHeader(cells: ['Category', 'Main Terrestrial Biome']),
              ...rows.map(
                (row) =>
                    TableRowContent(cells: [row.category, row.terrestrial]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TableHeader extends StatelessWidget {
  const TableHeader({required this.cells, super.key});

  final List<String> cells;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cells
            .map(
              (cell) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    cell,
                    style: textTheme.titleSmall?.copyWith(
                      color: colorScheme.onSecondaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class TableRowContent extends StatelessWidget {
  const TableRowContent({required this.cells, super.key});

  final List<String> cells;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.6),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cells
            .map(
              (cell) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(cell),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class FactChip extends StatelessWidget {
  const FactChip({required this.label, required this.value, super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: const Icon(Icons.check_circle_outline, size: 18),
      label: Text('$label: $value'),
    );
  }
}
