import 'package:flutter/material.dart';
import 'package:salla_admin/Core/widgets/subtitle_text.dart';

class DashboardButton extends StatelessWidget {
  const DashboardButton(
      {key,
      required this.image,
      required this.subTitle,
      required this.onPressed})
      : super(key: key);

  final String image, subTitle;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: size.width * 0.4,
        width: size.width * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.amber,
          ),
        ),
        child: InkWell(
          onTap: onPressed,
          splashColor: Colors.amber,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 65,
                width: 65,
              ),
              const SizedBox(
                height: 15,
              ),
              SubtitleTextWidget(label: subTitle),
            ],
          ),
        ),
      ),
    );
  }
}
