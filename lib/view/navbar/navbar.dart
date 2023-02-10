import 'package:pinkey/controller/manager/role.dart';
import 'package:pinkey/controller/provider/profile_provider.dart';
import 'package:pinkey/view/complaint/complaint_view.dart';
import 'package:provider/provider.dart';

import '../admin/complaints/admin_complaints_view.dart';
import '/view/admin/request/admin_request_view.dart';
import '/view/appointments/appointments_view.dart';
import '/view/resourse/assets_manager.dart';

import '../menu/menu_view.dart';
import '../trainer/appointments/trainer_appointments_view.dart';
import '../trainer/my_courses/my_courses_view.dart';
import '../trainer/requests/requests_view.dart';
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
  late List<Widget> _widget;

  final controller = PersistentTabController();
  late ProfileProvider profileProvider;
  @override
  Widget build(BuildContext context) {
    profileProvider=Provider.of<ProfileProvider>(context);
    _screens = [];
    _widget = [];


    if(Role.checkRole(typeUser: profileProvider.user.typeUser, role: Role.adminRequestView)){
      _widget.add(AdminRequestView());
      _screens.add(
      {
          "title": 'tr(LocaleKeys.favorite_page)',
          "icon": AssetsManager.profileIMG,
          "screen": AdminRequestView()
        }
      );
    }
    if(Role.checkRole(typeUser: profileProvider.user.typeUser, role: Role.adminComplaintsView)){
      _widget.add( AdminComplaintsView());
      _screens.add(
      {
          "title": 'tr(LocaleKeys.favorite_page)',
          "icon": AssetsManager.admin_requestIMG,
          "screen": AdminComplaintsView()
        }
      );
    }
    if(Role.checkRole(typeUser: profileProvider.user.typeUser, role: Role.trainerAppointmentsView)){
      _widget.add( TrainerAppointmentsView());
      _screens.add(
          {
            "title": 'tr(LocaleKeys.rate_page)',
            "icon": AssetsManager.appointmentsIMG,
            "screen": TrainerAppointmentsView()
          }
      );
    }

    if(Role.checkRole(typeUser: profileProvider.user.typeUser, role: Role.appointmentsView)){
      _widget.add( AppointmentsView());
      _screens.add(
      {
          "title": 'tr(LocaleKeys.rate_page)',
          "icon": AssetsManager.appointmentsIMG,
          "screen": AppointmentsView()
        }
      );
    }

    if(Role.checkRole(typeUser: profileProvider.user.typeUser, role: Role.myCoursesView)){
      _widget.add(MyCoursesView());
      _screens.add(
      {
            "title": 'tr(LocaleKeys.favorite_page)',
            "icon": AssetsManager.trainer_course_nameIMG,
            "screen": MyCoursesView()
          }
      );
    }

    if(Role.checkRole(typeUser: profileProvider.user.typeUser, role: Role.requestsView)){
      _widget.add(RequestsView());
      _screens.add(
          {
            "title": 'tr(LocaleKeys.home_page)',
            "icon": AssetsManager.privacy_policyIMG,
            "screen": RequestsView(),
          }
      );
    }

    if(Role.checkRole(typeUser: profileProvider.user.typeUser, role: Role.homeView)){
      _widget.add( HomeView());
      _screens.add(
          {
            "title": 'tr(LocaleKeys.home_page)',
            "icon": AssetsManager.homeIMG,
            "screen": HomeView(),
          }
      );
    }
    if(Role.checkRole(typeUser: profileProvider.user.typeUser, role: Role.menuView)){
      _widget.add(MenuView());
      _screens.add(
          {
            "title":' tr(LocaleKeys.chat_page)',
            "icon": AssetsManager.menuIMG,
            "screen": MenuView()
          }
      );
    }
    // [{
    //   "title": 'tr(LocaleKeys.favorite_page)',
    //   "icon": AssetsManager.admin_requestIMG,
    //   "screen": AdminRequestView()
    // },{
    //   "title": 'tr(LocaleKeys.favorite_page)',
    //   "icon": AssetsManager.admin_requestIMG,
    //   "screen": AdminComplaintsView()
    // },{
    //   "title":' tr(LocaleKeys.chat_page)',
    //   "icon": AssetsManager.menuIMG,
    //   "screen": MenuView()
    // }, {
    //   "title": 'tr(LocaleKeys.home_page)',
    //   "icon": AssetsManager.homeIMG,
    //   "screen": HomeView(),
    // },{
    //   "title": 'tr(LocaleKeys.home_page)',
    //   "icon": AssetsManager.privacy_policyIMG,
    //   "screen": RequestsView(),
    // },{
    //   "title": 'tr(LocaleKeys.rate_page)',
    //   "icon": AssetsManager.appointmentsIMG,
    //   "screen": AppointmentsView()
    // }
    //   ,{
    //     "title": 'tr(LocaleKeys.favorite_page)',
    //     "icon": AssetsManager.trainer_course_nameIMG,
    //     "screen": MyCoursesView()
    //   }
    // ];
    // if(Role.checkRole(typeUser: profileProvider.user.typeUser, role: Role.comp))
    //   _screens.add(
    //       {
    //         "title":' tr(LocaleKeys.favorite_page)',
    //         "icon": AssetsManager.send_complaintIMG,
    //         "screen": ComplaintView()
    //       }
    //   );


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
          screens:_widget
          // [
          //   if(Role.checkRole(typeUser: profileProvider.user.typeUser, role: Role.adminRequestView))
          //   AdminRequestView(),
          //   if(Role.checkRole(typeUser: profileProvider.user.typeUser, role: Role.adminRequestView))
          //   AdminComplaintsView(),
          //   // if(Role.checkRole(typeUser: profileProvider.user.typeUser, role: Role.adminRequestView))
          //   // MyCoursesView(),
          //    if(Role.checkRole(typeUser: profileProvider.user.typeUser, role: Role.adminRequestView))
          //    AppointmentsView(),
          //   //   if(Role.checkRole(typeUser: profileProvider.user.typeUser, role: Role.adminRequestView))
          //   // TrainerAppointmentsView(),
          //    if(Role.checkRole(typeUser: profileProvider.user.typeUser, role: Role.requestsView))
          //    RequestsView(),
          //   //   if(Role.checkRole(typeUser: profileProvider.user.typeUser, role: Role.homeView))
          //   // HomeView(),
          //    if(Role.checkRole(typeUser: profileProvider.user.typeUser, role: Role.menuView))
          //   MenuView()
          // ],
          ,navBarStyle: NavBarStyle.style5,
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
