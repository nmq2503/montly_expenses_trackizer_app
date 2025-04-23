import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trackizer/features/add_subscription/add_subscription_view.dart';

import '../../common/color_extension.dart';
import '../calender/calender_view.dart';
import '../card/cards_view.dart';
import '../home/home_view.dart';
import '../spending_budgets/spending_budgets_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selectTab = 0;
  PageStorageBucket pageStorageBucket = PageStorageBucket();
  Widget currentTabView = const HomeView();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.gray,
      body: Stack(children: [
        PageStorage(bucket: pageStorageBucket, child: currentTabView),
        WillPopScope(
          onWillPop: () async {
            // return false;
            return _onWillPop(context);
          },
          child: SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset("assets/img/bottom_bar_bg.png"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectTab = 0;
                                    currentTabView = const HomeView();
                                  });
                                },
                                icon: Image.asset(
                                  "assets/img/home.png",
                                  width: 20,
                                  height: 20,
                                  color: selectTab == 0
                                      ? TColor.white
                                      : TColor.gray30,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectTab = 1;
                                    currentTabView =
                                        const SpendingBudgetsView();
                                  });
                                },
                                icon: Image.asset(
                                  "assets/img/budgets.png",
                                  width: 20,
                                  height: 20,
                                  color: selectTab == 1
                                      ? TColor.white
                                      : TColor.gray30,
                                ),
                              ),
                              const SizedBox(
                                width: 50,
                                height: 50,
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectTab = 2;
                                    currentTabView = CalenderView();
                                  });
                                },
                                icon: Image.asset(
                                  "assets/img/calendar.png",
                                  width: 20,
                                  height: 20,
                                  color: selectTab == 2
                                      ? TColor.white
                                      : TColor.gray30,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectTab = 3;
                                    currentTabView = CardsView();
                                  });
                                },
                                icon: Image.asset(
                                  "assets/img/creditcards.png",
                                  width: 20,
                                  height: 20,
                                  color: selectTab == 3
                                      ? TColor.white
                                      : TColor.gray30,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AddSubScriptionView()));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: TColor.secondary.withOpacity(0.25),
                                blurRadius: 10,
                                offset: const Offset(0, 4))
                          ], borderRadius: BorderRadius.circular(50)),
                          child: Image.asset(
                            "assets/img/center_btn.png",
                            width: 55,
                            height: 55,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
