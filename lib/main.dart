import 'package:flutter/material.dart';

import 'biome/biome_data.dart';
import 'biome/biome_pages.dart';
import 'biome/biome_search.dart';

void main() {
  runApp(const BiomeConiferousApp());
}

class BiomeConiferousApp extends StatelessWidget {
  const BiomeConiferousApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coniferous Forest Biome',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1F8A43),
          brightness: Brightness.light,
        ),
        textTheme: Typography.material2021().black.copyWith(
          headlineLarge: const TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
          headlineSmall: const TextStyle(fontWeight: FontWeight.w700),
          titleLarge: const TextStyle(fontWeight: FontWeight.w700),
          bodyLarge: const TextStyle(height: 1.35),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFFF7FFF7),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7CCB8A),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF101813),
        textTheme: Typography.material2021().white.copyWith(
          headlineLarge: const TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
          headlineSmall: const TextStyle(fontWeight: FontWeight.w700),
          titleLarge: const TextStyle(fontWeight: FontWeight.w700),
          bodyLarge: const TextStyle(height: 1.35),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF18231C),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
      home: const BiomeHomePage(),
    );
  }
}

class BiomeHomePage extends StatefulWidget {
  const BiomeHomePage({super.key});

  @override
  State<BiomeHomePage> createState() => _BiomeHomePageState();
}

class _BiomeHomePageState extends State<BiomeHomePage> {
  int _selectedIndex = 0;
  static const double _railBreakpoint = 900;

  int get _safeIndex => _selectedIndex.clamp(0, biomePageMeta.length - 1);

