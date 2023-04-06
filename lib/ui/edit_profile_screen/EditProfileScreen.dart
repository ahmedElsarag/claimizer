import 'dart:io';

import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/base/view/base_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';
import '../../CommonUtils/utils.dart';
import '../../app_widgets/CustomTextField.dart';
import '../../app_widgets/app_headline.dart';
import '../../app_widgets/claimizer_app_bar.dart';
import '../../app_widgets/image_loader.dart';
import '../../generated/l10n.dart';
import '../../network/models/ProfileResponse.dart';
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
  EditProfileProvider provider = EditProfileProvider();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  File _image;
  final picker = ImagePicker();
  bool _isNotificationEnabled = true;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    mPresenter.getProfileData();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditProfileProvider>(
      create: (context) => provider,
      builder: (context, child) => Consumer<EditProfileProvider>(
          builder: (context, value, child) => DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Scaffold(
                  backgroundColor: MColors.page_background,
                  body: provider.instance != null
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
                                                        builder: (_) => buildPickImageDialog(context));
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
                                              provider.selectedTabIndex = index;
                                            },
                                            tabs: [
                                              Tab(text: 'Basic Info'),
                                              Tab(text: 'Update Password'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gaps.vGap16,
                                  Gaps.vGap12,
                                  Container(
                                    child: provider.selectedTabIndex == 0
                                        ? _buildBasicInfoContent()
                                        : _buildUpdatePasswordContent(),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        )
                      : mPresenter.showProgress(),
                ),
              )),
    );
  }

  Column buildNotificationToggle(BuildContext context) {
    return Column(
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
                  value: true,
                  groupValue: _isNotificationEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isNotificationEnabled = value;
                    });
                  },
                ),
                Text(S.of(context).enable),
              ],
            ),
            SizedBox(width: 16.0),
            Radio(
              fillColor: MaterialStateProperty.all<Color>(MColors.text_button_color),
              value: false,
              groupValue: _isNotificationEnabled,
              onChanged: (value) {
                setState(() {
                  _isNotificationEnabled = value;
                });
              },
            ),
            Text(S.of(context).disable),
          ],
        ),
      ],
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
        "Save Changes",
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
              hintText: provider.instance.name,
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
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Zأ-ي]")),
            ],
            maxLength: 50,
            maxLengthEnforced: false,
            keyboardType: TextInputType.name,
            controller: nameController,
            validator: (name) {
              if (name.isEmpty) {
                return "Name is required";
              }
              return null;
            },
            onSaved: (text) {
              nameController.text = text;
            },
            autofocus: false,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          ),
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
          Text(
            S.of(context).emailAddress,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Gaps.vGap8,
          MyTextFormField(
            style: Theme.of(context).textTheme.bodySmall,
            dividerColor: Theme.of(context).dividerColor,
            decoration: InputDecoration(
              hintText: provider.instance.email,
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
            controller: emailController,
            validator: (email) {
              if (email.isEmpty) {
                return S.of(context).emailisrequired;
              } else if (!Utils.isEmailValid(email)) {
                return S.of(context).emailisnotvalid;
              }
              return null;
            },
            onSaved: (text) {
              emailController.text = text;
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
              hintText: "123456789",
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
            controller: phoneNumberController,
            keyboardType: TextInputType.phone,
            showDropdownIcon: false,
            initialCountryCode: 'SA',
            onChanged: (phone) {
              print(phone.completeNumber);
            },
            onCountryChanged: (country) {
              print('Country changed to: ' + country.name);
            },
            onSubmitted: (p0) => FocusScope.of(context).nextFocus(),
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

  Widget _buildBasicInfoContent() {
    return Container(
      decoration: BoxDecoration(color: MColors.whiteE, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildNameField(context),
            Gaps.vGap12,
            Gaps.vGap8,
            buildEmailField(context),
            Gaps.vGap8,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    SvgPicture.asset(ImageUtils.getSVGPath("plus_icon")),
                    Gaps.hGap8,
                    Text(S.of(context).updateSecondaryEmail,
                        style: MTextStyles.textMain14.copyWith(color: MColors.text_button_color))
                  ],
                ),
              ),
            ),
            Gaps.vGap12,
            Gaps.vGap8,
            buildPhoneField(context),
            Gaps.vGap12,
            Gaps.vGap8,
            buildNotificationToggle(context),
            Gaps.vGap12,
            Gaps.vGap8,
            buildEditProfileButton(onTap: () {
              editProfile();
            }),
          ],
        ),
      ),
    );
  }

  void editProfile() async {
    FormData formData = new FormData.fromMap({
      // "image": await MultipartFile.fromFile(
      //   _image.path,
      //   contentType: new MediaType('image', 'jpg'),
      // ),
      "email": emailController.text,
      "phone": phoneNumberController.text,
      "name": nameController.text,
    });
      mPresenter.doEditBasicInfoApiCall(formData);
    if (!noDataChanged())
      mPresenter.doEditBasicInfoApiCall(formData);
    else if (noDataChanged() && _image == null) showToasts('no data changed');
  }

  bool noDataChanged() {
    if (emailController.text == provider.instance.email &&
        phoneNumberController.text == provider.instance.profile.mobile &&
        nameController.text == provider.instance.name &&
        _image == provider.instance.avatar) return true;
    return false;
  }

  Widget _buildUpdatePasswordContent() {
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
              print("edit password");
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
  bool get wantKeepAlive => true;
}
