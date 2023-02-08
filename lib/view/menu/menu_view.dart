import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/profile_provider.dart';
import 'widgets/menu_view_body.dart';

class MenuView extends StatelessWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<ProfileProvider>.value(
    value: Provider.of<ProfileProvider>(context),
    child: Consumer<ProfileProvider>(
    builder: (context, profileProvider, child) => MenuViewBody(profileProvider:profileProvider))),
    );
  }
}
