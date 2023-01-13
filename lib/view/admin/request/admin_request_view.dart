import 'package:flutter/material.dart';

import 'widgets/admin_request_view_body.dart';

class AdminRequestView extends StatelessWidget {
  const AdminRequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdminRequestViewBody(),
    );
  }
}
