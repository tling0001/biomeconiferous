import 'package:flutter/material.dart';

import 'biome_models.dart';

const List<PageMeta> biomePageMeta = [
  PageMeta('Home', Icons.forest),
  PageMeta('Traits', Icons.thermostat),
  PageMeta('Species', Icons.nature),
  PageMeta('Context', Icons.warning_amber),
  PageMeta('References', Icons.menu_book),
];

const List<AdaptationItem> plants = [
  AdaptationItem(
    name: 'Black Spruce (Picea mariana)',
    adaptation: 'Narrow, spire-like crown',
    benefit:
        'Sheds snow efficiently so branches are less likely to break during heavy winters.',
  ),
  AdaptationItem(
    name: 'Lodgepole Pine (Pinus contorta)',
    adaptation: 'Serotinous cones',
    benefit:
        'Cones can open after fire, releasing seeds into nutrient-rich post-fire soils.',
  ),
  AdaptationItem(
    name: 'Balsam Fir (Abies balsamea)',
    adaptation: 'Waxy evergreen needles',
    benefit:
        'Reduces water loss and allows photosynthesis during brief warm periods.',
  ),
  AdaptationItem(
    name: 'Bearberry (Arctostaphylos uva-ursi)',
    adaptation: 'Low, mat-forming growth',
    benefit:
        'Stays below drying winds and helps conserve heat near ground level.',
  ),
  AdaptationItem(
    name: 'Sphagnum Moss',
    adaptation: 'High water retention',
    benefit:
        'Stores moisture in bog environments and creates acidic conditions that reduce competition.',
  ),
];

const List<AdaptationItem> animals = [
  AdaptationItem(
    name: 'Moose',
    adaptation: 'Long legs and insulating coat',
    benefit: 'Walks through deep snow and stays warm through long winters.',
  ),
  AdaptationItem(
    name: 'Gray Wolf',
    adaptation: 'Social pack hunting and dense fur',
    benefit: 'Improves hunting success and cold-weather survival.',
  ),
  AdaptationItem(
    name: 'Canada Lynx',
    adaptation: 'Wide, furred paws',
    benefit: 'Acts like snowshoes for efficient movement across snow.',
  ),
  AdaptationItem(
    name: 'Snowshoe Hare',
    adaptation: 'Seasonal coat color change',
    benefit: 'Camouflage shifts from brown to white, reducing predation risk.',
  ),
  AdaptationItem(
    name: 'Boreal Owl',
    adaptation: 'Acute hearing and low-light vision',
    benefit: 'Detects prey beneath snow and hunts effectively at dawn/dusk.',
  ),
];
