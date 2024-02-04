import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/const/color_constants.dart';
import 'package:flutter_pokemon_app/ui/views/pager_view.dart';

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
  final _bgImage = const Image(image: AssetImage('assets/images/dashboard/dashboard_bg.png'));
  final List<Widget> _images = [
    const Image(image: AssetImage('assets/images/dashboard/dashboard_shadow.png')),
    const Image(image: AssetImage('assets/images/dashboard/dashboard_purple.png')),
    const Image(image: AssetImage('assets/images/dashboard/dashboard_all.png'))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.wildSand,
      body: PageView.builder(
        controller: pager.pageController,
        scrollDirection: Axis.horizontal,
        itemCount: _pagesCount,
        onPageChanged: (index) { 
          setState(() {
            _currentPage = index;
            _isNextButtonVisible = _currentPage == (_pagesCount - 1) ? false : true;
          }); 
        },
        itemBuilder: (context, index) {
          return dashboardPage(index);
        }
      ),
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/list');
            },
            child: const Text(
              'Skip',
              style: TextStyle(
                color: ColorConstants.gold,
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.bold,
              ),
            )
          ),
          const Spacer(),
          pager,
          const Spacer(),
          Visibility(
            maintainSize: true, 
            maintainAnimation: true,
            maintainState: true,
            visible: _isNextButtonVisible,
            child: nextButton(),
          )
        ],
      )
    );
  }

  Widget nextButton() => TextButton(
    onPressed: () {
      pager.pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
    }, 
    style: ButtonStyle(enableFeedback: false),
    child: const Text(
      'Next',
      style: TextStyle(
        color: ColorConstants.gold,
        fontFamily: 'Plus Jakarta Sans',
        fontWeight: FontWeight.bold
      ),
    ),
  );

  Widget dashboardPage(int index) => Container(
    alignment: Alignment.bottomCenter,
    padding: const EdgeInsets.only(left: 16,right: 16, top: 150, bottom: 10),
    child: FractionallySizedBox(
      widthFactor: 1 / pager.pageController.viewportFraction,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: ColorConstants.wildSand
        ),
        child: Column(
          children: [
          Stack(
            children: [
              _bgImage,
              _images[index]
            ],
          ),
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
                      borderRadius: BorderRadius.circular(32.0)
                    )
                  ),
                  backgroundColor: MaterialStateProperty.all(ColorConstants.gold)
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/list');
                },
                child: const Text(
                  'GO!',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    backgroundColor: ColorConstants.gold
                  ),
                ),
              ),
            )
          )
          ]
        )
      )
    )
  );
}