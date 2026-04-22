import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'biome_data.dart';
import 'biome_models.dart';
import 'biome_widgets.dart';

Widget buildBiomePage(int index, {VoidCallback? onStartExploring}) {
  switch (index) {
    case 0:
      return TitleIntroPage(onStartExploring: onStartExploring);
    case 1:
      return const CharacteristicsPage();
    case 2:
      return const SpeciesPage();
    case 3:
      return const ThreatsPage();
    case 4:
      return const ReferencesPage();
    default:
      return const SizedBox.shrink();
  }
}

class TitleIntroPage extends StatelessWidget {
  const TitleIntroPage({this.onStartExploring, super.key});

  final VoidCallback? onStartExploring;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BiomePageScaffold(
      title: 'Home',
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
                    'assets/images/hero_forest.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFFD4EDE4),
                        child: const Center(child: Icon(Icons.image, size: 48)),
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
                        'Coniferous Forest/Taiga Biome',
                        style: textTheme.headlineLarge?.copyWith(
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'A carefully designed tour of climate, biodiversity, adaptations, threats, and why these forests matter.',
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
              'Coniferous forests are dominated by cone-bearing evergreen trees such as spruce, fir, pine, and hemlock. They form Earth\'s largest terrestrial biomes and are strongly tied to nearby freshwater systems like cold streams, peatlands, and snow-fed lakes.',
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
                FactChip(label: 'Biome Type', value: 'Terrestrial'),
                FactChip(label: 'Biome', value: 'Coniferous forest (taiga)'),
                FactChip(
                  label: 'Design System',
                  value: 'Google Material Design 3',
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: onStartExploring,
            icon: const Icon(Icons.navigation),
            label: const Text('Start Exploring'),
          ),
        ],
      ),
    );
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
            'Coniferous forests are usually pretty cold, with long winters, short growing seasons, and moderate precipitation that often falls as snow.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final veryLargeLayout = constraints.maxWidth >= 1200;

              const traitsTable = AnimatedInfoCard(
                index: 0,
                child: ComparisonTable(
                  rows: [
                    ComparisonRow(
                      'Distribution/location',
                      'Northern North America, Europe, and Asia; mountain belts at lower latitudes',
                    ),
                    ComparisonRow(
                      'Precipitation / Physical-Chemical Environment',
                      'About 30-85 cm/year; much as snow',
                    ),
                    ComparisonRow(
                      'Temperature',
                      'Average annually about -5 C to 10 C',
                    ),
                    ComparisonRow(
                      'Climate / Geological Features',
                      'Acidic soils, slow decomposition, glacial landforms common',
                    ),
                    ComparisonRow(
                      'Seasons',
                      'Long, cold winters and short, cool summers with a brief growing season',
                    ),
                  ],
                ),
              );

              const mapCard = AnimatedImageCard(
                index: 2,
                title: 'Map of Coniferous Forest/Taiga Distribution',
                imageAsset: 'assets/images/map_taiga.png',
                caption:
                    'Global taiga/coniferous forest zone concentrated across high northern latitudes.',
              );

              if (!veryLargeLayout) {
                return const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [traitsTable, SizedBox(height: 16), mapCard],
                );
              }

              return const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: traitsTable),
                  SizedBox(width: 16),
                  Expanded(flex: 2, child: mapCard),
                ],
              );
            },
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
        ],
      ),
    );
  }
}

