import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinkey/controller/form_validator.dart';
import 'package:pinkey/controller/provider/wallet_provider.dart';
import 'package:pinkey/model/utils/const.dart';
import 'package:pinkey/view/resourse/color_manager.dart';
import 'package:pinkey/view/resourse/style_manager.dart';
import 'package:pinkey/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../manager/widgets/button_app.dart';
import '../../resourse/string_manager.dart';

class ChargeWalletViewBody extends StatelessWidget {
  ChargeWalletViewBody({required this.walletProvider});
  final WalletProvider walletProvider;
  final formKey = GlobalKey<FormState>();
  final cardNumberController = TextEditingController();
  final cardHolderController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvvController = TextEditingController();
  final balanceController = TextEditingController();
   DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Form(
        key: formKey,
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
         // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(AppStringsManager.select_a_payment_method),
                const SizedBox(
                  height: AppSize.s10,
                ),
                DropdownButtonFormField(
                  validator: (val){
                    if(val == null){
                      return AppStringsManager.filed_Required;
                    }
                  },
                  items: [
                    for (int i = 0; i < _paymentMethod.length; i++)
                      DropdownMenuItem(
                        child: Text(_paymentMethod[i]),
                        value: _paymentMethod[i],
                      )
                  ],
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      errorBorder: borderStyle,
                      focusedBorder: borderStyle,
                      enabledBorder: borderStyle,
                      border: borderStyle,
                      hintText: 'مدى',
                      hintStyle: getRegularStyle(
                          color: ColorManager.lightGray, fontSize: 10.sp)),
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),
                const Text(AppStringsManager.your_paymentdetails),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Text(
                  AppStringsManager.card_number,
                  style:
                  getRegularStyle(color: ColorManager.lightGray, fontSize: 10.sp),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                TextFormField(
                    keyboardType: TextInputType.number,
                    controller: cardNumberController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (val)=>FormValidator.cardNumberValidator(val)
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Text(
                  AppStringsManager.card_holder,
                  style:
                  getRegularStyle(color: ColorManager.lightGray, fontSize: 10.sp),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                TextFormField(
                  controller: cardHolderController,
                  validator: (val){
                    if(val!.trim().isEmpty)
                      return AppStringsManager.filed_Required;
                    return null;
                  },
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Text(
                  AppStringsManager.balance,
                  style:
                  getRegularStyle(color: ColorManager.lightGray, fontSize: 10.sp),

                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                TextFormField(
                  controller: balanceController,
                  validator: (val){
                    if(val!.trim().isEmpty)
                      return AppStringsManager.balance;
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              AppStringsManager.expiry_date,
                              style: getRegularStyle(
                                  color: ColorManager.lightGray, fontSize: 10.sp),
                            ),
                            const SizedBox(
                              height: AppSize.s10,
                            ),
                            TextFormField(
                              readOnly: true,
                              controller: expiryDateController,
                              onTap: ()=>_selectDate(context),
                              validator: (val){
                                if(val!.trim().isEmpty)
                                  return AppStringsManager.filed_Required;
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: 'MM/YY',
                                  hintStyle: getRegularStyle(
                                      color: ColorManager.lightGray,
                                      fontSize: 12.sp
                                  )
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(
                      width: AppSize.s10,
                    ),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              AppStringsManager.pin_cvv,
                              style: getRegularStyle(
                                  color: ColorManager.lightGray, fontSize: 10.sp),
                            ),
                            const SizedBox(
                              height: AppSize.s10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: cvvController,
                              validator: (val) => FormValidator.cvvCardValidator(val),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            ButtonApp(text: AppStringsManager.confirm_payment, onPressed: () async {
              if(formKey.currentState!.validate()){
                Const.LOADIG(context);
                final result=await walletProvider.addBalanceToWallet(context, balance: num.parse(balanceController.text));
                Get.back();
                if(result['status']){
                  Get.back();
                }
              }
            })


          ],
        ),
      ),
    );
  }

  final borderStyle = const OutlineInputBorder(
      borderSide: BorderSide(color: ColorManager.hintColor));
  final List<String> _paymentMethod = ['Visa', 'Master Card'];
  _selectDate(BuildContext context) async {
    var newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      expiryDateController
        ..text = DateFormat.yM().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: expiryDateController.text.length,
            affinity: TextAffinity.upstream));
      print(expiryDateController.text);
      print(expiryDateController.text.substring(0,expiryDateController.text.length-2));
    }
  }
}

