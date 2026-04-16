import 'package:flutter/material.dart';

import 'biome_data.dart';
import 'biome_models.dart';
import 'biome_widgets.dart';

Widget buildBiomePage(int index) {
  switch (index) {
    case 0:
      return const TitleIntroPage();
    case 1:
      return const CharacteristicsPage();
    case 2:
      return const PlantsPage();
    case 3:
      return const AnimalsPage();
    case 4:
      return const ThreatsPage();
    case 5:
      return const VisitPage();
    case 6:
      return const ReferencesPage();
    default:
      return const SizedBox.shrink();
  }
}

class TitleIntroPage extends StatelessWidget {
  const TitleIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return BiomePageScaffold(
      title: '',
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            children: [
              SizedBox(
                height: 280,
                width: double.infinity,
                child: Image.asset(
                  'images/hero_forest.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFD4EDE4),
                      child: const Center(
                        child: Icon(Icons.image, size: 48),
                      ),
                    );
                  },
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.15),
                        Colors.black.withValues(alpha: 0.55),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 24,
                right: 24,
                bottom: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coniferous Forest Biome',
                      style: textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'A web-based tour of climate, biodiversity, adaptations, threats, and why these forests matter.',
                      style: textTheme.titleMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.95),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        AnimatedInfoCard(
          index: 0,
          child: Text(
            'Coniferous forests are dominated by cone-bearing evergreen trees such as spruce, fir, pine, and hemlock. They form one of Earth\'s largest terrestrial biomes and are strongly tied to nearby freshwater systems like cold streams, peatlands, and snow-fed lakes.',
            style: textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: 12),
        AnimatedInfoCard(
          index: 1,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              FactChip(
                label: 'Biome Type',
                value: 'Terrestrial + freshwater links',
              ),
              FactChip(label: 'Core Theme', value: 'Coniferous forest (taiga)'),
              FactChip(label: 'Design System', value: 'Google Material 3'),
            ],
          ),
        ),
        const SizedBox(height: 18),
        FilledButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Use navigation to explore all project sections.',
                  style: TextStyle(color: colorScheme.onInverseSurface),
                ),
              ),
            );
          },
          icon: const Icon(Icons.navigation),
          label: const Text('Start Exploring'),
        ),
      ],
    ));
  }
}

class CharacteristicsPage extends StatelessWidget {
  const CharacteristicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BiomePageScaffold(
      title: 'Characteristics',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(
          'Coniferous forests are usually cool to cold, with long winters, short growing seasons, and moderate precipitation that often falls as snow. Nearby aquatic systems are commonly cold, oxygen-rich, and strongly seasonal due to spring snowmelt.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        const AnimatedInfoCard(
          index: 0,
          child: ComparisonTable(
            rows: [
              ComparisonRow(
                'Distribution/location',
                'Northern North America, Europe, and Asia; mountain belts at lower latitudes',
                'Cold streams, bogs, ponds, and lakes within and around coniferous regions',
              ),
              ComparisonRow(
                'Precipitation / Physical-Chemical Environment',
                'About 30-85 cm/year; much as snow',
                'Freshwater, low nutrient levels in many systems, high dissolved oxygen in cold water',
              ),
              ComparisonRow(
                'Temperature',
                'Average annual about -5 C to 10 C',
                'Water often near 0-15 C depending on season and depth',
              ),
              ComparisonRow(
                'Climate / Geological Features',
                'Acidic soils, slow decomposition, glacial landforms common',
                'Glacial lakes, peatlands, stream channels, seasonal ice cover',
              ),
              ComparisonRow(
                'Zonation / Seasons',
                'Distinct canopy-understory-floor layers; clear seasons',
                'Shoreline (littoral), open water (limnetic), deep water (profundal); seasons affect ice, flow, and oxygen',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const AnimatedInfoCard(
          index: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Representative Countries and Regions'),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(label: Text('Canada')),
                  Chip(
                    label: Text(
                      'United States (Alaska, Rockies, Pacific Northwest)',
                    ),
                  ),
                  Chip(label: Text('Norway')),
                  Chip(label: Text('Sweden')),
                  Chip(label: Text('Finland')),
                  Chip(label: Text('Russia (Siberia)')),
                  Chip(label: Text('Japan (Hokkaido)')),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const AnimatedImageCard(
          index: 2,
          title: 'Map of Coniferous Forest Distribution',
          imageAsset: 'images/map_taiga.png',
          caption:
              'Global taiga/coniferous forest zone concentrated across high northern latitudes.',
        ),
      ],
    ));
  }
}

class PlantsPage extends StatelessWidget {
  const PlantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BiomePageScaffold(
      title: 'Plants',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        ...List.generate(
          plants.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: AnimatedInfoCard(
              index: index,
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.eco_outlined)),
                title: Text(plants[index].name),
                subtitle: Text(
                  'Adaptation: ${plants[index].adaptation}\nHow it helps: ${plants[index].benefit}',
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        const AnimatedImageCard(
          index: 6,
          title: 'Plant Image 1: Black Spruce',
          imageAsset: 'images/plant_black_spruce.jpg',
          caption:
              'Black spruce is highly adapted to cold, nutrient-poor northern soils.',
        ),
        const SizedBox(height: 12),
        const AnimatedImageCard(
          index: 7,
          title: 'Plant Image 2: Lodgepole Pine',
          imageAsset: 'images/plant_lodgepole_pine.jpg',
          caption:
              'Lodgepole pine can regenerate rapidly after fire through cone adaptations.',
        ),
      ],
    ));
  }
}

