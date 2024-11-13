import 'package:flutter/material.dart';
import 'package:yelody_app/res/colors/app_color.dart';

class CustomAddSongChoiceChip extends StatefulWidget {
  final bool selected;
  final String label;
  final ValueChanged<bool> onSelected;

  CustomAddSongChoiceChip({
    required this.selected,
    required this.label,
    required this.onSelected,
  });

  @override
  _CustomAddSongChoiceChipState createState() => _CustomAddSongChoiceChipState();
}

class _CustomAddSongChoiceChipState extends State<CustomAddSongChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelected(!widget.selected);
      },
      child: Container(
        height: 38,
        child: IntrinsicWidth(
          child: Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: widget.selected ? Color(0xFFF6AD00) : Color(0xff313238),
                ),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: ChoiceChip(
              selected: widget.selected,
              label: Text(
                widget.label,
                style: TextStyle(
                  color: widget.selected ? AppColor.primaryColor : Colors.white,
                  fontSize: 14,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                ),
              ),
              backgroundColor: Color(0xff313238),
              selectedColor: Color(0xff313238),
              onSelected: (bool selected) {
                widget.onSelected(selected);
              },
            ),
          ),
        ),
      ),
    );
  }
}
