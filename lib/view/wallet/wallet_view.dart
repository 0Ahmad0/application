import 'package:flutter/material.dart';
import 'package:pinkey/view/resourse/string_manager.dart';

import '../resourse/color_manager.dart';
import 'widgets/wallet_view_body.dart';

class WalletView extends StatelessWidget {
  const WalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStringsManager.wallet),
        leading: BackButton(color: ColorManager.black,),
      ),
      body: WalletViewBody(),
    );
  }
}
