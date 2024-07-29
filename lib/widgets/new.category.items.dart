import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:flutter/material.dart';

class NewCategoryItems extends StatelessWidget {
  final Function() onTap;
  final bool active;
  final String name;

  const NewCategoryItems({super.key, required this.onTap, required this.active, required this.name});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        constraints: BoxConstraints(minWidth: width * .12),
        decoration: BoxDecoration(
          color: active ? ColorConstants.colorBlackTwo : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.only(right: 10),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
        child: Text(
          name,
          style: TextHelper.smallTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : ColorConstants.colorBlackTwo,
          ),
        ),
      ),
    );
  }
}
