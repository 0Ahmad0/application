import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pinkey/view/resourse/color_manager.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:provider/provider.dart';
import '../../controller/auth_controller.dart';
import '../../controller/provider/profile_provider.dart';

import 'widgets/profile_view_body.dart';

class ProfileView extends StatefulWidget {
   ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isIgnor = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ColorManager.black,
        ),
        actions: [
          IconButton(onPressed: (){
            setState((){
              isIgnor = !isIgnor;
              print(isIgnor);
            });
          }, icon: Icon(Icons.edit,color: ColorManager.primaryColor,))
        ],
        title: Text(AppStringsManager.edit_profile),
      ),
      body:   ChangeNotifierProvider<ProfileProvider>.value(
          value: Provider.of<ProfileProvider>(context),
          child: Consumer<ProfileProvider>(
              builder: (context, value, child) {return ProfileViewBody(isIgnor: isIgnor,profileProvider:value);})),
    );
  }
}
