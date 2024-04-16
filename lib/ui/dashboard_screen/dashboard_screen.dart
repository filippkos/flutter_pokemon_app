import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/const/color_constants.dart';
import 'package:flutter_pokemon_app/generated/l10n.dart';
import 'package:flutter_pokemon_app/models/dashboard_page_model.dart';
import 'package:flutter_pokemon_app/services/routes/app_route_keys.dart';
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
  PagerView _pager = PagerView(pagesCount: 3);
  bool _isNextButtonVisible = true;
  final _bgImage = Assets.images.dashboard.dashboardBg.image();

  @override
  Widget build(BuildContext context) {
		final s = S.of(context);
    List<DashboardPageModel> model = [
      DashboardPageModel(
        title: s.dashboardFirstPageTitle,
        description: s.dashBoardPageDescription,
        image: Assets.images.dashboard.dashboardShadow.image(),
      ),
      DashboardPageModel(
        title: s.dashboardSecondPageTitle,
        description: s.dashBoardPageDescription,
        image: Assets.images.dashboard.dashboardPurple.image(),
      ),
      DashboardPageModel(
        title: s.dashboardThirdPageTitle,
        description: s.dashBoardPageDescription,
        image: Assets.images.dashboard.dashboardAll.image(),
      )
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: _pageSection(model),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _pageSection(List<DashboardPageModel> model) {
    return PageView.builder(
      controller: _pager.pageController,
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
      },
    );
  }

  Widget _bottomBar() {
		final s = S.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        barButton(s.dashboardSkipButtonTitle, () {
          Navigator.of(context).pushNamed(AppRouteKeys.list);
        }),
        const Spacer(),
        _pager,
        const Spacer(),
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: _isNextButtonVisible,
          child: barButton(s.dashboardNextButtonTitle, () {
            _pager.pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          }),
        ),
      ],
    );
  }

  Widget barButton(String title, void Function()? onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStatePropertyAll(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
        enableFeedback: false,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget dashboardPage(int index, List<DashboardPageModel> model) {
		final theme = Theme.of(context);

    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 100, bottom: 0),
      child: FractionallySizedBox(
        widthFactor: 1 / _pager.pageController.viewportFraction,
        child: DecoratedBox(
          decoration:
              BoxDecoration(color: theme.colorScheme.background),
          child: Column(
            children: [
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        ColorConstants.gold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRouteKeys.list);
                    },
                    child: Text(
                      S.of(context).dashboardGoButtonTitle,
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textSection(int index, List<DashboardPageModel> model) {
		final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            model[index].title,
            style: textTheme.displayMedium
                ?.copyWith(fontSize: 34),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            model[index].description,
            style: textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
