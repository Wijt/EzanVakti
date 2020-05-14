import 'package:EzanVakti/models/onboarding_model.dart' show OnboardingModel;
import 'package:EzanVakti/ui/helper/AppColors.dart' show AppColors;
import 'package:EzanVakti/ui/helper/AppIcons.dart';
import 'package:EzanVakti/ui/helper/AppStrings.dart' show AppStrings;
import 'package:EzanVakti/ui/styles/appBorderRadius.dart' show AppBorderRadius;
import 'package:EzanVakti/ui/widgets/appLogo.dart';
import 'package:EzanVakti/ui/widgets/helper.dart' show Helper;
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List<OnboardingModel> pages = [
    OnboardingModel(
      title: AppStrings.onboardingTitle1,
      description: AppStrings.onboardingDescription1,
      icon: AppLogo(color: AppColors.colorLightSecondary, height: 50),
    ),
    OnboardingModel(
      title: AppStrings.onboardingTitle2,
      description: AppStrings.onboardingDescription2,
      icon: Icon(AppIcons.location, size: 50, color: AppColors.colorLightSecondary),
    ),
    OnboardingModel(
      title: AppStrings.onboardingTitle3,
      description: AppStrings.onboardingDescription3,
      icon: Icon(AppIcons.notification, size: 50, color: AppColors.colorLightSecondary),
    ),
  ];

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < pages.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  List<Widget> buildOnboardingPages() {
    final children = <Widget>[];
    for (int i = 0; i < pages.length; i++) {
      children.add(_showPageData(pages[i]));
    }
    return children;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: 8.0,
      decoration: _buildIndicatorBoxDecoration(isActive),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: _buildBoxDecoration,
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Helper.sizedBoxH20,
                  Container(
                    height: 580.0,
                    child: PageView(
                        physics: ClampingScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (int page) => setState(() => _currentPage = page),
                        children: buildOnboardingPages()),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: _buildPageIndicator()),
                  _currentPage != pages.length - 1
                      ? buildButton(context, AppStrings.next, Icons.arrow_forward)
                      : buildButton(context, AppStrings.start, Icons.check),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildButton(BuildContext context, String _label, IconData _icon) {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomRight,
        child: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: FloatingActionButton.extended(
            shape: AppBorderRadius.fabRadius,
            icon: Icon(_icon, color: Colors.white),
            onPressed: () => _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeOutSine),
            label: Text(_label, style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget _showPageData(OnboardingModel page) {
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              decoration: Helper.buildOnboardingBoxDecoration,
              height: 500.0,
              width: 327.0,
              child: Padding(
                padding: const EdgeInsets.only(top: 68.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        buildLoadingContainer(238, Theme.of(context).primaryColor.withOpacity(0.14)),
                        buildLoadingContainer(192, Theme.of(context).primaryColor.withOpacity(0.29)),
                        buildLoadingContainer(140, Theme.of(context).primaryColor),
                        Container(child: page.icon, height: 50),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Helper.sizedBoxH30,
                        Text(page.title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline4),
                        Helper.sizedBoxH10,
                        Text(page.description, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline5),
                      ],
                    ),
                    Helper.sizedBoxH80,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildLoadingContainer(double _size, Color _color) => Container(height: _size, width: _size, decoration: _buildLoadingBoxDecoration(_color));

  BoxDecoration _buildLoadingBoxDecoration(Color _color) => BoxDecoration(color: _color, shape: BoxShape.circle);

  BoxDecoration _buildIndicatorBoxDecoration(bool isActive) =>
      BoxDecoration(color: isActive ? AppColors.colorStarted : AppColors.colorStartedShadow, borderRadius: BorderRadius.all(Radius.circular(12)));

  BoxDecoration get _buildBoxDecoration => BoxDecoration(
      gradient: RadialGradient(center: const Alignment(0.0, -0.1), radius: 0.77, colors: [AppColors.colorStartedShadow, Colors.white], stops: [0.1, 1.0]));
}
