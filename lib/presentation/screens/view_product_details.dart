import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:services/business_logic/cubit/services_cubit.dart';
import 'package:services/business_logic/cubit/services_states.dart';
import 'package:services/business_logic/localization_cubit/app_localization.dart';
import 'package:services/styles/color_manager/color_manager.dart';

class ViewServicesDetails extends StatelessWidget {
  final String productImage;
  final String productName;
  final String productPrice;
  final String productDescribtion;
  final String productCategory;
  const ViewServicesDetails({
    Key? key,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productDescribtion,
    required this.productCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit,ServicesStates>(
        listener: (context,state){

        },
       builder: (context,state){
          return Scaffold(
            backgroundColor: ColorManager.darkGrey,
            appBar: AppBar(
              titleSpacing: 0.0,
              backgroundColor: ColorManager.darkGrey,
              title:  Text(
                AppLocalizations.of(context)!.translate('serviceDetails').toString(),
                style: GoogleFonts.almarai(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.white,
                ),
                textAlign: TextAlign.center,
              ),
              elevation: 0.0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: ColorManager.darkGrey,
                  statusBarIconBrightness: Brightness.light
              ),
            ),

            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(image: NetworkImage(productImage),
                    height: MediaQuery.of(context).size.height*.25,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*.02,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                        AppLocalizations.of(context)!.translate('serviceName').toString(),
                          style: GoogleFonts.almarai(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.white,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height*.02,),

                        Text(
                          productName,
                          style: GoogleFonts.almarai(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.lightColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*.02,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.translate('servicePrice').toString(),
                          style: GoogleFonts.almarai(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.white,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height*.02,),

                        Text(
                          productPrice,
                          style: GoogleFonts.almarai(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.lightColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*.02,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.translate('serviceDes').toString(),
                          style: GoogleFonts.almarai(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.white,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height*.02,),

                        Text(
                          productDescribtion,
                          style: GoogleFonts.almarai(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.lightColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
       },
    );
  }
}