class SpeciesPage extends StatelessWidget {
  const SpeciesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BiomePageScaffold(
      title: 'Species',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wideLayout = constraints.maxWidth >= 900;

          if (wideLayout) {
            return const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _SpeciesGroup(
                    title: 'Plants',
                    icon: Icons.eco_outlined,
                    items: plants,
                    images: _plantSpeciesImages,
                    animationBaseIndex: 6,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _SpeciesGroup(
                    title: 'Animals',
                    icon: Icons.pets_outlined,
                    items: animals,
                    images: _animalSpeciesImages,
                    animationBaseIndex: 18,
                  ),
                ),
              ],
            );
          }

          return const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SpeciesGroup(
                title: 'Plants',
                icon: Icons.eco_outlined,
                items: plants,
                images: _plantSpeciesImages,
                animationBaseIndex: 6,
              ),
              SizedBox(height: 16),
              _SpeciesGroup(
                title: 'Animals',
                icon: Icons.pets_outlined,
                items: animals,
                images: _animalSpeciesImages,
                animationBaseIndex: 18,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SpeciesImageData {
  const _SpeciesImageData({
    required this.title,
    required this.imageAsset,
    required this.caption,
  });

  final String title;
  final String imageAsset;
  final String caption;
}

const List<_SpeciesImageData> _plantSpeciesImages = [
  _SpeciesImageData(
    title: 'Plant Image: Black Spruce',
    imageAsset: 'assets/images/plant_black_spruce.jpg',
    caption:
        'Black spruce is highly adapted to cold, nutrient-poor northern soils.',
  ),
  _SpeciesImageData(
    title: 'Plant Image: Lodgepole Pine',
    imageAsset: 'assets/images/plant_lodgepole_pine.jpg',
    caption:
        'Lodgepole pine can regenerate rapidly after fire through cone adaptations.',
  ),
  _SpeciesImageData(
    title: 'Plant Image: Balsam Fir',
    imageAsset: 'assets/images/plant_balsam_fir.jpg',
    caption: 'Balsam fir needles stay active through short growing seasons.',
  ),
  _SpeciesImageData(
    title: 'Plant Image: Bearberry',
    imageAsset: 'assets/images/plant_bearberry.jpg',
    caption:
        'Bearberry grows close to the ground to avoid wind stress and cold.',
  ),
  _SpeciesImageData(
    title: 'Plant Image: Sphagnum Moss',
    imageAsset: 'assets/images/plant_sphagnum_moss.jpg',
    caption:
        'Sphagnum moss stores water and supports acidic peatland conditions.',
  ),
];

const List<_SpeciesImageData> _animalSpeciesImages = [
  _SpeciesImageData(
    title: 'Animal Image: Moose',
    imageAsset: 'assets/images/animal_moose.jpg',
    caption:
        'Moose are large herbivores well-suited to boreal forests and wetlands.',
  ),
  _SpeciesImageData(
    title: 'Animal Image: Gray Wolf',
    imageAsset: 'assets/images/animal_gray_wolf.jpg',
    caption: 'Gray wolves combine social hunting with cold-climate endurance.',
  ),
  _SpeciesImageData(
    title: 'Animal Image: Canada Lynx',
    imageAsset: 'assets/images/animal_lynx.jpg',
    caption:
        'The Canada lynx specializes in snowy habitats and preys heavily on hares.',
  ),
  _SpeciesImageData(
    title: 'Animal Image: Snowshoe Hare',
    imageAsset: 'assets/images/animal_snowshoe_hare.jpg',
    caption: 'Snowshoe hares use seasonal camouflage to reduce predation risk.',
  ),
  _SpeciesImageData(
    title: 'Animal Image: Boreal Owl',
    imageAsset: 'assets/images/animal_boreal_owl.jpg',
    caption: 'Boreal owls hunt in low light with excellent hearing and vision.',
  ),
];

class _SpeciesGroup extends StatelessWidget {
  const _SpeciesGroup({
    required this.title,
    required this.icon,
    required this.items,
    required this.images,
    required this.animationBaseIndex,
  });

  final String title;
  final IconData icon;
  final List<AdaptationItem> items;
  final List<_SpeciesImageData> images;
  final int animationBaseIndex;

  @override
  Widget build(BuildContext context) {
    assert(items.length == images.length);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        const SizedBox(height: 12),
        ...List.generate(items.length, (index) {
          final entry = items[index];
          final image = images[index];
          final imageAnimationIndex = animationBaseIndex + (index * 2);
          final infoAnimationIndex = imageAnimationIndex + 1;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedImageCard(
                  index: imageAnimationIndex,
                  title: image.title,
                  imageAsset: image.imageAsset,
                  caption: image.caption,
                ),
                const SizedBox(height: 8),
                AnimatedInfoCard(
                  index: infoAnimationIndex,
                  child: ListTile(
                    leading: CircleAvatar(child: Icon(icon)),
                    title: Text(entry.name),
                    subtitle: Text(
                      'Adaptation: ${entry.adaptation}\nHow it helps: ${entry.benefit}',
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

Future<void> _launchReferenceUrl(String url) async {
  final uri = Uri.parse(url);
  await launchUrl(uri, mode: LaunchMode.platformDefault);
}

class _ReferenceLinkCard extends StatelessWidget {
  const _ReferenceLinkCard({
    required this.index,
    required this.title,
    required this.url,
  });

  final int index;
  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return AnimatedInfoCard(
      index: index,
      child: ListTile(
        leading: const Icon(Icons.link),
        title: Text(title),
        subtitle: Text(
          url,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            decoration: TextDecoration.underline,
          ),
        ),
        onTap: () {
          _launchReferenceUrl(url);
        },
      ),
    );
  }
}

class ThreatsPage extends StatelessWidget {
  const ThreatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BiomePageScaffold(
      title: 'Context',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wideLayout = constraints.maxWidth >= 960;

          const threatSection = _ThreatSection();
          final visitSection = _VisitSection();

          if (wideLayout) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: threatSection),
                const SizedBox(width: 16),
                Expanded(child: visitSection),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [threatSection, const SizedBox(height: 16), visitSection],
          );
        },
      ),
    );
  }
}

class _ThreatSection extends StatelessWidget {
  const _ThreatSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Threats', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        AnimatedInfoCard(
          index: 0,
          child: Text(
            'Coniferous forests face increasing pressure from resource extraction (logging), climate change, and fragmentation. These changes can alter species composition, increase fire severity, and reduce long-term carbon storage.',
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
              'Causes: timber chopping and road expansion. Effects: habitat loss, edge effects, and easier predator access into previously intact areas.',
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
              'Causes: warming temperatures and drought stress. Effects: larger, hotter fires that can slow natural regrowth in some zones.',
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
          imageAsset: 'assets/images/threat_wildfire.jpg',
          caption:
              'Intense wildfires can transform coniferous landscapes and wildlife habitat.',
        ),
      ],
    );
  }
}