class AnimalsPage extends StatelessWidget {
  const AnimalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BiomePageScaffold(
      title: 'Animals',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        ...List.generate(
          animals.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: AnimatedInfoCard(
              index: index,
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.pets_outlined)),
                title: Text(animals[index].name),
                subtitle: Text(
                  'Adaptation: ${animals[index].adaptation}\nHow it helps: ${animals[index].benefit}',
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        const AnimatedImageCard(
          index: 6,
          title: 'Animal Image 1: Moose',
          imageAsset: 'images/animal_moose.jpg',
          caption:
              'Moose are large herbivores well-suited to boreal forests and wetlands.',
        ),
        const SizedBox(height: 12),
        const AnimatedImageCard(
          index: 7,
          title: 'Animal Image 2: Canada Lynx',
          imageAsset: 'images/animal_lynx.jpg',
          caption:
              'The Canada lynx specializes in snowy habitats and preys heavily on hares.',
        ),
      ],
    ));
  }
}

class ThreatsPage extends StatelessWidget {
  const ThreatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BiomePageScaffold(
      title: 'Threats',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        AnimatedInfoCard(
          index: 0,
          child: Text(
            'Coniferous forests face increasing pressure from resource extraction, climate change, and fragmentation. These drivers can alter species composition, increase fire severity, and reduce long-term carbon storage.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: 12),
        const AnimatedInfoCard(
          index: 1,
          child: ListTile(
            leading: Icon(Icons.content_cut),
            title: Text('Deforestation and logging roads'),
            subtitle: Text(
              'Causes: timber demand and road expansion. Effects: habitat loss, edge effects, and easier predator access into previously intact areas.',
            ),
          ),
        ),
        const SizedBox(height: 10),
        const AnimatedInfoCard(
          index: 2,
          child: ListTile(
            leading: Icon(Icons.local_fire_department),
            title: Text('Climate-driven fire regime changes'),
            subtitle: Text(
              'Causes: warming temperatures and drought stress. Effects: larger, hotter fires that can slow natural regeneration in some zones.',
            ),
          ),
        ),
        const SizedBox(height: 10),
        const AnimatedInfoCard(
          index: 3,
          child: ListTile(
            leading: Icon(Icons.bug_report),
            title: Text('Insect outbreaks and disease shifts'),
            subtitle: Text(
              'Causes: milder winters and stressed trees. Effects: increased mortality from bark beetles and altered forest age structure.',
            ),
          ),
        ),
        const SizedBox(height: 14),
        const AnimatedImageCard(
          index: 4,
          title: 'Threat Image: Wildfire and Forest Loss',
          imageAsset: 'images/threat_wildfire.jpg',
          caption:
              'Intense wildfires can transform coniferous landscapes and wildlife habitat.',
        ),
      ],
    ));
  }
}

class VisitPage extends StatelessWidget {
  const VisitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BiomePageScaffold(
      title: 'Visit & Explore',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        AnimatedInfoCard(
          index: 0,
          child: Text(
            'Coniferous forests offer year-round outdoor experiences, dramatic seasonal changes, and globally important ecosystems that store carbon and support biodiversity.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: 12),
        const AnimatedInfoCard(
          index: 1,
          child: ListTile(
            leading: Icon(Icons.hiking),
            title: Text('Nature experiences'),
            subtitle: Text(
              'Hiking, snowshoeing, birdwatching, and quiet recreation in old-growth landscapes.',
            ),
          ),
        ),
        const SizedBox(height: 10),
        const AnimatedInfoCard(
          index: 2,
          child: ListTile(
            leading: Icon(Icons.science),
            title: Text('Learning and research value'),
            subtitle: Text(
              'A living classroom for ecology, adaptation, nutrient cycles, and climate science.',
            ),
          ),
        ),
        const SizedBox(height: 10),
        const AnimatedInfoCard(
          index: 3,
          child: ListTile(
            leading: Icon(Icons.forest),
            title: Text('Scenic and cultural importance'),
            subtitle: Text(
              'Distinctive evergreen landscapes, northern lights in some regions, and Indigenous cultural connections.',
            ),
          ),
        ),
      ],
    ));
  }
}

class ReferencesPage extends StatelessWidget {
  const ReferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BiomePageScaffold(
      title: 'References',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(
          'Minimum of 3 references included below. These were used for biome facts, distribution, and media credits.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 14),
        const AnimatedInfoCard(
          index: 0,
          child: ListTile(
            leading: Icon(Icons.link),
            title: Text('Flutter UI Docs'),
            subtitle: Text('https://docs.flutter.dev/ui'),
          ),
        ),
        const SizedBox(height: 10),
        const AnimatedInfoCard(
          index: 1,
          child: ListTile(
            leading: Icon(Icons.link),
            title: Text('Flutter Material Widgets Catalog'),
            subtitle: Text('https://docs.flutter.dev/ui/widgets/material'),
          ),
        ),
        const SizedBox(height: 10),
        const AnimatedInfoCard(
          index: 2,
          child: ListTile(
            leading: Icon(Icons.link),
            title: Text('WWF: Boreal/Coniferous Forest (Taiga) Overview'),
            subtitle: Text(
              'https://www.worldwildlife.org/biomes/boreal-forests-taiga',
            ),
          ),
        ),
        const SizedBox(height: 10),
        const AnimatedInfoCard(
          index: 3,
          child: ListTile(
            leading: Icon(Icons.link),
            title: Text('National Geographic: Taiga Biome'),
            subtitle: Text(
              'https://education.nationalgeographic.org/resource/taiga/',
            ),
          ),
        ),
        const SizedBox(height: 10),
        const AnimatedInfoCard(
          index: 4,
          child: ListTile(
            leading: Icon(Icons.photo_library_outlined),
            title: Text('Image Sources'),
            subtitle: Text(
              'Image files are stored locally under assets/images for reliable loading.',
            ),
          ),
        ),
      ],
    ));
  }
}