  IconData _inactiveIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.forest_outlined;
      case 1:
        return Icons.thermostat_outlined;
      case 2:
        return Icons.nature_outlined;
      case 3:
        return Icons.warning_amber_outlined;
      case 4:
        return Icons.menu_book_outlined;
      default:
        return biomePageMeta[index].icon;
    }
  }

  IconData _activeIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.forest;
      case 1:
        return Icons.thermostat;
      case 2:
        return Icons.nature;
      case 3:
        return Icons.warning_amber;
      case 4:
        return Icons.menu_book;
      default:
        return biomePageMeta[index].icon;
    }
  }

  List<BiomeSearchEntry> get _searchEntries => [
    const BiomeSearchEntry(
      title: 'Home',
      category: 'Page',
      description: 'Overview of the coniferous forest biome.',
      pageIndex: 0,
      keywords: ['coniferous forest', 'taiga', 'overview'],
    ),
    const BiomeSearchEntry(
      title: 'Characteristics',
      category: 'Page',
      description: 'Climate, seasons, and environmental traits.',
      pageIndex: 1,
      keywords: ['climate', 'temperature', 'precipitation'],
    ),
    const BiomeSearchEntry(
      title: 'Species',
      category: 'Page',
      description: 'Plants and animals shown together on one page.',
      pageIndex: 2,
      keywords: [
        'black spruce',
        'lodgepole pine',
        'balsam fir',
        'bearberry',
        'sphagnum',
        'moose',
        'lynx',
        'wolf',
        'hare',
        'owl',
        'needles',
        'cones',
        'flora',
        'fauna',
      ],
    ),
    const BiomeSearchEntry(
      title: 'Context',
      category: 'Page',
      description:
          'Human pressures and why the biome is worth visiting, shown together.',
      pageIndex: 3,
      keywords: [
        'wildfire',
        'logging',
        'fire',
        'climate change',
        'fragmentation',
        'insect outbreaks',
        'disease',
        'why visit',
        'nature experiences',
        'research value',
        'scenic',
      ],
    ),
    const BiomeSearchEntry(
      title: 'Black Spruce',
      category: 'Plant',
      description: 'Narrow crown helps shed snow efficiently.',
      pageIndex: 2,
      keywords: ['picea mariana', 'snow', 'evergreen', 'crown', 'winter'],
    ),
    const BiomeSearchEntry(
      title: 'Lodgepole Pine',
      category: 'Plant',
      description: 'Serotinous cones open after fire.',
      pageIndex: 2,
      keywords: ['fire', 'cones', 'post-fire', 'serotinous', 'resprout'],
    ),
    const BiomeSearchEntry(
      title: 'Balsam Fir',
      category: 'Plant',
      description: 'Waxy needles reduce water loss in cold conditions.',
      pageIndex: 2,
      keywords: ['needles', 'waxy', 'evergreen', 'winter'],
    ),
    const BiomeSearchEntry(
      title: 'Bearberry',
      category: 'Plant',
      description: 'Low, mat-forming growth hugs the ground for protection.',
      pageIndex: 2,
      keywords: ['groundcover', 'mat-forming', 'heath'],
    ),
    const BiomeSearchEntry(
      title: 'Sphagnum Moss',
      category: 'Plant',
      description: 'Retains water and builds acidic peatlands.',
      pageIndex: 2,
      keywords: ['moss', 'peat', 'bog', 'water retention'],
    ),
    const BiomeSearchEntry(
      title: 'Moose',
      category: 'Animal',
      description: 'Long legs and insulating coat suit deep snow.',
      pageIndex: 2,
      keywords: ['deer', 'wetlands', 'snow', 'herbivore', 'antlers'],
    ),
    const BiomeSearchEntry(
      title: 'Canada Lynx',
      category: 'Animal',
      description: 'Wide paws work like snowshoes.',
      pageIndex: 2,
      keywords: ['snowshoe', 'hare', 'predator', 'cats', 'feline'],
    ),
    const BiomeSearchEntry(
      title: 'Gray Wolf',
      category: 'Animal',
      description: 'Pack hunting and dense fur support survival in winter.',
      pageIndex: 2,
      keywords: ['pack', 'fur', 'carnivore', 'winter'],
    ),
    const BiomeSearchEntry(
      title: 'Snowshoe Hare',
      category: 'Animal',
      description: 'Seasonal coat changes improve camouflage.',
      pageIndex: 2,
      keywords: ['camouflage', 'winter coat', 'prey'],
    ),
    const BiomeSearchEntry(
      title: 'Boreal Owl',
      category: 'Animal',
      description:
          'Low-light vision and hearing help locate prey beneath snow.',
      pageIndex: 2,
      keywords: ['owl', 'prey', 'snow', 'vision'],
    ),
    const BiomeSearchEntry(
      title: 'References',
      category: 'Topic',
      description: 'Sources and image credits.',
      pageIndex: 4,
      keywords: [
        'flutter docs',
        'material',
        'wwf',
        'national geographic',
        'image sources',
        'credits',
      ],
    ),
    const BiomeSearchEntry(
      title: 'Why Visit',
      category: 'Topic',
      description: 'Outdoor recreation, research, and scenic value.',
      pageIndex: 3,
      keywords: ['hiking', 'snowshoeing', 'birdwatching', 'scenic'],
    ),
    const BiomeSearchEntry(
      title: 'Deforestation',
      category: 'Threat',
      description: 'Logging roads and habitat loss fragment forests.',
      pageIndex: 3,
      keywords: ['logging', 'roads', 'fragmentation', 'habitat loss'],
    ),
    const BiomeSearchEntry(
      title: 'Wildfire',
      category: 'Threat',
      description: 'Changing fire regimes can reshape forest structure.',
      pageIndex: 3,
      keywords: ['burn', 'climate', 'regime', 'severity'],
    ),
    const BiomeSearchEntry(
      title: 'Climate Change',
      category: 'Threat',
      description: 'Warmer conditions stress trees and shift species ranges.',
      pageIndex: 3,
      keywords: ['warming', 'drought', 'range shift', 'stress'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isWideLayout = MediaQuery.sizeOf(context).width >= _railBreakpoint;

    return Scaffold(
      body: isWideLayout
          ? Row(
              children: [
                _buildNavigationRail(),
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: colorScheme.outlineVariant,
                ),
                Expanded(
                  child: Container(
                    color: colorScheme.surface,
                    child: _buildAnimatedContent(),
                  ),
                ),
              ],
            )
          : Container(
              color: colorScheme.surface,
              child: _buildAnimatedContent(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showSearch<BiomeSearchEntry?>(
            context: context,
            delegate: BiomeSearchDelegate(_searchEntries),
          );
          if (result != null && mounted) {
            setState(() => _selectedIndex = result.pageIndex);
          }
        },
        child: const Icon(Icons.search),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: isWideLayout ? null : _buildBottomNavigationBar(),
    );
  }

  Widget _buildAnimatedContent() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) {
        final slide = Tween<Offset>(
          begin: const Offset(0.06, 0),
          end: Offset.zero,
        ).animate(animation);
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(position: slide, child: child),
        );
      },
      child: KeyedSubtree(
        key: ValueKey(_safeIndex),
        child: buildBiomePage(
          _safeIndex,
          onStartExploring: () {
            setState(() => _selectedIndex = 1);
          },
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return NavigationBar(
      selectedIndex: _safeIndex,
      onDestinationSelected: (index) {
        setState(() => _selectedIndex = index);
      },
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: List.generate(biomePageMeta.length, (index) {
        final meta = biomePageMeta[index];
        return NavigationDestination(
          icon: Icon(_inactiveIconForIndex(index)),
          selectedIcon: Icon(_activeIconForIndex(index)),
          label: meta.title,
        );
      }),
    );
  }

  Widget _buildNavigationRail() {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      right: false,
      child: NavigationRail(
        backgroundColor: colorScheme.surface,
        selectedIndex: _safeIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        labelType: NavigationRailLabelType.all,
        minExtendedWidth: 220,
        destinations: List.generate(biomePageMeta.length, (index) {
          final meta = biomePageMeta[index];
          return NavigationRailDestination(
            icon: Icon(_inactiveIconForIndex(index)),
            selectedIcon: Icon(_activeIconForIndex(index)),
            label: Text(meta.title),
          );
        }),
      ),
    );
  }
}