class _VisitSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Why Visit', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        AnimatedInfoCard(
          index: 5,
          child: Text(
            'Coniferous forests offer year-round outdoor experiences, dramatic seasonal changes, and globally important ecosystems that store carbon and support biodiversity.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: 10),
        const AnimatedInfoCard(
          index: 6,
          child: ListTile(
            leading: Icon(Icons.hiking),
            title: Text('Nature experiences'),
            subtitle: Text(
              'Hiking, snowshoeing, birdwatching, and quiet relaxing in old-growth landscapes.',
            ),
          ),
        ),
        const SizedBox(height: 10),
        const AnimatedInfoCard(
          index: 7,
          child: ListTile(
            leading: Icon(Icons.science),
            title: Text('Learning and research value'),
            subtitle: Text(
              'Lots of education stuff for ecology, adaptation, nutrient cycles, and climate science.',
            ),
          ),
        ),
        const SizedBox(height: 10),
        const AnimatedInfoCard(
          index: 8,
          child: ListTile(
            leading: Icon(Icons.forest),
            title: Text('Scenic and cultural importance'),
            subtitle: Text(
              'Distinctive evergreen landscapes, northern lights in some regions, and Indigenous cultural connections.',
            ),
          ),
        ),
      ],
    );
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
      ),
    );
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
            'References included below. These were used for biome facts, distribution, and media credits.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 14),
          Text('Links', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          const _ReferenceLinkCard(
            index: 0,
            title: 'Flutter UI Docs',
            url: 'https://docs.flutter.dev/ui',
          ),
          const SizedBox(height: 10),
          const _ReferenceLinkCard(
            index: 1,
            title: 'Flutter Material Widgets Catalog',
            url: 'https://docs.flutter.dev/ui/widgets/material',
          ),
          const SizedBox(height: 10),
          const _ReferenceLinkCard(
            index: 2,
            title: 'WWF: Boreal/Coniferous Forest (Taiga) Overview',
            url: 'https://www.worldwildlife.org/biomes/boreal-forests-taiga',
          ),
          const SizedBox(height: 10),
          const _ReferenceLinkCard(
            index: 3,
            title: 'National Geographic: Taiga Biome',
            url: 'https://education.nationalgeographic.org/resource/taiga/',
          ),
          const SizedBox(height: 16),
          Text('Image Credits', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          const AnimatedInfoCard(
            index: 4,
            child: ListTile(
              leading: Icon(Icons.photo_library_outlined),
              title: Text('Site Images'),
              subtitle: Text(
                'Home hero: Wikimedia Commons (File:Siberian autumn in taiga..JPG, CC BY-SA 3.0).\nTaiga map: Wikimedia Commons (File:Taiga ecoregion.png, CC BY-SA 3.0).\nWildfire: Wikimedia Commons (File:Lick Fire on the Umatilla National Forest burning at night.jpg, Public domain).',
              ),
            ),
          ),
          const SizedBox(height: 10),
          const AnimatedInfoCard(
            index: 5,
            child: ListTile(
              leading: Icon(Icons.park_outlined),
              title: Text('Plant Image Credits'),
              subtitle: Text(
                'Black spruce: Wikimedia Commons (File:Black spruce stand at Arctic Chalet, Inuvik, NT.jpg, CC BY-SA 3.0).\nLodgepole pine: Wikimedia Commons (File:Pinus contorta 28289.JPG, CC BY-SA 3.0).\nBalsam fir: Wikimedia Commons (File:Abies balsamea.jpg, Public domain).\nBearberry: Wikimedia Commons (File:Arctostaphylos uva-ursi 2 RF.jpg, CC BY 4.0).\nSphagnum moss: Wikimedia Commons (File:Sphagnum moss in Panthertown Valley bog.jpg, CC0).',
              ),
            ),
          ),
          const SizedBox(height: 10),
          const AnimatedInfoCard(
            index: 6,
            child: ListTile(
              leading: Icon(Icons.pets_outlined),
              title: Text('Animal Image Credits (1)'),
              subtitle: Text(
                'Moose: Wikimedia Commons (File:Alce (Alces alces), Parque nacional y reserva Denali, Alaska, Estados Unidos, 2017-08-30, DD 52.jpg, CC BY-SA 4.0).\nGray wolf: Wikimedia Commons (File:Loup gris (Canis lupus ).jpg, CC BY-SA 4.0).\nCanada lynx: Wikimedia Commons (File:Canada lynx by Michael Zahra.jpg, CC BY-SA 3.0).',
              ),
            ),
          ),
          const SizedBox(height: 10),
          const AnimatedInfoCard(
            index: 7,
            child: ListTile(
              leading: Icon(Icons.pets_outlined),
              title: Text('Animal Image Credits (2)'),
              subtitle: Text(
                'Snowshoe hare: Wikimedia Commons (File:Lepus americanus - Blomidon Provincial Park 03.jpg, CC BY-SA 4.0).\nBoreal owl: Wikimedia Commons (File:Aegolius funereus by vmoser.jpg, CC BY 4.0).',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
