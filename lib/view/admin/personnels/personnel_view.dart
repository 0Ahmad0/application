import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/provider/account_provider.dart';
import '/view/admin/personnels/widgets/personnel_view_body.dart';

class PersonnelView extends StatelessWidget {
  const PersonnelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<AccountProvider>.value(
    value: Provider.of<AccountProvider>(context),
    child: Consumer<AccountProvider>(
    builder: (context, value, child)=>PersonnelViewBody(accountProvider:value))),
    );
  }
}
