import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:trackizer/routes/app_routes.dart';
import 'package:trackizer/utils/local_images.dart';

import '../../../common/color_extension.dart';
import '../../calender/calender_view.dart';
import '../../card/cards_view.dart';
import '../../home/home_view.dart';
import '../../spending_budgets/spending_budgets_view.dart';
import '../controllers/main_tab_controller.dart';

class MainTabView extends GetView<MainTabController> {
  const MainTabView({super.key});

  Future<bool> _onWillPop(BuildContext context) async {
    bool? shouldExit = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        contentTextStyle: const TextStyle(color: Colors.white70),
        title: const Text('Xác nhận thoát'),
        content: const Text('Bạn có chắc chắn muốn thoát ứng dụng không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: TextButton.styleFrom(foregroundColor: Colors.grey[300]),
            child: const Text('Không'),
          ),
          TextButton(
            onPressed: () {
              if (Platform.isAndroid || Platform.isIOS) {
                exit(0); // Thoát hẳn
              } else {
                SystemNavigator.pop();
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
            child: const Text('Thoát'),
          ),
        ],
      ),
    );

    return shouldExit ?? false;
  }

  List<Widget> _buildScreens() {
    return [
      const HomeView(),
      const SpendingBudgetsView(),
      Container(),
      const CalenderView(),
      const CardsView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const AnimatedNavItem(
          asset: LocalImage.home,
          title: "Trang chủ",
          isActive: true,
        ),
        inactiveIcon: const AnimatedNavItem(
          asset: LocalImage.home,
          title: "Trang chủ",
          isActive: false,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const AnimatedNavItem(
          asset: LocalImage.budget,
          title: "Ngân sách",
          isActive: true,
        ),
        inactiveIcon: const AnimatedNavItem(
          asset: LocalImage.budget,
          title: "Ngân sách",
          isActive: false,
        ),
      ),
      // PersistentBottomNavBarItem(
      //   icon: const Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      //   inactiveIcon: const Icon(
      //     Icons.add,
      //     color: Colors.grey,
      //   ),
      //   activeColorPrimary: TColor.secondary,
      //   inactiveColorPrimary: Colors.grey,
      // ),
      PersistentBottomNavBarItem(
        icon: GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.addSubscriptionView);
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
        inactiveIcon: GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.addSubscriptionView);
          },
          child: const SizedBox(
            width: 60,
            height: 50,
            child: Icon(
              Icons.add,
              color: Colors.grey,
            ),
          ),
        ),
        activeColorPrimary: TColor.secondary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const AnimatedNavItem(
          asset: LocalImage.calendar,
          title: "Lịch",
          isActive: true,
        ),
        inactiveIcon: const AnimatedNavItem(
          asset: LocalImage.calendar,
          title: "Lịch",
          isActive: false,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const AnimatedNavItem(
          asset: LocalImage.creditCard,
          title: "Thẻ",
          isActive: true,
        ),
        inactiveIcon: const AnimatedNavItem(
          asset: LocalImage.creditCard,
          title: "Thẻ",
          isActive: false,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller.persistentTabController,
      onWillPop: (_) => _onWillPop(context),
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      navBarHeight: 60,
      backgroundColor: TColor.gray60, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      onItemSelected: (index) {
        if (index == 2) return;
        // controller.changeTabIndex(index);
        controller.onTabSelected(index);
      },
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 600),
      ),
      navBarStyle:
          NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }
}

class AnimatedNavItem extends StatelessWidget {
  final String asset;
  final String title;
  final bool isActive;

  const AnimatedNavItem({
    required this.asset,
    required this.title,
    required this.isActive,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isActive ? 25 : 20,
            width: isActive ? 25 : 20,
            child: Image.asset(
              asset,
              color: isActive ? Colors.white : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              fontSize: isActive ? 10 : 8,
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.white : Colors.grey,
            ),
            child: Text(title),
          ),
        ],
      ),
    );
  }
}
