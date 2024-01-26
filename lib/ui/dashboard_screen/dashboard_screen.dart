import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/const/color_constants.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  
  @override
  State<StatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _pageController = PageController(
    initialPage: 0,
    viewportFraction: 1.1
  );
  final _pagesCount = 3;
  var _currentPage = 0;
  final bgImage = const Image(image: AssetImage('assets/images/dashboard/dashboard_bg.png'));
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
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemCount: _pagesCount,
        onPageChanged: (index) { 
          setState(() {
            _currentPage = index;
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
          pagerWidget(),
          const Spacer(),
          _currentPage == 2 ? emptySpace() : nextButton()
        ],
      )
    );
  }

  Widget nextButton() => TextButton(
    onPressed: () {
      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
    }, 
    child: const Text(
      'Next',
      style: TextStyle(
        color: ColorConstants.gold,
        fontFamily: 'Plus Jakarta Sans',
        fontWeight: FontWeight.bold
      ),
    ),
  );

  Widget emptySpace() => const TextButton(
    onPressed: null, 
    child: Text(' ')
  );

  Widget dashboardPage(int index) => Container(
    alignment: Alignment.bottomCenter,
    padding: const EdgeInsets.only(left: 16,right: 16, top: 150, bottom: 10),
    child: FractionallySizedBox(
      widthFactor: 1 / _pageController.viewportFraction,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: ColorConstants.wildSand
        ),
        child: Column(
          children: [
          Stack(
            children: [
              bgImage,
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

  Widget pagerWidget() => Container(
    height: 100,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
        List<Widget>.generate(
          _pagesCount, (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              onTap: () {
                _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _currentPage == index
                            ? ColorConstants.abbey
                            : ColorConstants.wildSand,
                  border: Border.all(
                    color: _currentPage == index
                            ? ColorConstants.abbey
                            : ColorConstants.heather,
                    width: 2
                  ),
                  shape: BoxShape.circle,
                ),
                height: 16.0,
                width: 16.0,
                child: const Center(
                    // Your Widget
                ),
              ),
            ),
          ),
        ),
    ),
  );
}