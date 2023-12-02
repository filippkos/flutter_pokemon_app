import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  
  @override
  State<StatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.separated(
        itemBuilder: (context, index) {
          return dashboardPage(index);
        },
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        padding: EdgeInsets.all(16),
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 12);
        },
      ),
      ),
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BackButton(),
          BackButton()
        ],
      )
    );
  }

  Widget dashboardPage(int index) => Container(
    width: MediaQuery.of(context).size.width - 32,
    height: MediaQuery.of(context).size.height - 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.grey,
    ),
  );

}
