import 'package:flutter/material.dart';

import 'widgets/requests_view_body.dart';

class RequestsView extends StatelessWidget {
  const RequestsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RequestsViewBody(),
    );
  }
}
