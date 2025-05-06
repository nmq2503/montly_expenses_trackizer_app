import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:trackizer/common/color_extension.dart';
import 'package:trackizer/common_widget/primary_button.dart';
import 'package:trackizer/common_widget/round_textfield.dart';
import 'package:trackizer/features/add_subscription/controllers/add_subscrition_controller.dart';

import '../../../common_widget/custom_calendar_picker_dialog.dart';
import '../../../common_widget/image_button.dart';

final today = DateUtils.dateOnly(DateTime.now());

class AddSubScriptionView extends GetView<AddSubScriptionController> {
  const AddSubScriptionView({super.key});

  // List<DateTime?> _dialogCalendarPickerValue = [
  //   DateTime(2021, 8, 10),
  //   DateTime(2021, 8, 13),
  // ];
  // List<DateTime?> _singleDatePickerValueWithDefaultValue = [
  //   DateTime.now().add(const Duration(days: 1)),
  // ];
  // List<DateTime?> _multiDatePickerValueWithDefaultValue = [
  //   DateTime(today.year, today.month, 1),
  //   DateTime(today.year, today.month, 5),
  //   DateTime(today.year, today.month, 14),
  //   DateTime(today.year, today.month, 17),
  //   DateTime(today.year, today.month, 25),
  // ];
  // List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
  //   DateTime(1999, 5, 6),
  //   DateTime(1999, 5, 21),
  // ];

  // List<DateTime?> _rangeDatePickerWithActionButtonsWithValue = [
  //   DateTime.now(),
  //   DateTime.now().add(const Duration(days: 5)),
  // ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: TColor.gray70.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.back();
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
                              "THÊM MỚI",
                              style: TextStyle(
                                color: TColor.gray30,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Thêm\nđăng ký mới".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: TColor.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: media.width,
                      height: media.width * 0.6,
                      child: CarouselSlider.builder(
                        options: CarouselOptions(
                          autoPlay: false,
                          aspectRatio: 1,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          viewportFraction: 0.65,
                          enlargeFactor: 0.4,
                          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                          onPageChanged: (index, reason) {
                            controller.setSelectedIndex(index);
                          },
                        ),
                        itemCount: controller.subArr.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          var sObj = controller.subArr[itemIndex] as Map? ?? {};

                          return Container(
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  sObj["icon"],
                                  width: media.width * 0.4,
                                  height: media.width * 0.4,
                                  fit: BoxFit.fitHeight,
                                ),
                                const Spacer(),
                                Text(
                                  sObj["name"],
                                  style: TextStyle(
                                      color: TColor.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: RoundTextField(
                title: "Ghi chú",
                titleAlign: TextAlign.center,
                controller: controller.txtDescription,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Tiền hàng tháng",
                    style: TextStyle(
                        color: TColor.gray40,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ImageButton(
                        image: "assets/img/minus.png",
                        onPressed: () {},
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Text(
                            //   // "\$${amountVal.toStringAsFixed(2)}",
                            //   "${amountVal.toStringAsFixed(2)} VNĐ",
                            //   style: TextStyle(
                            //       color: TColor.white,
                            //       fontSize: 35,
                            //       fontWeight: FontWeight.w700),
                            // ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: controller.amountController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter
                                            .digitsOnly, // CHẶN ký tự không phải số
                                      ],
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Nhập số tiền",
                                        hintStyle: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      style: TextStyle(
                                        color: TColor.white,
                                        fontSize: 35,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    "VNĐ",
                                    style: TextStyle(
                                      color: TColor.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: 150,
                              height: 1,
                              color: TColor.gray70,
                            )
                          ],
                        ),
                      ),
                      ImageButton(
                        image: "assets/img/plus.png",
                        onPressed: () {},
                      )
                    ],
                  ),
                ],
              ),
            ),
            CustomCalendarPickerDialog(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PrimaryButton(
                title: "THÊM ĐĂNG KÝ",
                onPressed: () {
                  controller.saveSubscription();
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
