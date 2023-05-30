import 'package:flutter/material.dart';
import 'package:pinkey/controller/provider/report_provider.dart';
import '../../../../controller/provider/account_provider.dart';
import '/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../resourse/color_manager.dart';
import '../../../resourse/string_manager.dart';
import '../../../resourse/style_manager.dart';
import 'expired_and_cancelled_reuest_page.dart';
import 'new_request_page.dart';
import 'ongoing_requests_page.dart';

class RequestsViewBody extends StatefulWidget {
  RequestsViewBody({Key? key, required this.accountProvider}) : super(key: key);
  final AccountProvider accountProvider;
  @override
  State<RequestsViewBody> createState() => _RequestsViewBodyState();
}

class _RequestsViewBodyState extends State<RequestsViewBody> {
  List<String> requestType = [
    AppStringsManager.new_requests,
    AppStringsManager.ongoing_requests,
    AppStringsManager.expired_and_cancelled_requests,
  ];
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppStringsManager.requests,
            style: getRegularStyle(color: ColorManager.black, fontSize: 16.sp),
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppPadding.p6),
            decoration: BoxDecoration(
                color: ColorManager.borderColor,
                borderRadius: BorderRadius.circular(50.sp)),
            child: Row(
              children: [
                for (int i = 0; i < requestType.length; i++)
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _selectedIndex = i;
                        _pageController.animateToPage(_selectedIndex,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);

                        setState(() {});
                      },
                      child: AnimatedContainer(
                        alignment: Alignment.center,
                        height: AppSize.s50,
                        duration: const Duration(milliseconds: 500),
                        padding: const EdgeInsets.all(AppPadding.p10),
                        decoration: BoxDecoration(
                          color: _selectedIndex == i
                              ? ColorManager.thirdlyColor
                              : ColorManager.borderColor,
                          borderRadius: BorderRadius.circular(50.sp),
                        ),
                        child: Text(
                          requestType[i],
                          style: getRegularStyle(
                              color: _selectedIndex == i
                                  ? ColorManager.white
                                  : ColorManager.lightGray,
                              fontSize: 10.sp),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          Expanded(
              child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              _selectedIndex = index;
              setState(() {});
            },
            children: [
              NewRequestPage(),
              OngoingRequestsPage(),
              ExpiredAndCancelledRequestPage()
            ],
          )),
        ],
      ),
    );
  }
}
