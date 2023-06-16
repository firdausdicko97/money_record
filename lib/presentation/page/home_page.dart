import 'package:d_chart/d_chart.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_record/config/app_asset.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/config/session.dart';
import 'package:money_record/presentation/page/auth/login_page.dart';
import '../controller/c_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cUser = Get.put(CUser());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //membuat menu drawer
        endDrawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                margin: EdgeInsets.only(bottom: 0),
                padding: EdgeInsets.fromLTRB(20, 16, 16, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //row drawer yang berisi foto, nama, email dan button logout
                    Row(
                      children: [
                        Image.asset(AppAsset.profile),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() {
                                return Text(cUser.data.name ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ));
                              }),
                              Obx(() {
                                return Text(cUser.data.email ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                    ));
                              })
                            ],
                          ),
                        ),
                      ],
                    ),
                    Material(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        onTap: () {
                          Session.clearUser();
                          Get.off(() => const LoginPage());
                        },
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                          child: Text(
                            'Logout',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //drawer menus
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.add),
                horizontalTitleGap: 0,
                title: const Text('Tambah Baru'),
                trailing: const Icon(Icons.navigate_next),
              ),
              const Divider(height: 1),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.south_west),
                horizontalTitleGap: 0,
                title: const Text('Pemasukan'),
                trailing: const Icon(Icons.navigate_next),
              ),
              const Divider(height: 1),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.north_east),
                horizontalTitleGap: 0,
                title: const Text('Pengeluaran'),
                trailing: const Icon(Icons.navigate_next),
              ),
              const Divider(height: 1),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.history),
                horizontalTitleGap: 0,
                title: const Text('Riwayat'),
                trailing: const Icon(Icons.navigate_next),
              ),
              const Divider(height: 1),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
              child: Row(
                children: [
                  Image.asset(AppAsset.profile),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hi, ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Obx(() {
                          return Text(cUser.data.name ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ));
                        })
                      ],
                    ),
                  ),
                  Builder(builder: (ctx) {
                    return Material(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColor.chart,
                      child: InkWell(
                          onTap: () {
                            Scaffold.of(ctx).openEndDrawer();
                          },
                          borderRadius: BorderRadius.circular(4),
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.menu,
                              color: AppColor.primary,
                            ),
                          )),
                    );
                  })
                ],
              ),
            ),
            Expanded(
                //content homepage
                child: ListView(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
              children: [
                Text(
                  "Pengeluaran Hari Ini",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                DView.spaceHeight(),
                cardToday(context),
                DView.spaceHeight(20),
                Center(
                  child: Container(
                    height: 5,
                    width: 80,
                    decoration: BoxDecoration(
                      color: AppColor.bg,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                DView.spaceHeight(30),
                Text(
                  "Pengeluaran Minggu Ini",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                DView.spaceHeight(),
                weekly(),
                DView.spaceHeight(30),
                Text(
                  "Perbandingan Bulan Ini",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                DView.spaceHeight(30),
                monthly(context),
              ],
            )),
          ],
        ));
  }

  Row monthly(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.5,
          child: Stack(
            children: [
              DChartPie(
                data: [
                  {'domain': 'Flutter', 'measure': 28},
                  {'domain': 'React Native', 'measure': 27},
                ],
                fillColor: (pieData, index) => Colors.purple,
                donutWidth: 30,
                labelColor: Colors.white,
              ),
              Center(child: const Text('60%')),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 16,
                  width: 16,
                  color: AppColor.primary,
                ),
                DView.spaceWidth(8),
                const Text('Pemasukan')
              ],
            ),
            DView.spaceHeight(8),
            Row(
              children: [
                Container(
                  height: 16,
                  width: 16,
                  color: AppColor.chart,
                ),
                DView.spaceWidth(8),
                const Text('Pengeluaran'),
              ],
            ),
            DView.spaceHeight(20),
            Text('Pemasukan'),
            Text('lebih besar 20%'),
            Text('dari pengeluaran'),
            DView.spaceHeight(10),
            Text("Atau setra: "),
            Text(
              'Rp. 20.000,00',
              style: TextStyle(
                  color: AppColor.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }

  AspectRatio weekly() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: DChartBar(
        data: [
          {
            'id': 'Bar',
            'data': [
              {'domain': '2020', 'measure': 3},
              {'domain': '2021', 'measure': 4},
              {'domain': '2022', 'measure': 6},
              {'domain': '2023', 'measure': 0.3},
            ],
          },
        ],
        domainLabelPaddingToAxisLine: 16,
        axisLineTick: 2,
        axisLinePointTick: 2,
        axisLinePointWidth: 10,
        axisLineColor: AppColor.primary,
        measureLabelPaddingToAxisLine: 16,
        barColor: (barData, index, id) => AppColor.primary,
        showBarValue: true,
      ),
    );
  }

  Material cardToday(BuildContext context) {
    return Material(
      //card-box
      borderRadius: BorderRadius.circular(16),
      elevation: 4,
      color: AppColor.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
            child: Text(
              'RP. 500.000',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.bold, color: AppColor.secondary),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
            child: Text(
              '+20% dibanding kemarin',
              style: TextStyle(color: AppColor.bg, fontSize: 16),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 0, 0, 16),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'Selengkapnya',
                  style: TextStyle(color: AppColor.primary),
                ),
                Icon(
                  Icons.navigate_next,
                  color: AppColor.primary,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
