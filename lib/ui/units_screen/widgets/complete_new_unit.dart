import 'package:Cliamizer/ui/units_screen/units_presenter.dart';
import 'package:Cliamizer/ui/units_screen/units_provider.dart';
import 'package:Cliamizer/ui/units_screen/widgets/build_description_field.dart';
import 'package:Cliamizer/ui/units_screen/widgets/build_file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../CommonUtils/image_utils.dart';
import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';
import 'build_qrcode_field.dart';
import 'build_start_end_date_picker_fields.dart';
import 'building_name_field.dart';
import 'company_name_field.dart';
import 'contract_number_field.dart';

class CompleteNewUnit extends StatelessWidget {
  const CompleteNewUnit({Key key, this.provider, this.presenter}) : super(key: key);
  final UnitProvider provider;
  final UnitPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitProvider>(
      builder: (context, pr, child) => Container(
        padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 4.w),
        margin: EdgeInsets.symmetric(vertical: 2.w),
        decoration: BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(S.current.newLinkRequest, style: MTextStyles.textMain18),
              ],
            ),
            Gaps.vGap8,
            Gaps.vGap8,
            Gaps.vGap8,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 1.w,
                  height: 5.w,
                  margin: EdgeInsetsDirectional.only(end: 3.w),
                  decoration: BoxDecoration(color: MColors.primary_color, borderRadius: BorderRadius.circular(4)),
                ),
                Text(S.current.unitQuery, style: MTextStyles.textMain16),
              ],
            ),
            Gaps.vGap8,
            Gaps.vGap12,
            BuildingNameField(
              provider: provider,
            ),
            Gaps.vGap8,
            CompanyNameField(
              provider: provider,
            ),
            Gaps.vGap8,
            ContractField(
              provider: provider,
            ),
            Gaps.vGap8,
            StartEndDatePickerField(),
            Gaps.vGap8,
            BuildFilePicker(provider: provider),
            Gaps.vGap8,
            BuildDescriptionField(
              provider: provider,
            ),
            Gaps.vGap12,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .4,
                  margin: EdgeInsets.symmetric(vertical: 3.w),
                  child: ElevatedButton(
                    onPressed: () {
                      pr.isQrCodeValid = !pr.isQrCodeValid;
                      pr.contractNo.clear();
                      pr.companyName.clear();
                      pr.buildingName.clear();
                      pr.description.clear();
                      pr.startDate = null;
                      pr.endDate = null;
                      pr.fileName = "";
                    },
                    child: Text(
                      S.of(context).back,
                      style: MTextStyles.textMain14.copyWith(fontWeight: FontWeight.w700),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(MColors.white),
                        elevation: MaterialStatePropertyAll(0),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), side: BorderSide(color: MColors.primary_color))),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w))),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .4,
                  margin: EdgeInsets.symmetric(vertical: 3.w),
                  child: ElevatedButton(
                    onPressed: () {
                      if (pr.contractNo.text.isEmpty && pr.startDate == null && pr.endDate == null) {
                        presenter.view.showSnackBar("msg");
                      } else {
                        print("@@@@@@@@@@@@@@@@data ${pr.qrCode.text}");
                        presenter.completeLinkRequestApiCall({
                          "unit_code": pr.qrCode.text,
                          "contract_number": pr.contractNo.text,
                          "start_at": pr.startDate.toString(),
                          "end_at": pr.endDate.toString(),
                        });
                      }
                    },
                    child: Text(
                      S.of(context).confirm,
                      style: MTextStyles.textWhite14.copyWith(fontWeight: FontWeight.w700),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(MColors.primary_color),
                        elevation: MaterialStatePropertyAll(0),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w))),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}