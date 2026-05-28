import 'package:flutter/material.dart';

Widget horizontalListView({
  required List<String> text,
  required VoidCallback onTap,
  required int index,
  required int selectedItem,
}) {
  final bool isSelected = selectedItem == index;

  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFFF06292)
            : const Color(0xFFFFF0F5),

        borderRadius: BorderRadius.circular(30),

        boxShadow: [
          BoxShadow(
            color: isSelected
                ? Colors.pink.withValues(alpha: 0.4)
                : Colors.pink.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Text(
        text[index],
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: isSelected ? Colors.white : Colors.black87,
        ),
      ),
    ),
  );
}
