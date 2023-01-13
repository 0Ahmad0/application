import 'package:flutter/material.dart';

import 'widgets/admin_complaints_view_body.dart';

class AdminComplaintsView extends StatelessWidget {
  const AdminComplaintsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdminComplaintsViewBody(),
    );
  }
}
