import 'package:flutter/material.dart';

import 'widgets/menu_view_body.dart';

class MenuView extends StatelessWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MenuViewBody(),
    );
  }
}
