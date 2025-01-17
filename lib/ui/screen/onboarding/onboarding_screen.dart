import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nws_hieuvm_ecommerce_flutter/common/app_image.dart';
import 'package:nws_hieuvm_ecommerce_flutter/database/share_preferences_helper.dart';
import 'package:nws_hieuvm_ecommerce_flutter/ui/screen/onboarding/onboarding_cubit.dart';
import 'package:nws_hieuvm_ecommerce_flutter/ui/widget/item/item_onboarding.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingCubit>(
      create: (context) => OnboardingCubit(),
      child: const OnboardingScreenBody(),
    );
  }
}

class OnboardingScreenBody extends StatefulWidget {
  const OnboardingScreenBody({super.key});

  @override
  State<OnboardingScreenBody> createState() => _OnboardingScreenBodyState();
}

class _OnboardingScreenBodyState extends State<OnboardingScreenBody> {
  late OnboardingCubit onboardingCubit;
  int currentIndexPageView = 0;
  final controller = PageController();

  @override
  void initState() {
    super.initState();
    onboardingCubit = BlocProvider.of(context);
  }

  Widget dot() {
    return SmoothPageIndicator(
      controller: controller,
      count: 3,
      effect: const ExpandingDotsEffect(
        dotHeight: 8,
        dotWidth: 8,
        activeDotColor: Colors.black,
        dotColor: Color(0xFFdddddd),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        Size size = MediaQuery.of(context).size;
        return Scaffold(
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                SizedBox(
                  height: size.height,
                  width: size.width,
                ),
                Positioned(
                  top: 10,
                  left: 15,
                  right: 15,
                  height: size.height * 0.8,
                  child: PageView(
                    controller: controller,
                    children: const [
                      ItemOnboarding(
                        text1: '20% Discount New Arrival Product',
                        text2:
                            'Publish up your selfies to make yourself more beautiful with this app',
                        image: AppImages.imgOnboarding1,
                      ),
                      ItemOnboarding(
                        text1: 'Take Advantage Of The Offer Shopping',
                        text2:
                            'Publish up your selfies to make yourself more beautiful with this app',
                        image: AppImages.imgOnboarding2,
                      ),
                      ItemOnboarding(
                        text1: 'All Types Offers Within Your Reach',
                        text2:
                            'Publish up your selfies to make yourself more beautiful with this app',
                        image: AppImages.imgOnboarding3,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 15,
                  right: 15,
                  child: Row(
                    children: [
                      dot(),
                      const Spacer(),
                      BlocBuilder<OnboardingCubit, OnboardingState>(
                        builder: (context, state) {
                          return InkWell(
                            onTap: () {
                              controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                              if (controller.page == 2) {
                                onboardingCubit.navLogin(context);
                                SharedPreferencesHelper.setOnboard();
                              }
                            },
                            child: SvgPicture.asset(
                              AppImages.icNext,
                              width: 50,
                              height: 50,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
