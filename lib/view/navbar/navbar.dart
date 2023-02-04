import 'package:pinkey/view/complaint/complaint_view.dart';

import '../admin/complaints/admin_complaints_view.dart';
import '/view/admin/request/admin_request_view.dart';
import '/view/appointments/appointments_view.dart';
import '/view/resourse/assets_manager.dart';

import '../menu/menu_view.dart';
import '../trainer/appointments/trainer_appointments_view.dart';
import '../trainer/my_courses/my_courses_view.dart';
import '../trainer/requests/requests_view.dart';
import '/translations/locale_keys.g.dart';
import '/view/home/home_view.dart';
import '/view/resourse/color_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_svg/flutter_svg.dart';


class NavbarView extends StatefulWidget {
  @override
  State<NavbarView> createState() => _NavbarViewState();
}

class _NavbarViewState extends State<NavbarView> {
  late List<Map<String, dynamic>> _screens;

  final controller = PersistentTabController();

  @override
  Widget build(BuildContext context) {
    _screens = [
      {
        "title": tr(LocaleKeys.favorite_page),
        "icon": AssetsManager.admin_requestIMG,
        "screen": AdminRequestView()
      },
      {
        "title": tr(LocaleKeys.favorite_page),
        "icon": AssetsManager.send_complaintIMG,
        "screen": ComplaintView()
      },
      {
        "title": tr(LocaleKeys.favorite_page),
        "icon": AssetsManager.trainer_course_nameIMG,
        "screen": MyCoursesView()
      },

      // {
      //   "title": tr(LocaleKeys.rate_page),
      //   "icon": AssetsManager.appointmentsIMG,
      //   "screen": AppointmentsView()
      // },

      {
        "title": tr(LocaleKeys.home_page),
        "icon": AssetsManager.privacy_policyIMG,
        "screen": RequestsView(),
      },
      {
        "title": tr(LocaleKeys.home_page),
        "icon": AssetsManager.homeIMG,
        "screen": HomeView(),
      },

      {
        "title": tr(LocaleKeys.chat_page),
        "icon": AssetsManager.menuIMG,
        "screen": MenuView()
      },
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: Text(_screens[controller.index]['title']),
      //   actions: [
      //     if (controller.index == 0)
      //       PopupMenuButton(
      //           icon: Icon(
      //             Icons.filter_list,
      //             color: ColorManager.lightGray,
      //           ),
      //           itemBuilder: (context) => [
      //
      //               PopupMenuItem(
      //                 child: Text(tr(LocaleKeys.location)),
      //                 value: tr(LocaleKeys.location),
      //               ),
      //             PopupMenuItem(
      //                 child: Text(tr(LocaleKeys.price)),
      //                 value: tr(LocaleKeys.price),
      //               ),
      //           ]),
      //   ],
      // ),
      // drawer: Drawer(
      //   child: BuildDrawer(),
      // ),
      body: SafeArea(
        child: PersistentTabView(
          context,
          onItemSelected: (index) {
            controller.index = index;
            setState(() {});
            print(controller.index);
          },
          controller: controller,
          screens: [
            AdminRequestView(),
            AdminComplaintsView(),
            MyCoursesView(),
            // AppointmentsView(),
            TrainerAppointmentsView(),
            // RequestsView(),
            HomeView(),
            MenuView()
          ],
          navBarStyle: NavBarStyle.style5,
          items: [
            for (int i = 0; i < _screens.length; i++)
              PersistentBottomNavBarItem(
                  icon: SvgPicture.asset(
                    _screens[i]['icon'],
                    color: i == controller.index
                        ? ColorManager.secondaryColor
                        : ColorManager.lightGray,
                  ),
                  activeColorSecondary: ColorManager.secondaryColor,
                  activeColorPrimary: Colors.transparent)
          ],
          backgroundColor: Theme.of(context).cardColor,
        ),
      ),
    );
  }
}
