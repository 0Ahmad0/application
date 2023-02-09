import 'package:flutter/material.dart';
import 'package:pinkey/controller/provider/account_provider.dart';
import 'package:pinkey/controller/provider/report_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/requests_view_body.dart';

class RequestsView extends StatelessWidget {
  const RequestsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<AccountProvider>.value(
    value: Provider.of<AccountProvider>(context),
    child: Consumer<AccountProvider>(
    builder: (context, value, child)=>RequestsViewBody(accountProvider:value,
    ))));
  }
}
