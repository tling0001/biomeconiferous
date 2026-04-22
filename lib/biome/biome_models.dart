import 'package:flutter/material.dart';

class PageMeta {
  const PageMeta(this.title, this.icon);

  final String title;
  final IconData icon;
}

class AdaptationItem {
  const AdaptationItem({
    required this.name,
    required this.adaptation,
    required this.benefit,
  });

  final String name;
  final String adaptation;
  final String benefit;
}

class ComparisonRow {
  const ComparisonRow(this.category, this.terrestrial);

  final String category;
  final String terrestrial;
}
