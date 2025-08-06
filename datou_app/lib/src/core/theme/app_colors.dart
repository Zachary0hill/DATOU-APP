import 'package:flutter/material.dart';

const kBg = Color(0xFF151515);
const kPrimary = Color(0xFFBB86FC);
const kSecondary = Color(0xFF03DAC5);
const kAccent = Color(0xFFFF00FF);
const kText = Color(0xFFFFFFFF);

// Light mode colors
const kBgLight = Color(0xFFF5F5F5);
const kTextLight = Color(0xFF151515);

extension ColorAlpha on Color {
  Color withOpacityPerc(int p) => withOpacity(p / 100);
}