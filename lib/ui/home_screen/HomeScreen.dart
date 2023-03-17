import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/app_widgets/headline.dart';
import 'package:Cliamizer/app_widgets/horizontal_list.dart';
import 'package:Cliamizer/ui/home_screen/widgets/bannerSliderComponent.dart';
import 'package:Cliamizer/ui/home_screen/widgets/home_list_item.dart';
import 'package:Cliamizer/ui/home_screen/widgets/top_shape.dart';

import '../../app_widgets/TextWidgets.dart';
import '../../res/colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.background_color,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 200,
                      child: Text('Welcome, Ahmed Elsarag',maxLines:2,style: TextStyle(color: MColors.headline_text_color,fontSize: 14.sp,fontWeight: FontWeight.bold)),),
                    Spacer(),
                    SvgPicture.asset(ImageUtils.getSVGPath('notification')),
                    SizedBox(width: 8,),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: Colors.grey
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsetsDirectional.only(start: 6),
                      width: 3.5,
                      height: 16,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.red),

                    ),
                    SizedBox(width: 6,),
                    Text('Statistics For Your Claims',maxLines:1,style: TextStyle(color: MColors.headline_text_color,fontSize: 16,fontWeight: FontWeight.w600)),

                  ],
                ),
              ),


              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Towe A5 - Owned',style: TextStyle(fontSize: 16,fontWeight:FontWeight.w600,color: Colors.black),),
                            SizedBox(height: 4,),
                            Text('Request Code #123-45-567',style: TextStyle(fontSize: 12,fontWeight:FontWeight.w500,color: Colors.black45),),
                          ],
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.blue.withOpacity(.2)
                          ),
                          child: Text('New',style: TextStyle(fontSize: 14,color: Colors.blue),),
                        )
                      ],
                    ),
                    SizedBox(height: 16,),
                    Divider(height: 1,color: Colors.black,),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        Text('Unit Name',style: TextStyle(fontSize: 12,color: Colors.black54),),
                        Spacer(),
                        Text('Tower A5 - Owned',style: TextStyle(fontSize: 12,color: Colors.black45),),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Divider(height: 1,color: Colors.black,),
                    SizedBox(height: 16,),
                  ],
                ),
              ),

              Container(
                width: 200,
                height: 100,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blue.withOpacity(.1)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('234',style: TextStyle(color: Colors.blue,fontSize: 18,fontWeight: FontWeight.bold),),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              color: Colors.blue.withOpacity(.2)
                          ),
                          child: Icon(Icons.add_box,color: Colors.blue,size: 20,),
                        )
                      ],
                    ),
                    Spacer(),
                    Text('All Categories',style: TextStyle(color: Colors.black87,fontSize: 14),),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 320,
                    height: 130,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                  color: Colors.blue.withOpacity(.2)
                              ),
                              child: Icon(Icons.add_box,color: Colors.blue,size: 20,),
                            ),
                            SizedBox(width: 10,),
                            Expanded(child: Text('You Need To Renew The Contract',maxLines:2,style: TextStyle(color: Colors.black.withOpacity(.8),fontSize: 16,fontWeight: FontWeight.w500),)),
                            Icon(Icons.arrow_circle_left_rounded,color: Colors.red,),
                          ],
                        ),
                        Spacer(),
                        Text('You Need To Renew The Contract, You Need To Renew The Contract',maxLines:2,style: TextStyle(color: Colors.black54,fontSize: 12,)),
                      ],
                    ),
                  ),
                ),
              )

            ],
          )
        ),
      ),
    );
  }
}


