import 'package:flutter/material.dart';
import 'package:pinkey/controller/provider/report_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/requests_view_body.dart';

class RequestsView extends StatelessWidget {
  const RequestsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<ReportProvider>.value(
    value: Provider.of<ReportProvider>(context),
    child: Consumer<ReportProvider>(
    builder: (context, value, child)=>RequestsViewBody(reportProvider:value,
    ))));
  }
}
