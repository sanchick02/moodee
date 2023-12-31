import 'package:flutter/material.dart';

class TopBarLogoNotif extends StatelessWidget {
  const TopBarLogoNotif({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          "lib/assets/images/Logo.png",
          width: 100,
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            "lib/assets/icons/bell.png",
            width: 30,
          ),
        ),
      ],
    );
  }
}
