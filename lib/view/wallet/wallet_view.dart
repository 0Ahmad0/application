import 'package:flutter/material.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/wallet_provider.dart';
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
      body:ChangeNotifierProvider<WalletProvider>.value(
    value: Provider.of<WalletProvider>(context),
    child: Consumer<WalletProvider>(
    builder: (context, value, child)=> WalletViewBody(walletProvider:value),
    )));
  }
}
