import 'package:flutter/widgets.dart';

class SlidableModal {
  const SlidableModal(this.id, this.title, this.subtitle, this.showIcon,
      {this.icon});

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool showIcon;
}
