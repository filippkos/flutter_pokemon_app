import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/const/color_constants.dart';

class PagerView extends StatefulWidget {
  final pageController = PageController(initialPage: 0, viewportFraction: 1.1);
  final int pagesCount;

  PagerView({super.key, required this.pagesCount});

  @override
  State<PagerView> createState() => _PagerViewState();
}

class _PagerViewState extends State<PagerView> {
  var currentPage = 0;

  @override
  void dispose() {
    widget.pageController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    widget.pageController.addListener(() {
      setState(() {
        currentPage = widget.pageController.page!.toInt();
      });
    });

    widget.pageController.addListener(() {
      if ((widget.pageController.page ?? 0) % 1 == 0) {
        setState(() {
          currentPage = widget.pageController.page!.toInt();
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(
          widget.pagesCount,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: dot(index),
          ),
        ),
      ),
    );
  }

  Widget dot(int index) {
    return InkWell(
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
      enableFeedback: false,
      onTap: () {
        widget.pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: currentPage == index
              ? ColorConstants.abbey
              : Theme.of(context).colorScheme.background,
          border: Border.all(
              color: currentPage == index
                  ? ColorConstants.abbey
                  : ColorConstants.heather,
              width: 2),
          shape: BoxShape.circle,
        ),
        height: 16.0,
        width: 16.0,
      ),
    );
  }
}