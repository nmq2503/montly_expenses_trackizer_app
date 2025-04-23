import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../common/color_extension.dart';

class IconItemRow extends StatelessWidget {
  final String title;
  final String icon;
  final String value;
  final Function()? onTap;
  const IconItemRow(
      {super.key,
      required this.title,
      required this.icon,
      required this.value,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 20,
              height: 20,
              color: TColor.gray20,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: TextStyle(
                  color: TColor.white, fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: TColor.gray30,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Image.asset("assets/img/next.png",
                width: 12, height: 12, color: TColor.gray30)
          ],
        ),
      ),
    );
  }
}

class IconSvgItemRow extends StatelessWidget {
  final String title;
  final String icon;
  final String? value;
  final Function()? onTap;
  const IconSvgItemRow(
      {super.key,
      required this.title,
      required this.icon,
      this.value,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                TColor.gray20,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: TextStyle(
                  color: TColor.white, fontSize: 14, fontWeight: FontWeight.w600),
            ),
            if (value != null)
            Expanded(
              child: Text(
                value!,
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: TColor.gray30,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
            if (value != null)
            const SizedBox(
              width: 8,
            ),
            if (value != null)
            Image.asset("assets/img/next.png",
                width: 12, height: 12, color: TColor.gray30)
          ],
        ),
      ),
    );
  }
}


class IconItemSwitchRow extends StatelessWidget {
  final String title;
  final String icon;
  final bool value;
  final Function(bool) didChange;

  const IconItemSwitchRow(
      {super.key,
      required this.title,
      required this.icon,
      required this.didChange,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 20,
            height: 20,
            color: TColor.gray20,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: TextStyle(
                color: TColor.white, fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          const SizedBox(
            width: 8,
          ),
          CupertinoSwitch(value: value, onChanged: didChange)
        ],
      ),
    );
  }
}
