import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/provider/account_provider.dart';
import 'widgets/admin_request_view_body.dart';

class AdminRequestView extends StatelessWidget {
  const AdminRequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ChangeNotifierProvider<AccountProvider>.value(
    value: Provider.of<AccountProvider>(context),
    child: Consumer<AccountProvider>(
    builder: (context, value, child)=> AdminRequestViewBody(accountProvider:value),
    )));
  }
}
