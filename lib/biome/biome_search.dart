import 'package:flutter/material.dart';

class BiomeSearchEntry {
  const BiomeSearchEntry({
    required this.title,
    required this.category,
    required this.description,
    required this.pageIndex,
    this.keywords = const [],
  });

  final String title;
  final String category;
  final String description;
  final int pageIndex;
  final List<String> keywords;
}

Future<BiomeSearchEntry?> showBiomeSearch(
  BuildContext context,
  List<BiomeSearchEntry> entries,
) {
  return Navigator.of(context).push<BiomeSearchEntry?>(
    PageRouteBuilder<BiomeSearchEntry?>(
      transitionDuration: const Duration(milliseconds: 280),
      reverseTransitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (_, _, _) => BiomeSearchPage(entries: entries),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        );
      },
    ),
  );
}

class BiomeSearchPage extends StatefulWidget {
  const BiomeSearchPage({required this.entries, super.key});

  final List<BiomeSearchEntry> entries;

  @override
  State<BiomeSearchPage> createState() => _BiomeSearchPageState();
}

class _BiomeSearchPageState extends State<BiomeSearchPage> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: TextField(
          controller: _controller,
          focusNode: _focusNode,
          textInputAction: TextInputAction.search,
          autocorrect: false,
          style: const TextStyle(fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            hintText: 'Search plants, animals, threats, and references',
            filled: true,
            fillColor: colorScheme.surfaceContainerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: colorScheme.primary, width: 1.4),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          onChanged: (value) {
            setState(() {
              _query = value;
            });
          },
        ),
        actions: [
          if (_query.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
                setState(() {
                  _query = '';
                });
              },
            ),
        ],
      ),
      body: _buildMatches(context),
    );
  }

  Widget _buildMatches(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normalizedQuery = _query.trim().toLowerCase();
    final matches = normalizedQuery.isEmpty
        ? widget.entries
        : widget.entries.where((entry) {
            final searchable = <String>[
              entry.title,
              entry.category,
              entry.description,
              ...entry.keywords,
            ].join(' ').toLowerCase();
            return searchable.contains(normalizedQuery);
          }).toList();

    if (matches.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 40,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'No matches found.',
                      style: theme.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Try searching for a species, a biome topic, or a reference term like fire or climate.',
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  normalizedQuery.isEmpty
                      ? 'Search the biome'
                      : 'Results for "$_query"',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  normalizedQuery.isEmpty
                      ? 'Start with a page, species, or theme.'
                      : 'Showing ${matches.length} matching entries.',
                  style: theme.textTheme.bodyMedium,
                ),
                if (normalizedQuery.isEmpty) ...[
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      Chip(label: Text('Black Spruce')),
                      Chip(label: Text('Moose')),
                      Chip(label: Text('Wildfire')),
                      Chip(label: Text('References')),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          normalizedQuery.isEmpty ? 'All topics' : 'Matches',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        ...matches.map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              elevation: 0,
              child: ListTile(
                title: Text(entry.title),
                subtitle: Text('${entry.category}\n${entry.description}'),
                isThreeLine: true,
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).pop(entry),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
