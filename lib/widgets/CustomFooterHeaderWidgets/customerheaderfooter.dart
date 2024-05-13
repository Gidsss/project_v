import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/screens/customer/explore/explorescreen.dart';
import 'package:project_v/screens/customer/orders/ordersscreen.dart';
import 'package:project_v/screens/customer/profile/profilescreen.dart';
import 'package:project_v/screens/customer/homescreen.dart';
import 'package:project_v/screens/customer/appointment/schedulescreen.dart';
import 'package:project_v/screens/customer/chat/chatscreen.dart';
import 'package:project_v/screens/customer/wishlistscreen.dart';
import 'package:project_v/screens/customer/notifications/notificationsscreen.dart';

import '../../screens/customer/cart/cartscreen.dart';

class HeaderFooter extends StatefulWidget {
  final Widget? body;
  final bool hasDrawer;
  final String? title;
  final List<bool> buttonStatus;
  final BuildContext context;
  final bool mainHeader;
  final bool hasFloatbar;
  final Widget? floatbar;
  final bool isProfileFloatbar;
  final Widget? profileFloatbar;

  const HeaderFooter({
    super.key,
    this.floatbar,
    this.hasFloatbar = false,
    this.mainHeader = true,
    this.hasDrawer = false,
    required this.body,
    required this.title,
    required this.context,
    required this.buttonStatus,
    this.isProfileFloatbar = false,
    this.profileFloatbar,
  });

  @override
  State<HeaderFooter> createState() => _HeaderFooterState();
}

