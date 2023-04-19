import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/app_widgets/image_loader.dart';
import 'package:Cliamizer/base/view/base_state.dart';
import 'package:Cliamizer/res/styles.dart';
import 'package:Cliamizer/ui/edit_profile_screen/EditProfileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../CommonUtils/log_utils.dart';
import '../../CommonUtils/model_eventbus/EventBusUtils.dart';
import '../../CommonUtils/model_eventbus/ProfileEvent.dart';
import '../../CommonUtils/preference/Prefs.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../res/gaps.dart';
import '../../res/setting.dart';
import '../user/login_screen/LoginScreen.dart';
import 'MorePresenter.dart';
import 'MoreProvider.dart';

class MoreScreen extends StatefulWidget {
  static const String TAG = "/MoreScreen";

  MoreScreen({
    Key key,
  }) : super(key: key);

  @override
  State<MoreScreen> createState() => MoreScreenState();
}

class MoreScreenState extends BaseState<MoreScreen, MorePresenter>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  MoreProvider provider;

  @override
  void initState() {
    super.initState();
    provider = context.read<MoreProvider>();
    EventBusUtils.getInstance().on<ProfileEvent>().listen((event) {
      if (event.username != null) {
        provider.instance.name = event.username;
      }
      if (event.userEmail != null) {
        provider.instance.email = event.userEmail;
      }
      if (event.userImage != null) {
        provider.instance.avatar = event.userImage;
      }
      setState(() {});
    });
    mPresenter.getProfileData();
    Prefs.getAppLocal.then((value) => {
      if (value != null)
        {
          setState(() {
            setSelected(value);
            print('###### $value');
            provider.language = value;
          }),
          // provider.isArabic == "ar",
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.page_background,
      body: provider.instance!=null ?Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 60, 16, 0),
        child: ListView(
          children: [profileWidget(), Gaps.vGap12, settingsWidget(), Gaps.vGap12, Gaps.vGap8, accountWidget()],
        ),
      ) : mPresenter.showProgress(),
    );
  }

  Widget profileWidget() => Container(
        decoration: BoxDecoration(color: MColors.whiteE, borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.w),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 1.w,
                  height: 5.w,
                  margin: EdgeInsetsDirectional.only(end: 2.w),
                  decoration: BoxDecoration(color: MColors.primary_color, borderRadius: BorderRadius.circular(4)),
                ),
                Text(S.current.profile, style: MTextStyles.textMain18),
                Spacer(),
                editProfileButton()
              ],
            ),
            Gaps.vGap16,
            Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: ImageLoader(imageUrl: provider.instance.avatar,width: 16.w,height: 16.w,)),
                Gaps.hGap12,
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10, top: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(provider.instance.name, style: MTextStyles.textGray16),
                      Text(provider.instance.email, style: MTextStyles.textLabelSmall),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      );

  Widget editProfileButton() => InkWell(
        onTap: () {
          Navigator.push(context, CupertinoPageRoute(builder: (_) => EditProfileScreen()));
        },
        child: Container(
          width: 8.w,
          height: 8.w,
          padding: EdgeInsets.all(6),
          decoration:
              BoxDecoration(border: Border.all(color: MColors.primary_color), borderRadius: BorderRadius.circular(8)),
          child: SvgPicture.asset(
            ImageUtils.getSVGPath('edit-2'),
            fit: BoxFit.fitWidth,
          ),
        ),
      );

  Widget settingsWidget() {
    return Container(
      decoration: BoxDecoration(color: MColors.whiteE, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.w),
      child: Column(
        children: [
          // language
          Row(
            children: [
              SvgPicture.asset(
                ImageUtils.getSVGPath('lang'),
                fit: BoxFit.fitWidth,
              ),
              Gaps.hGap12,
              Text(S.of(context).language, style: MTextStyles.textMainLight16),
              Spacer(),
              Transform.scale(
                  scale: 0.2.w,
                  child: Consumer<MoreProvider>(
                    builder: (context, pr, child) =>  CupertinoSwitch(
                        activeColor: Color(0xff44A4F2),
                        value: Setting.mobileLanguage.value == Locale('en'),
                        onChanged: (value) {
                          if (value) {
                            setSelected("en");
                          } else {
                            setSelected("ar");
                          }
                          print("!@##@!@!#!@!# "+pr.language);
                        }),
                  )),
            ],
          ),
          divider(),
          // help
          Row(
            children: [
              SvgPicture.asset(
                ImageUtils.getSVGPath('help'),
                fit: BoxFit.fitWidth,
              ),
              Gaps.hGap12,
              Text(S.of(context).help, style: MTextStyles.textMainLight16),
            ],
          ),
          divider(),
          // support
          Row(
            children: [
              SvgPicture.asset(
                ImageUtils.getSVGPath('24-support'),
                fit: BoxFit.fitWidth,
              ),
              Gaps.hGap12,
              Text(S.of(context).support, style: MTextStyles.textMainLight16),
            ],
          ),
          divider(),
          // Privacy and Policy
          Row(
            children: [
              SvgPicture.asset(
                ImageUtils.getSVGPath('privacy_policy'),
                fit: BoxFit.fitWidth,
              ),
              Gaps.hGap12,
              Text(S.of(context).privacyAndPolicy, style: MTextStyles.textMainLight16),
            ],
          ),
        ],
      ),
    );
  }
  void setSelected(String s) {
    if (s == 'en' || s == 'null')
      Setting.mobileLanguage.value = new Locale('en');
    else
      Setting.mobileLanguage.value = new Locale('ar');
    Prefs.setAppLocal(s);
    Log.d(s);
  }

  Widget accountWidget() {
    return Container(
      decoration: BoxDecoration(color: MColors.whiteE, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.w),
      child: Column(
        children: [
          // notification
          Row(
            children: [
              SvgPicture.asset(
                ImageUtils.getSVGPath('notification-bing'),
                fit: BoxFit.fitWidth,
              ),
              Gaps.hGap12,
              Text(S.of(context).notification, style: MTextStyles.textMainLight16),
              Spacer(),
              Transform.scale(
                  scale: 0.2.w,
                  child: CupertinoSwitch(
                      activeColor: Color(0xff44A4F2),
                      value: provider.receiveNotification,
                      onChanged: (value) {
                        provider.receiveNotification = value;
                        print(provider.receiveNotification);
                      }))
            ],
          ),
          divider(),
          // logout
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context, CupertinoPageRoute(builder: (_) => LoginScreen()), (route) => false);
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  ImageUtils.getSVGPath('logout'),
                  fit: BoxFit.fitWidth,
                ),
                Gaps.hGap12,
                Text(S.of(context).logOut, style: MTextStyles.textMainLight16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget divider() {
    return Column(
      children: [
        Gaps.vGap16,
        Divider(
          color: MColors.dividerColor,
        ),
        Gaps.vGap16,
      ],
    );
  }

  @override
  MorePresenter createPresenter() {
    return MorePresenter();
  }

  @override
  bool get wantKeepAlive => true;
}
