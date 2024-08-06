import 'package:flutter/material.dart';

// Import utilities
import '/utils/colors.dart';

class MainContainer extends StatelessWidget {
  final bool useBack;
  final VoidCallback? backFunction;

  final bool useBackground;
  final ImageProvider? backgroundImage;

  final Widget child;

  const MainContainer(
      {super.key,
      this.useBack = true,
      this.backFunction,
      this.useBackground = false,
      this.backgroundImage,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: useBackground
                  ? DecorationImage(
                      image: backgroundImage ??
                          const AssetImage("assets/backgrounds/login.png"),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter)
                  : null,
              color: ThemeColor.background,
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: <Widget>[
                  if (useBack)
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            color: Colors.white,
                            onPressed: backFunction ??
                                () {
                                  Navigator.pop(context);
                                },
                          )
                        ],
                      ),
                    ),
                  Container(child: child)
                ],
              ),
            )));
  }
}
