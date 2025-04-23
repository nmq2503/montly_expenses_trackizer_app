import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackizer/features/settings/controllers/settings_view_controller.dart';

import '../../../common/color_extension.dart';
import '../../../common_widget/icon_item_row.dart';

class SettingsView extends GetView<SettingsViewController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SafeArea(
        child: Obx(
          () {
            return controller.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: TColor.primary,
                      strokeWidth: 2,
                    ),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Image.asset("assets/img/back.png",
                                        width: 25,
                                        height: 25,
                                        color: TColor.gray30))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Settings",
                                  style: TextStyle(
                                      color: TColor.gray30, fontSize: 16),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/img/u1.png",
                              width: 70,
                              height: 70,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Code For Any",
                              style: TextStyle(
                                  color: TColor.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "codeforany@gmail.com",
                              style: TextStyle(
                                  color: TColor.gray30,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: TColor.border.withOpacity(0.15),
                              ),
                              color: TColor.gray60.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              "Edit profile",
                              style: TextStyle(
                                  color: TColor.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 8),
                                child: Text(
                                  "Cài đặt chung",
                                  style: TextStyle(
                                      color: TColor.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: TColor.border.withOpacity(0.1),
                                  ),
                                  color: TColor.gray60.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  children: [
                                    IconItemRow(
                                      title: "Security",
                                      icon: "assets/img/face_id.png",
                                      value: "FaceID",
                                    ),
                                    IconItemSwitchRow(
                                      title: "iCloud Sync",
                                      icon: "assets/img/icloud.png",
                                      value: false,
                                      didChange: (newVal) {
                                        // setState(() {
                                        //   // isActive = newVal;
                                        // });
                                      },
                                    ),
                                    IconSvgItemRow(
                                      title: "Đăng xuất",
                                      icon: "assets/icons/logout_icon.svg",
                                      onTap: () async {
                                        controller.logOut();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 8),
                                child: Text(
                                  "My subscription",
                                  style: TextStyle(
                                      color: TColor.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: TColor.border.withOpacity(0.1),
                                  ),
                                  color: TColor.gray60.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  children: [
                                    IconItemRow(
                                      title: "Sorting",
                                      icon: "assets/img/sorting.png",
                                      value: "Date",
                                    ),
                                    IconItemRow(
                                      title: "Summary",
                                      icon: "assets/img/chart.png",
                                      value: "Average",
                                    ),
                                    IconItemRow(
                                      title: "Default currency",
                                      icon: "assets/img/money.png",
                                      value: "USD (\$)",
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 8),
                                child: Text(
                                  "Appearance",
                                  style: TextStyle(
                                      color: TColor.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: TColor.border.withOpacity(0.1),
                                  ),
                                  color: TColor.gray60.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  children: [
                                    IconItemRow(
                                      title: "App icon",
                                      icon: "assets/img/app_icon.png",
                                      value: "Default",
                                    ),
                                    IconItemRow(
                                      title: "Theme",
                                      icon: "assets/img/light_theme.png",
                                      value: "Dark",
                                    ),
                                    IconItemRow(
                                      title: "Font",
                                      icon: "assets/img/font.png",
                                      value: "Inter",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
