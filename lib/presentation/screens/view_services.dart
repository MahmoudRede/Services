import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:services/business_logic/cubit/services_cubit.dart';
import 'package:services/business_logic/cubit/services_states.dart';
import 'package:services/business_logic/localization_cubit/app_localization.dart';
import 'package:services/presentation/screens/add_services.dart';
import 'package:services/presentation/screens/view_category_details.dart';
import 'package:services/styles/color_manager/color_manager.dart';

class ViewServicesScreen extends StatelessWidget {
  const ViewServicesScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit,ServicesStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit=ServicesCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.darkGrey,
          appBar: AppBar(
            titleSpacing: 0.0,
            backgroundColor: ColorManager.darkGrey,
            title:  Text(
              AppLocalizations.of(context)!.translate('services').toString(),
              style: GoogleFonts.almarai(
                fontSize: 25.0,
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
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                children: List.generate(cubit.servicesImages.length, (index) => GestureDetector(
                  onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder: (_){
                      return ViewCategoryDetailsScreen(categoryName: cubit.servicesTitles[index],);
                    }));
                  },
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: Colors.white
                        )
                    ),
                    child: Column(
                      children: [
                        Image(
                          fit: BoxFit.fill,
                          image: NetworkImage(cubit.servicesImages[index]),
                          height: MediaQuery.of(context).size.height*.15,
                          width: double.infinity,
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height*.02,),

                        Expanded(
                          child: Text(
                            cubit.servicesTitles[index],
                            style: GoogleFonts.almarai(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height*.01,),

                      ],
                    ),
                  ),
                )),
              ),
            ),
          ),
        );
      },

    );
  }
}
