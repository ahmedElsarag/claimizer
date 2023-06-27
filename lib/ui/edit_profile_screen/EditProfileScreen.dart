import 'dart:io';

import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/base/view/base_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../CommonUtils/utils.dart';
import '../../app_widgets/CustomTextField.dart';
import '../../app_widgets/app_headline.dart';
import '../../app_widgets/claimizer_app_bar.dart';
import '../../app_widgets/image_loader.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../res/gaps.dart';
import '../../res/styles.dart';
import 'EditProfilePresenter.dart';
import 'EditProfileProvider.dart';

class EditProfileScreen extends StatefulWidget {
  static const String TAG = "/EditProfileScreen";

  EditProfileScreen({
    Key key,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => EditProfileScreenState();
}

class EditProfileScreenState extends BaseState<EditProfileScreen, EditProfilePresenter>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  EditProfileProvider provider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  File _image;
  final picker = ImagePicker();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    provider = context.read<EditProfileProvider>();
    mPresenter.getProfileData();
    _tabController = TabController(length: 2, vsync: this);
    provider.selectedTabIndex = 0;
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: MColors.error_color,
            margin: EdgeInsets.all(8),
            behavior: SnackBarBehavior.floating,
            content: Text(S.of(context).noImageSelected)));
        Navigator.pop(context);
        Navigator.pop(context);
      }
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: MColors.error_color,
            margin: EdgeInsets.all(8),
            behavior: SnackBarBehavior.floating,
            content: Text(S.of(context).noImageSelected)));
        Navigator.pop(context);
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProfileProvider>(
        builder: (context, pr, child) => DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Scaffold(
                backgroundColor: MColors.page_background,
                body: pr.isDateLoaded
                    ? SafeArea(
                  child: ListView(
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.w),
                          child: ClaimizerAppBar(title: S.current.editProfile)),
                      Gaps.vGap12,
                      Gaps.vGap8,
                      Container(
                        color: MColors.page_background,
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                          Container(
                            decoration:
                            BoxDecoration(color: MColors.whiteE, borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                            child: Column(
                              children: [
                                AppHeadline(title: S.of(context).personalProfile),
                                Gaps.vGap15,
                                Stack(
                                  children: [
                                    Container(
                                      height: 30.w,
                                      width: 30.w,
                                      decoration: BoxDecoration(
                                          color: MColors.page_background,
                                          borderRadius: BorderRadius.circular(100)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: _image != null
                                            ? Image.file(_image)
                                            : ImageLoader(
                                          imageUrl: provider.instance.avatar,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    PositionedDirectional(
                                      bottom: 2.w,
                                      end: 0,
                                      child: InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return buildPickImageDialog(context);
                                                });
                                          },
                                          child: SvgPicture.asset(ImageUtils.getSVGPath("edit_photo"))),
                                    )
                                  ],
                                ),
                                Gaps.vGap12,
                                Material(
                                  color: MColors.primary_color.withOpacity(.08),
                                  borderRadius: BorderRadius.circular(30),
                                  child: TabBar(
                                    indicator: BoxDecoration(
                                      color: MColors.primary_color,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    indicatorPadding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
                                    labelColor: MColors.white,
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    onTap: (index) {
                                      pr.selectedTabIndex = index;
                                    },
                                    labelStyle: TextStyle(fontSize: 8.sp),
                                    tabs: [
                                      Tab(text: S.of(context).basicInfo),
                                      Tab(text: S.of(context).updatePassword),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gaps.vGap16,
                          Gaps.vGap12,
                          Container(
                            child: pr.selectedTabIndex == 0
                                ? _buildBasicInfoContent(pr)
                                : _buildUpdatePasswordContent(pr),
                          ),
                            ]),
                          ),
                        ],
                      ),
                    )
                  : Center(child: mPresenter.showMessage()),
            )));
  }

  Widget buildNotificationToggle(BuildContext context) {
    return Consumer<EditProfileProvider>(
      builder: (ctx, pr, w) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).emailNotifications,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Gaps.vGap12,
          Row(
            children: [
              Row(
                children: [
                  Radio(
                    fillColor: MaterialStateProperty.all<Color>(MColors.text_button_color),
                    value: 1,
                    groupValue: pr.isNotificationEnabled,
                    onChanged: (value) {
                      setState(() {
                        pr.isNotificationEnabled = value;
                      });
                    },
                  ),
                  Text(S.of(context).enable),
                ],
              ),
              SizedBox(width: 16.0),
              Radio(
                fillColor: MaterialStateProperty.all<Color>(MColors.text_button_color),
                value: 0,
                groupValue: pr.isNotificationEnabled,
                onChanged: (value) {
                  setState(() {
                    pr.isNotificationEnabled = value;
                  });
                },
              ),
              Text(S.of(context).disable),
            ],
          ),
        ],
      ),
    );
  }

  ElevatedButton buildEditProfileButton({Function onTap}) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(MColors.primary_color),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(100.w, 50),
        ),
      ),
      onPressed: onTap ?? () {},
      child: Text(
        S.of(context).saveChanges,
        style: MTextStyles.textWhite14,
      ),
    );
  }

  AlertDialog buildPickImageDialog(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60.w,
            child: ElevatedButton.icon(
              onPressed: getImageFromCamera,
              icon: Icon(Icons.camera_alt, color: MColors.text_button_color),
              label: Text(S.of(context).takePhoto,
                  style: MTextStyles.textMain14.copyWith(color: MColors.text_button_color)),
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: 60.w,
            child: ElevatedButton.icon(
              onPressed: getImageFromGallery,
              icon: Icon(Icons.photo_library, color: MColors.text_button_color),
              label: Text(
                S.of(context).chooseFromGallery,
                style: MTextStyles.textMain14.copyWith(color: MColors.text_button_color),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNameField(BuildContext context) {
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
          Gaps.vGap8,
          MyTextFormField(
            style: Theme.of(context).textTheme.bodySmall,
            dividerColor: Theme.of(context).dividerColor,
            decoration: InputDecoration(
              errorStyle: Theme.of(context).textTheme.bodySmall.copyWith(color: Colors.redAccent),
              contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.primary_light_color)),
              counterText: "",
              hintStyle: Theme.of(context).textTheme.displaySmall,
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(50),
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z أ-ي]")),
            ],
            maxLength: 50,
            maxLengthEnforced: false,
            keyboardType: TextInputType.name,
            controller: provider.nameController,
            validator: (name) {
              if (name.isEmpty) {
                return S.of(context).nameIsRequired;
              }
              return null;
            },
            autofocus: false,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          ),
          // CustomTextFormField(
          //   headLine: S.of(context).name,
          //   hintText: S.of(context).name,
          //   controller: TextEditingController(text: provider.instance.name),
          //   validation: (val) {
          //     if (val.isEmpty) {
          //       return S.of(context).nameIsRequired;
          //     } else {
          //       provider.name = val;
          //     }
          //   },
          // ),
        ],
      ),
    );
  }

  Widget buildEmailField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .872,
      margin: EdgeInsetsDirectional.only(start: 1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CustomTextFormField(
          //   headLine: S.of(context).emailAddress,
          //   hintText: S.of(context).emailAddress,
          //   controller: TextEditingController(text: provider.instance.email),
          //   validation: (val) {
          //     if (val.isEmpty) {
          //       return S.of(context).emailisrequired;
          //     } else if (!Utils.isEmailValid(val)) {
          //       return S.of(context).emailisnotvalid;
          //     } else {
          //       provider.email = val;
          //     }
          //   },
          // ),
          Text(
            S.of(context).emailAddress,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Gaps.vGap8,
          MyTextFormField(
            style: Theme.of(context).textTheme.bodySmall,
            dividerColor: Theme.of(context).dividerColor,
            decoration: InputDecoration(
              errorStyle: Theme.of(context).textTheme.bodySmall.copyWith(color: Colors.redAccent),
              contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.primary_light_color)),
              counterText: "",
              hintStyle: Theme.of(context).textTheme.displaySmall,
            ),
            inputFormatters: [LengthLimitingTextInputFormatter(50)],
            maxLength: 50,
            maxLengthEnforced: false,
            keyboardType: TextInputType.emailAddress,
            controller: provider.emailController,
            validator: (email) {
              if (email.isEmpty) {
                return S.of(context).emailisrequired;
              } else if (!Utils.isEmailValid(email)) {
                return S.of(context).emailisnotvalid;
              }
              return null;
            },
            autofocus: false,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
          Gaps.vGap8,
          IntlPhoneField(
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              hintStyle: Theme.of(context).textTheme.displaySmall,
              counterText: "",
              errorStyle: Theme.of(context).textTheme.bodySmall.copyWith(color: Colors.redAccent),
              contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.primary_light_color)),
            ),
            showCountryFlag: false,
            controller: provider.mobileController,
            keyboardType: TextInputType.phone,
            showDropdownIcon: false,
            initialCountryCode: 'AE',
            onChanged: (phone) {
            },
            onCountryChanged: (country) {
            },
          ),
        ],
      ),
    );
  }

  Widget buildOldPasswordField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .872,
      margin: EdgeInsetsDirectional.only(start: 1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).yourOldPassword,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Gaps.vGap8,
          MyTextFormField(
            obscureText: provider.obscureTextPassword,
            maxLength: 60,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              errorStyle: Theme.of(context).textTheme.bodySmall.copyWith(color: Colors.redAccent),
              hintText: ".........",
              contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
              suffixIcon: GestureDetector(
                  onTap: () {
                    provider.obscureTextPassword = !provider.obscureTextPassword;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      ImageUtils.getSVGPath(provider.obscureTextPassword ? "eye_password" : 'hide_eye'),
                      color: MColors.blueButtonColor,
                    ),
                  )),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.primary_light_color)),
              counterText: "",
              hintStyle: Theme.of(context).textTheme.displaySmall,
            ),
            inputFormatters: [LengthLimitingTextInputFormatter(50)],
            controller: oldPasswordController,
            validator: (text) {
              if (passwordController.text.isEmpty) {
                return S.of(context).passwordisrequired;
              }
              return null;
            },
            onSaved: (text) {
              passwordController.text = text;
            },
            autofocus: false,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          ),
        ],
      ),
    );
  }

  Widget buildPasswordField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .872,
      margin: EdgeInsetsDirectional.only(start: 1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).password,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Gaps.vGap8,
          MyTextFormField(
            obscureText: provider.obscureTextPassword,
            maxLength: 60,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              errorStyle: Theme.of(context).textTheme.bodySmall.copyWith(color: Colors.redAccent),
              hintText: ".........",
              contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
              suffixIcon: GestureDetector(
                  onTap: () {
                    provider.obscureTextPassword = !provider.obscureTextPassword;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      ImageUtils.getSVGPath(provider.obscureTextPassword ? "eye_password" : 'hide_eye'),
                      color: MColors.blueButtonColor,
                    ),
                  )),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.primary_light_color)),
              counterText: "",
              hintStyle: Theme.of(context).textTheme.displaySmall,
            ),
            inputFormatters: [LengthLimitingTextInputFormatter(50)],
            controller: passwordController,
            validator: (text) {
              if (passwordController.text.isEmpty) {
                return S.of(context).passwordisrequired;
              }
              if (passwordController.text.length < 8) {
                return S.of(context).passwordistooshort;
              }
              if (passwordController.text.length > 20) {
                return S.of(context).passwordIsTooLong;
              }
              return null;
            },
            onSaved: (text) {
              passwordController.text = text;
            },
            autofocus: false,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          ),
        ],
      ),
    );
  }

  Widget buildConfirmPasswordField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .872,
      margin: EdgeInsetsDirectional.only(start: 1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).confirmPassword,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Gaps.vGap8,
          MyTextFormField(
            obscureText: provider.obscureTextPassword,
            maxLength: 60,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              errorStyle: Theme.of(context).textTheme.bodySmall.copyWith(color: Colors.redAccent),
              hintText: ".........",
              contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
              suffixIcon: GestureDetector(
                  onTap: () {
                    provider.obscureTextPassword = !provider.obscureTextPassword;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      ImageUtils.getSVGPath(provider.obscureTextPassword ? "eye_password" : 'hide_eye'),
                      color: MColors.blueButtonColor,
                    ),
                  )
                  // Icon(_obscureTextPassword ? Icons.visibility : Icons.visibility_off, color: MColors.primary_color),
                  ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.primary_light_color)),
              counterText: "",
              hintStyle: Theme.of(context).textTheme.displaySmall,
            ),
            inputFormatters: [LengthLimitingTextInputFormatter(50)],
            controller: confirmPasswordController,
            validator: (text) {
              if (confirmPasswordController.text.isEmpty) {
                return S.of(context).passwordisrequired;
              }
              if (confirmPasswordController.text.length < 8) {
                return S.of(context).passwordistooshort;
              }
              if (confirmPasswordController.text.length > 20) {
                return S.of(context).passwordIsTooLong;
              }
              if (confirmPasswordController.text != passwordController.text) {
                return "Password doesn't match";
              }
              return null;
            },
            onSaved: (text) {
              confirmPasswordController.text = text;
            },
            autofocus: false,
            textInputAction: TextInputAction.done,
            onEditingComplete: () => {
              FocusScope.of(context).unfocus(),
              // _submitForm(),
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoContent(EditProfileProvider provider) {
    return Container(
      decoration: BoxDecoration(color: MColors.whiteE, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Form(
        key: provider.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildNameField(context),
            Gaps.vGap12,
            Gaps.vGap8,
            buildEmailField(context),
            // Gaps.vGap8,
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 4.w),
            //   child: InkWell(
            //     onTap: () {},
            //     child: Row(
            //       children: [
            //         SvgPicture.asset(ImageUtils.getSVGPath("plus_icon")),
            //         Gaps.hGap8,
            //         Text(S.of(context).updateSecondaryEmail,
            //             style: MTextStyles.textMain14.copyWith(color: MColors.text_button_color))
            //       ],
            //     ),
            //   ),
            // ),
            Gaps.vGap12,
            Gaps.vGap8,
            buildPhoneField(context),
            Gaps.vGap12,
            Gaps.vGap8,
            buildNotificationToggle(context),
            Gaps.vGap12,
            Gaps.vGap8,
            buildEditProfileButton(onTap: () {
              // editProfile();
              if (provider.formKey.currentState.validate()) {
                FocusScope.of(context).unfocus();
                if (provider.emailController.text.isEmpty ||
                    provider.nameController.text.isEmpty) {
                  showToasts(
                      S.current.enterAllData,'warning');
                } else {
                  // profileProvider.formKey.currentState.save();
                  FocusScope.of(context).unfocus();
                  editProfile();
                }
              } else {
                showToasts(
                    S.of(context).enterAllData,'warning');
              }
            }),
          ],
        ),
      ),
    );
  }

  void editProfile() async {
    print("!@@!@!@!@!@!@!@ ${_image.path}");
    if (_image != null) {
      FormData formData = new FormData.fromMap({
        "image": await MultipartFile.fromFile(
          _image.path,
          contentType: new MediaType('image', 'jpg'),
        ),
        "mobile": provider.mobileController.text,
        "name": provider.nameController.text,
        "email": provider.emailController.text,
        "email_notifications": provider.isNotificationEnabled
      });
      mPresenter.editProfileApiCall(formData);
    } else {
      Map<String, dynamic> params = Map();
      params['mobile'] = provider.mobileController.text;
      params['name'] = provider.nameController.text;
      params['email'] = provider.emailController.text;
      params['email_notifications'] = provider.isNotificationEnabled;
      mPresenter.editProfileApiCall(params);
    }
  }

  // bool noDataChanged() {
  //   if (emailController.text == provider.instance.email &&
  //       phoneNumberController.text == provider.instance.profile.mobile &&
  //       nameController.text == provider.instance.name &&
  //       _image == provider.instance.avatar) return true;
  //   return false;
  // }

  Widget _buildUpdatePasswordContent(EditProfileProvider provider) {
    return Container(
      decoration: BoxDecoration(color: MColors.whiteE, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildOldPasswordField(context),
            Gaps.vGap12,
            Gaps.vGap8,
            buildPasswordField(context),
            Gaps.vGap12,
            Gaps.vGap8,
            buildConfirmPasswordField(context),
            Gaps.vGap12,
            Gaps.vGap8,
            buildEditProfileButton(onTap: () {
              mPresenter.doEditPassword({
                "old_password": oldPasswordController.text,
                "password": passwordController.text,
                "password_confirmation": confirmPasswordController.text,
              });
            }),
          ],
        ),
      ),
    );
  }

  @override
  EditProfilePresenter createPresenter() {
    return EditProfilePresenter();
  }

  @override
  bool get wantKeepAlive => false;
}
