import 'package:flutter/material.dart';

import 'biome/biome_data.dart';
import 'biome/biome_pages.dart';

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
  bool _railExpanded = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.size.width > 1000;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        color: colorScheme.surface,
        child: isLandscape
            ? Row(
                children: [
                  _buildLandscapeRail(),
                  const VerticalDivider(width: 1),
                  Expanded(child: _buildAnimatedContent()),
                ],
              )
            : _buildAnimatedContent(),
      ),
      bottomNavigationBar: isLandscape ? null : _buildBottomNavigationBar(),
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
        key: ValueKey(_selectedIndex),
        child: buildBiomePage(_selectedIndex),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() => _selectedIndex = index);
      },
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: biomePageMeta
          .map(
            (meta) =>
                NavigationDestination(icon: Icon(meta.icon), label: meta.title),
          )
          .toList(),
    );
  }

  Widget _buildLandscapeRail() {
    final railWidth = _railExpanded ? 260.0 : 120.0;
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOutCubic,
      width: railWidth,
      child: Material(
        color: colorScheme.surface,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 12),
              child: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  setState(() => _railExpanded = !_railExpanded);
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: biomePageMeta.length,
                itemBuilder: (context, index) {
                  final meta = biomePageMeta[index];
                  final isSelected = _selectedIndex == index;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Material(
                      color: isSelected
                          ? colorScheme.primary.withValues(alpha: 0.14)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          setState(() => _selectedIndex = index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 12,
                          ),
                          child: _railExpanded
                              ? Row(
                                  children: [
                                    Icon(meta.icon),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        meta.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(meta.icon),
                                    const SizedBox(height: 8),
                                    Text(
                                      meta.title,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
