import 'dart:io';
import 'package:eformplugin/doa/lib/BusinessLogic/Registrasi/DataController.dart';
import 'package:eformplugin/doa/lib/BusinessLogic/Registrasi/TabunganController.dart';
import 'package:eformplugin/doa/lib/src/components/card-custom.dart';
import 'package:eformplugin/doa/lib/src/components/content-tabungan.dart';
import 'package:eformplugin/doa/lib/src/components/header-form.dart';
import 'package:eformplugin/doa/lib/src/components/label-text.dart';
import 'package:eformplugin/doa/lib/src/components/leading.dart';
import 'package:eformplugin/doa/lib/src/components/theme_const.dart';
import 'package:eformplugin/doa/lib/src/utility/Routes.dart';
import 'package:eformplugin/doa/lib/src/views/registrasi/register_nomor_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class TabunganIndonesia extends StatefulWidget {
  const TabunganIndonesia({Key? key}) : super(key: key);

  @override
  State<TabunganIndonesia> createState() => _TabunganIndonesiaState();
}

class _TabunganIndonesiaState extends State<TabunganIndonesia>
    with TickerProviderStateMixin {
  late TabController _tabController;
  TabunganController savingsController = Get.put(TabunganController());

  Future getIndexTabungan() async {
    // final preferences = await SharedPreferences.getInstance();
    if (savingsController.prefs == null) {
      savingsController.prefs = Get.find<DataController>().prefs;
    }
    savingsController.activeTabIndex =
        savingsController.prefs!.getInt('indexTabungan') ?? 0;
    _tabController = TabController(
        length: 3, vsync: this, initialIndex: savingsController.activeTabIndex);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getIndexTabungan();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabunganController>(builder: (data) {
      return WillPopScope(
        onWillPop: () async {
          Get.off(() => RegisterNomorPageAlt(),
              transition: Transition.rightToLeft);
          return true;
        },
        child: MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          child: Scaffold(
            appBar: AppBar(
                leading: LeadingIcon(
                  context: context,
                  onPressed: () {
                    Get.off(() => RegisterNomorPageAlt(),
                        transition: Transition.rightToLeft);
                  },
                ),
                elevation: 1,
                backgroundColor: CustomThemeWidget.backgroundColorTop,
                iconTheme: const IconThemeData(color: Colors.black),
                centerTitle: true,
                title: Text("Pilih Jenis Tabungan", style: appBar_Text)),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  headerForm(
                      "assets/images/icons/card_icon.svg",
                      "",
                      Text(
                          "Pilih jenis tabungan yang sesuai dengan kebutuhan Anda.")),
                  CustomCard(
                      stringInterest: taplusDigitalInterestDescription,
                      stringAdditionalCost:
                          additionalCostTaplusDigitalDescription,
                      stringFacility: taplusDigitalFacilityDescription,
                      stringDeposit: taplusDigitalDepositDescription,
                      title: "Taplus Digital",
                      text1:
                          "Memberikan kemudahan, kenyamanan layanan dan banyak keuntungan untuk berbagai aktivitas transaksi perbankan anda dengan penawaran bebas biaya selama 6 bulan pertama.",
                      // text2: "Limit transaksi sampai Rp 10 juta/hari",
                      description: "Setoran Awal Rp 50.000,-",
                      assetImage: AssetImage('assets/images/taplus.png',
                          package: "eformplugin"),
                      onTap: () {
                        data.activeTabIndex = 0;
                        data.saveTabungan();
                        Get.toNamed(Routes().taplusdigital);
                      }),
                  CustomCard(
                      stringInterest: taplusMudaDigitalInterestDescription,
                      stringAdditionalCost:
                          additionalCostTaplusMudaDigitalDescription,
                      stringFacility: taplusMudaDigitalFacilityDescription,
                      stringDeposit: taplusMudaDigitalDepositDescription,
                      title: "Taplus Muda Digital",
                      text1:
                          "Merupakan produk tabungan yang diperuntukan bagi anak muda dengan usia 17 hingga 35 tahun dengan fitur yang lebih fleksibel.",
                      // text2: "Limit transaksi sampai Rp 10 juta/hari",
                      description: "Setoran Awal Rp 50.000,-",
                      assetImage: AssetImage('assets/images/taplus_muda.png',
                          package: "eformplugin"),
                      onTap: () {
                        data.activeTabIndex = 1;
                        data.saveTabungan();
                        Get.toNamed(Routes().taplusmudadigital);
                      }),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: CustomCard(
                        stringInterest: taplusBisnisDigitalInterestDescription,
                        stringAdditionalCost:
                            taplusBisnisDigitalAdditionalCostDescription,
                        stringFacility: taplusBisnisDigitalFacilityDescription,
                        stringDeposit: taplusBisnisDigitalDepositDescription,
                        title: "Taplus Bisnis Digital",
                        text1:
                            "Memberikan kemudahan, kenyamanan layanan dan banyak keuntungan untuk berbagai aktivitas transaksi bisnis anda dengan penawaran bebas biaya selama 6 bulan pertama.",
                        // text2: "Limit transaksi sampai Rp 50 juta/hari",
                        description: "Setoran Awal Rp 50.000,-",
                        assetImage: AssetImage(
                            'assets/images/taplus_bisnis.png',
                            package: "eformplugin"),
                        onTap: () {
                          data.activeTabIndex = 2;
                          data.saveTabungan();
                          Get.toNamed(Routes().taplusbisnisdigital);
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget tab(String text) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
          fontSize: 14,
        ),
      ),
    );
  }

  // _buildTab({required String text, required Color color}) {
  //   return Container(
  //     alignment: Alignment.center,
  //     width: double.infinity,
  //     decoration: ShapeDecoration(
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(10),
  //           topRight: Radius.circular(10),
  //         ),
  //       ),
  //       color: color,
  //     ),
  //     child: Text(text),
  //   );
  // }

  Widget tabTaplusDigital(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(bottom: 50),
        child: Column(
          children: [
            //penjelasan taplus digital
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 3, top: 10, right: 3),
              child: Html(
                data: taplusDigitalDescription,
                style: {
                  "span": Style(
                      color: const Color(0XFFD45D26),
                      fontWeight: FontWeight.bold),
                },
              ),
            ),
            //penjelasan setoran taplus digital
            Container(
              color: const Color(0xFFF5F5F5),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child: Html(
                data: taplusDigitalDepositDescription,
                style: {
                  "td": Style(
                      padding: const EdgeInsets.only(right: 5, bottom: 15)),
                },
              ),
            ),
            //penjelasan fasilitas taplus digital
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(right: 10, top: 10, left: 10),
              child: Html(
                data: taplusDigitalFacilityDescription,
                style: {
                  "ul": Style(padding: const EdgeInsets.only(top: 10)),
                  "li": Style(
                    padding: const EdgeInsets.only(bottom: 5),
                  ),
                },
              ),
            ),
            //penjelasan bunga taplus digital
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Html(
                data: taplusDigitalInterestDescription,
                style: {
                  "tr": Style(
                    padding: const EdgeInsets.only(
                      bottom: 5,
                      right: 40,
                      left: 20,
                    ),
                  ),
                },
              ),
            ),
            if (Platform.isIOS)
              SizedBox(
                height: 50,
              ),
          ],
        ),
      ),
    );
  }

  Widget tabTaplusMudaDigital(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(bottom: 50),
        child: Column(
          children: [
            //penjelasan taplus muda digital
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 3, top: 10, right: 3),
              child: Html(
                data: taplusMudaDigitalDescription,
                style: {
                  "span": Style(
                      color: const Color(0XFFD45D26),
                      fontWeight: FontWeight.bold),
                },
              ),
            ),
            //penjelasan setoran taplus muda digital
            Container(
              color: const Color(0xFFF5F5F5),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child: Html(
                data: taplusMudaDigitalDepositDescription,
                style: {
                  "td": Style(
                      padding: const EdgeInsets.only(right: 5, bottom: 15)),
                },
              ),
            ),
            //penjelasan fasilitas taplus muda digital
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(right: 10, top: 10, left: 10),
              child: Html(
                data: taplusMudaDigitalFacilityDescription,
                style: {
                  "ul": Style(padding: const EdgeInsets.only(top: 10)),
                  "li": Style(
                    padding: const EdgeInsets.only(bottom: 5),
                  ),
                },
              ),
            ),
            //penjelasan bunga taplus muda digital
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Html(
                data: taplusMudaDigitalInterestDescription,
                style: {
                  "tr": Style(
                    padding:
                        const EdgeInsets.only(bottom: 5, right: 40, left: 20),
                  ),
                },
              ),
            ),
            if (Platform.isIOS)
              SizedBox(
                height: 50,
              ),
          ],
        ),
      ),
    );
  }

  Widget tabTaplusBisnisDigital(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(bottom: 50),
        child: Column(
          children: [
            //penjelasan taplus bisnis digital
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 3, top: 10, right: 3),
              child: Html(
                data: taplusBisnisDigitalDescription,
                style: {
                  "span": Style(
                      color: const Color(0XFFD45D26),
                      fontWeight: FontWeight.bold),
                },
              ),
            ),
            //penjelasan setoran taplus bisnis digital
            Container(
              color: const Color(0xFFF5F5F5),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child: Html(
                data: taplusBisnisDigitalDepositDescription,
                style: {
                  "td": Style(
                      padding: const EdgeInsets.only(right: 5, bottom: 15)),
                },
              ),
            ),
            //penjelasan fasilitas taplus bisnis digital
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(right: 10, top: 10, left: 10),
              child: Html(
                data: taplusBisnisDigitalFacilityDescription,
                style: {
                  "ul": Style(padding: const EdgeInsets.only(top: 10)),
                  "li": Style(
                    padding: const EdgeInsets.only(bottom: 5),
                  ),
                },
              ),
            ),
            //penjelasan bunga taplus bisnis digital
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Html(
                data: taplusBisnisDigitalInterestDescription,
                style: {
                  "tr": Style(
                    padding:
                        const EdgeInsets.only(bottom: 5, right: 40, left: 20),
                  ),
                },
              ),
            ),
            if (Platform.isIOS)
              SizedBox(
                height: 50,
              ),
          ],
        ),
      ),
    );
  }
}
