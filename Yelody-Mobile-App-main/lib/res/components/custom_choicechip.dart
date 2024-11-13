import 'package:flutter/material.dart';
import 'package:yelody_app/res/colors/app_color.dart';

class CustomChoiceChip extends StatelessWidget {
  final bool selected;
  final String label;
  final ValueChanged<bool> onSelected;

  CustomChoiceChip({
    required this.selected,
    required this.label,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelected(!selected);
      },
      child: Container(
        height: 32,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: selected ? Color(0xFFF6AD00) : Color(0xff313238),
            ),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: ChoiceChip(
          selected: selected,
          label: Text(
            label,
            style: TextStyle(
              color: selected ? AppColor.primaryColor : Colors.white,
              fontSize: 14,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Color(0xff313238),
          selectedColor: Color(0xff313238),
          onSelected: (bool selected) {
            onSelected(selected);
          },
        ),
      ),
    );
  }
}
