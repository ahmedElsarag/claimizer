import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/base/view/base_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../app_widgets/CustomTextField.dart';
import '../../app_widgets/claimizer_app_bar.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../res/gaps.dart';
import '../../res/styles.dart';
import '../edit_profile_screen/EditProfileScreen.dart';
import 'ProfilePresenter.dart';
import 'ProfileProvider.dart';

class ProfileScreen extends StatefulWidget {
  static const String TAG = "/ProfileScreen";

  ProfileScreen({
    Key key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends BaseState<ProfileScreen, ProfilePresenter> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  ProfileProvider provider = ProfileProvider();
  String _username = "John Doe";
  String _email = "johndoe@gmail.com";
  String _phone = "1234567890";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileProvider>(
      create: (context) => provider,
      builder: (context, child) => Consumer<ProfileProvider>(
          builder: (context, value, child) => Scaffold(
                backgroundColor: MColors.page_background,
                body: Column(
                  children: [
                    ClaimizerAppBar(title: S.current.profile),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 30.w,
                            width: 30.w,
                            decoration: BoxDecoration(color: MColors.page_background, borderRadius: BorderRadius.circular(100)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                ImageUtils.getImagePath("img"),
                              ),
                            ),
                          ),
                          Gaps.vGap12,
                          Text(
                            _username,
                            style: MTextStyles.textDarkGray12,
                          ),
                          Gaps.vGap6,
                          Text(
                            _email,
                            style: MTextStyles.textLabelSmall,
                          ),
                          Gaps.vGap12,
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(MColors.blueButtonColor),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                              ))
                            ),
                            onPressed: () {
                              Navigator.push(context, CupertinoPageRoute(builder: (_)=>EditProfileScreen()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16,12,16,12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(ImageUtils.getSVGPath("edit-2"),color: MColors.white,),
                                  Gaps.hGap10,
                                  Text(S.of(context).editProfile,style: MTextStyles.textWhite14,),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Basic Info",style: MTextStyles.textBoldDark20.copyWith(color: MColors.black),),
                              Gaps.vGap12,
                              Gaps.vGap12,
                              Gaps.vGap10,
                              buildUsernameField(context),
                              Gaps.vGap12,
                              Gaps.vGap8,
                              buildEmailField(context),
                              Gaps.vGap12,
                              Gaps.vGap8,
                              buildPhoneField(context),
                            ],
                          ),
                        ]
                      ),
                    ),
                  ],
                ),
              )),
    );
  }
  Widget buildEmailField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .872,
      margin: EdgeInsetsDirectional.only(start: 1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).emailAddress,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Gaps.vGap12,
          MyTextFormField(
            readOnly: true,
            style: Theme.of(context).textTheme.bodySmall,
            dividerColor: Theme.of(context).dividerColor,
            controller: TextEditingController(
              text: _email
            ),
            decoration: InputDecoration(
              hintText: "Name@mail.com",
              errorStyle: Theme.of(context).textTheme.bodySmall.copyWith(color: Colors.redAccent),
              contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              errorBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedErrorBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.primary_light_color)),
              counterText: "",
              hintStyle: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ],
      ),
    );
  }
  Widget buildUsernameField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .872,
      margin: EdgeInsetsDirectional.only(start: 1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).name,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Gaps.vGap12,
          MyTextFormField(
            readOnly: true,
            style: Theme.of(context).textTheme.bodySmall,
            dividerColor: Theme.of(context).dividerColor,
            controller: TextEditingController(
                text: _username
            ),
            decoration: InputDecoration(
              hintText: "Name@mail.com",
              errorStyle: Theme.of(context).textTheme.bodySmall.copyWith(color: Colors.redAccent),
              contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              errorBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedErrorBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.primary_light_color)),
              counterText: "",
              hintStyle: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ],
      ),
    );
  }
  Widget buildPhoneField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .872,
      margin: EdgeInsetsDirectional.only(start: 1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).phoneNumber,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Gaps.vGap12,
          MyTextFormField(
            readOnly: true,
            style: Theme.of(context).textTheme.bodySmall,
            dividerColor: Theme.of(context).dividerColor,
            controller: TextEditingController(
                text: _phone
            ),
            decoration: InputDecoration(
              hintText: "Name@mail.com",
              errorStyle: Theme.of(context).textTheme.bodySmall.copyWith(color: Colors.redAccent),
              contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              errorBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedErrorBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.primary_light_color)),
              counterText: "",
              hintStyle: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ],
      ),
    );
  }
  @override
  ProfilePresenter createPresenter() {
    return ProfilePresenter();
  }

  @override
  bool get wantKeepAlive => true;
}
