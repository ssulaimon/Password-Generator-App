import 'package:flutter/material.dart';
import 'package:flutterleaner/colors.dart';

class ActionWidget extends StatelessWidget {
  final Icon icon;
  final String title;
  final void Function()? onclicked;
  const ActionWidget(
      {super.key, required this.icon, required this.title, this.onclicked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onclicked!(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: MyColors.primaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(children: [
          icon,
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style:
                const TextStyle(color: MyColors.secondaryColor, fontSize: 20.0),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          const Icon(
            Icons.arrow_forward,
            color: MyColors.secondaryColor,
            size: 40.0,
          ),
        ]),
      ),
    );
  }
}
