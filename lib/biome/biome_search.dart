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

class BiomeSearchDelegate extends SearchDelegate<BiomeSearchEntry?> {
  BiomeSearchDelegate(this.entries)
    : super(
        searchFieldLabel: 'Search plants, animals, threats, and references',
        searchFieldStyle: const TextStyle(fontWeight: FontWeight.w600),
        textInputAction: TextInputAction.search,
        autocorrect: false,
        enableSuggestions: true,
      );

  final List<BiomeSearchEntry> entries;

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
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
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _buildMatches(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildMatches(context);

  Widget _buildMatches(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normalizedQuery = query.trim().toLowerCase();
    final matches = normalizedQuery.isEmpty
        ? entries
        : entries.where((entry) {
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
                      : 'Results for "$query"',
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
                onTap: () => close(context, entry),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
