import 'package:flutter/material.dart';
import 'package:pinkey/view/resourse/string_manager.dart';

import '../resourse/color_manager.dart';
import 'widgets/charge_wallet_view_body.dart';

class ChargeWalletView extends StatelessWidget {
  const ChargeWalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
appBar: AppBar(
  title: Text(AppStringsManager.charge_wallet),
  leading: BackButton(
    color: ColorManager.black,
  ),
),
      body: ChargeWalletViewBody(),
    );
  }
}
