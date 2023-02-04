import 'package:flutter/material.dart';
import 'package:pinkey/view/resourse/color_manager.dart';
import 'package:pinkey/view/resourse/string_manager.dart';

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
      body: ProfileViewBody(isIgnor: isIgnor),
    );
  }
}