class _HeaderFooterState extends State<HeaderFooter>
    with TickerProviderStateMixin {
  late TabController _scheduleTabController;
  late TabController _ordersTabController;
  late TabController _profileTabController;

  @override
  void initState() {
    super.initState();
    _scheduleTabController = TabController(length: 2, vsync: this);
    _ordersTabController = TabController(length: 2, vsync: this);
    _profileTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _scheduleTabController.dispose();
    _ordersTabController.dispose();
    _profileTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.mainHeader
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                buildmainHeader(context),
                Expanded(
                  child: Container(
                    child: widget.body,
                  ),
                ),
                buildFooter(widget.buttonStatus, widget.context),
              ],
            ),
          )
        : DefaultTabController(
            length: 2,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                centerTitle: true,
                title: Image.asset(
                  AppConstants.logoImagePath,
                  width: 40,
                  height: 40,
                ),
                bottom: widget.title == "Schedule"
                    ? TabBar(
                        controller: _scheduleTabController,
                        labelColor: Colors.black,
                        indicatorColor: Colors.black,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: const [
                          Tab(text: "Upcoming"),
                          Tab(text: "Completed"),
                        ],
                      )
                    : widget.title == "Orders"
                        ? TabBar(
                            controller: _ordersTabController,
                            labelColor: Colors.black,
                            indicatorColor: Colors.black,
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: const [
                              Tab(text: "Active"),
                              Tab(text: "Completed"),
                            ],
                          )
                        : TabBar(
                            controller: _profileTabController,
                            labelColor: Colors.black,
                            indicatorColor: Colors.black,
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: const [
                              Tab(text: "Profile"),
                              Tab(text: "Settings"),
                            ],
                          ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      controller: widget.title == "Schedule"
                          ? _scheduleTabController
                          : widget.title == "Orders"
                              ? _ordersTabController
                              : _profileTabController,
                      children: [
                        Container(
                          child: widget.body,
                        ),
                        Container(
                          child: widget.body,
                        ),
                      ],
                    ),
                  ),
                  _buildSpacing(), // Call the method to build spacing widget
                  buildFooter(widget.buttonStatus, widget.context),
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: widget.hasFloatbar
                  ? (widget.isProfileFloatbar
                      ? widget.profileFloatbar
                      : widget.floatbar)
                  : null,

            ),
          );
  }

  Widget _buildSpacing() {
    if (widget.title == "Schedule") {
      return const SizedBox(height: 55); // Height for Schedule
    } else {
      return const SizedBox(height: 0); // Height for Orders and Profile
    }
  }
}
  


  Widget buildmainHeader(BuildContext context) {
    return Material(
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ], color: Colors.white),
          child: Expanded(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          AppConstants.logoImagePath,
                          width: 60,
                          height: 60,
                        ),
                        const SizedBox(width: 8),
                        const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Valdopeña",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Times New Roman",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                              Text("Opticals",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Times New Roman",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                      ],
                    ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    // headerIconButton(context, Icons.mark_unread_chat_alt_outlined, const ChatScreen()),
                    headerIconButton(context, Icons.notifications_outlined, const NotificationsScreen()),
                    headerIconButton(context, Icons.favorite_border, const WishlistScreen()),
                    headerIconButton(context, Icons.shopping_bag_outlined, const CartScreen()),
                  ],
                ),
              ],
            ),
          ),
          )))
    );
  }

  Widget buildFooter(List<bool> buttonStatus, BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buttonStatus[0]
                ? buildButton("Home", Icons.home, buttonStatus[0], () {})
                : buildButton("Home", Icons.home_outlined, buttonStatus[0], () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen()));
            }),
            buttonStatus[1]
                ? buildButton("Explore", Icons.explore, buttonStatus[1], () {})
                : buildButton(
                "Explore", Icons.explore_outlined, buttonStatus[1], () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ExploreScreen()));
            }),
           /* buttonStatus[2]
                ? buildButton(
                "Schedule", Icons.calendar_month, buttonStatus[2], () {})
                : buildButton(
                "Schedule", Icons.calendar_month_outlined, buttonStatus[2],
                    () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScheduleScreen()));
                }),*/
            buttonStatus[3]
                ? buildButton(
                "Orders", Icons.local_shipping, buttonStatus[3], () {})
                : buildButton(
                "Orders", Icons.local_shipping_outlined, buttonStatus[3],
                    () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrdersScreen()));
                }),
            buttonStatus[4]
                ? buildButton(
                "Profile", Icons.account_circle, buttonStatus[4], () {})
                : buildButton(
                "Profile", Icons.account_circle_outlined, buttonStatus[4],
                    () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                }),
          ],
        ),
      ),
    );
  }

  Widget buildButton(
      String label, IconData icon, bool isScreen, void Function() navigate) {
    return Expanded(
      // If isScreen is true, the button has a top border and different background color. Else button no border and white bg color.
      child: isScreen
          ? Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(width: 1.5))),
        child: TextButton(
            onPressed: () {
              navigate();
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFFF4F4F4))),
            child: Column(
              children: [
                const SizedBox(
                  height: 4,
                ),
                Icon(
                  icon,
                  size: 34,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  label,
                  style:
                  const TextStyle(fontSize: 13, color: Colors.black),
                ),
              ],
            )),
      )
          : TextButton(
          onPressed: () {
            navigate(); // Pass argument here to Navigate to screen Logic which is to follow
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero)),
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.white)),
          child: Column(
            children: [
              const SizedBox(
                height: 4,
              ),
              Icon(
                icon,
                size: 34,
                color: Colors.black,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                label,
                style: const TextStyle(fontSize: 13, color: Colors.black),
              ),
            ],
          )),
    );
  }

Widget headerIconButton( BuildContext context, IconData icon, Widget page) {
  return IconButton(
    padding: EdgeInsets.zero,
    visualDensity: VisualDensity.compact,
    onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
    },
    icon: Icon(
      icon,
      size: 30,
      color: Colors.black,
    ),
    constraints: const BoxConstraints(),
  );
}

Widget headerIconButton2(BuildContext context, IconData icon, String tabName) {
  return IconButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(tabName: tabName),
        ),
      );
    },
    icon: Icon(
      icon,
      size: 30,
      color: Colors.black,
    ),
    padding: const EdgeInsets.all(0),
    constraints: const BoxConstraints(),
  );
}

