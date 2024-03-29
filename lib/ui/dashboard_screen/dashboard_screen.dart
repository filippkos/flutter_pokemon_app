import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/const/color_constants.dart';
import 'package:flutter_pokemon_app/generated/l10n.dart';
import 'package:flutter_pokemon_app/models/dashboard_page_model.dart';
import 'package:flutter_pokemon_app/ui/views/pager_view.dart';
import 'package:flutter_pokemon_app/gen/assets.gen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _pagesCount = 3;
  var _currentPage = 0;
  PagerView pager = PagerView(pagesCount: 3);
  bool _isNextButtonVisible = true;
  final _bgImage = Assets.images.dashboard.dashboardBg.image();

  @override
  Widget build(BuildContext context) {
    List<DashboardPageModel> model = [
      DashboardPageModel(
        title: S.of(context).dashboardFirstPageTitle,
        description: S.of(context).dashBoardPageDescription,
        image: Assets.images.dashboard.dashboardShadow.image(),
      ),
      DashboardPageModel(
        title: S.of(context).dashboardSecondPageTitle,
        description: S.of(context).dashBoardPageDescription,
        image: Assets.images.dashboard.dashboardPurple.image(),
      ),
      DashboardPageModel(
        title: S.of(context).dashboardThirdPageTitle,
        description: S.of(context).dashBoardPageDescription,
        image: Assets.images.dashboard.dashboardAll.image(),
      )
    ];

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: PageView.builder(
            controller: pager.pageController,
            scrollDirection: Axis.horizontal,
            itemCount: _pagesCount,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
                _isNextButtonVisible = _currentPage != (_pagesCount - 1);
              });
            },
            itemBuilder: (context, index) {
              return dashboardPage(index, model);
            }),
        bottomNavigationBar: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            barButton(S.of(context).dashboardSkipButtonTitle, () {
              Navigator.of(context).pushNamed('/list');
            }),
            const Spacer(),
            pager,
            const Spacer(),
            Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: _isNextButtonVisible,
              child: barButton(S.of(context).dashboardNextButtonTitle, () {
                pager.pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear);
              }),
            )
          ],
        ));
  }

  Widget barButton(String title, void Function()? onPressed) => TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
          enableFeedback: false
        ),
        child: Text(title, style: Theme.of(context).textTheme.titleMedium),
      );

  Widget dashboardPage(int index, List<DashboardPageModel> model) => Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 100, bottom: 0),
      child: FractionallySizedBox(
          widthFactor: 1 / pager.pageController.viewportFraction,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background),
              child: Column(children: [
                Container(
                  padding: EdgeInsets.only(left: 29, right: 29),
                  child: Stack(
                    children: [_bgImage, model[index].image],
                  ),
                ),
                const Spacer(),
                textSection(index, model),
                const Spacer(),
                SizedBox(
                    height: 65,
                    width: 200,
                    child: Visibility(
                      visible: index == 2 ? true : false,
                      child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0))),
                            backgroundColor:
                                MaterialStateProperty.all(ColorConstants.gold)),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/list');
                        },
                        child: Text(S.of(context).dashboardGoButtonTitle,
                            style: Theme.of(context).textTheme.labelLarge),
                      ),
                    ))
              ]))));

  Widget textSection(int index, List<DashboardPageModel> model) => Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(model[index].title,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontSize: 34),
                  textAlign: TextAlign.center
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              model[index].description,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center
            )
          ],
        ),
      );
}
