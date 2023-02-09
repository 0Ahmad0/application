import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/provider/report_provider.dart';
import 'widgets/admin_complaints_view_body.dart';

class AdminComplaintsView extends StatelessWidget {
  const AdminComplaintsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      ChangeNotifierProvider<ReportProvider>.value(
    value: Provider.of<ReportProvider>(context),
    child: Consumer<ReportProvider>(
    builder: (context, value, child)=>
      AdminComplaintsViewBody(reportProvider: value,),
    )));
  }
}
