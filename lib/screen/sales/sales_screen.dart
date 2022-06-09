import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:untitled/controller/sales/sales_controller.dart';
import 'package:untitled/screen/sales/chart.dart';
import 'package:untitled/widgets/app_bar.dart';

class SalesScreen extends StatelessWidget {
  final SalesController controller = Get.put(SalesController());

  SalesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double titleFontSize =
        MediaQuery.of(context).orientation == Orientation.portrait ? 15 : 15;
    return FutureBuilder(
        future: controller.getSales(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: appBar(title: "Sales", centerTitle: true),
              body: ListView(
                shrinkWrap: true,
                children: [
                  Text("Total Sales",
                      style: TextStyle(fontSize: titleFontSize.sp)),
                  ChartWidget(
                    data: controller.monthSales,
                    maxValue: controller.maxSales,
                  ),
                  Text("Created Episodes",
                      style: TextStyle(fontSize: titleFontSize.sp)),
                  ChartWidget(
                    data: controller.createdEpisodes,
                    maxValue: controller.maxCreatedEpisodes,
                  ),
                  Text("Created Series",
                      style: TextStyle(fontSize: titleFontSize.sp)),
                  ChartWidget(
                    data: controller.createdSeries,
                    maxValue: controller.maxCreatedSeries,
                  )
                ],
              ),
            );
          } else if (snapshot.hasError)
            return Column(
              children: [
                Text(
                  snapshot.error.toString(),
                ),
              ],
            );
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
