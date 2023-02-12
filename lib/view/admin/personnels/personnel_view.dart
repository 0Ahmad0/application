import 'package:flutter/material.dart';
import '/view/admin/personnels/widgets/personnel_view_body.dart';

class PersonnelView extends StatelessWidget {
  const PersonnelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersonnelViewBody(),
    );
  }
}
