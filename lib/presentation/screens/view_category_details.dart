import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:services/business_logic/cubit/services_cubit.dart';
import 'package:services/business_logic/cubit/services_states.dart';
import 'package:services/business_logic/localization_cubit/app_localization.dart';
import 'package:services/presentation/screens/add_services.dart';
import 'package:services/presentation/screens/view_product_details.dart';
import 'package:services/styles/color_manager/color_manager.dart';

class ViewCategoryDetailsScreen extends StatefulWidget {
  final String categoryName;
  const ViewCategoryDetailsScreen({Key? key,required this.categoryName}) : super(key: key);

  @override
  State<ViewCategoryDetailsScreen> createState() => _ViewCategoryDetailsScreenState();
}

class _ViewCategoryDetailsScreenState extends State<ViewCategoryDetailsScreen> {

  @override
  void initState() {
    super.initState();

    if(widget.categoryName=='Medical Clinic'){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).medicalClinicProducts;
    }
    else if(widget.categoryName=='Dentists'){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).dentistsProducts;
    }
    else if(widget.categoryName=='Beauty Salon'){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).beautySalonProducts;
    }
    else if(widget.categoryName=='Laser'){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).laserProducts;
    }
    else if(widget.categoryName=='Nutrition\'s'){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).nutritionProducts;
    }
    else if(widget.categoryName=='Athletic coaching'){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).athleticCoachingProducts;
    }
    else if(widget.categoryName=='Healthcare '){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).healthcareProducts;
    }
    else if(widget.categoryName=='Educational training, courses'){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).educationalTrainingProducts;
    }
    else if(widget.categoryName=='Car services '){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).carServicesProducts;
    }
    else if(widget.categoryName=='Home appliances and products installments'){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).homeAppliancesProducts;
    }
    else if(widget.categoryName=='Financing and loans'){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).financingProducts;
    }
    else if(widget.categoryName=='Online, offline teacher\'s '){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).onlineProducts;
    }
    else if(widget.categoryName=='Travel agencies '){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).travelProducts;
    }
    else if(widget.categoryName=='Residential & commercial properties '){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).residentialProducts;
    }
    else if(widget.categoryName=='Clubs Events '){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).clubsEventsProducts;
    }
    else if(widget.categoryName=='Wedding organizers, parties birth days'){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).weddingProducts;
    }
    else if(widget.categoryName=='Dry Cleaning, Laundries, carpet, blankets'){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).dryCleaningProducts;
    }
    else if(widget.categoryName=='Maid Service providers'){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).maidServiceProducts;
    }
    else if(widget.categoryName=='Pet Grooming'){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).petGroomingProducts;
    }
    else if(widget.categoryName=='Home Repair and Maintenance service provider\'s'){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).homeRepairProducts;
    }
    else if(widget.categoryName=='Air conditioning Repair'){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).applianceProducts;
    }
    else if(widget.categoryName=='Gas cylinder provider\'s '){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).gasCylinderProducts;
    }
    else if(widget.categoryName=='Landscaping & Gardens care  '){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).landscapingProducts;
    }
    else if(widget.categoryName=='Nurse, senior age care giver  '){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).nurseProducts;
    }
    else if(widget.categoryName=='New & Used equipment Rent'){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).newProducts;
    }
    else if(widget.categoryName=='New restaurants, Coffee shops, meals, drinks '){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).newRestaurantsProducts;
    }
    else if(widget.categoryName=='Cleaning Services '){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).cleaningServicesProducts;
    }
    else if(widget.categoryName=='Plumbing Services '){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).plumbingServicesProducts;
    }
    else if(widget.categoryName=='Electrical Services '){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).electricalServicesProducts;
    }
    else if(widget.categoryName=='Pest Control Services '){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).pestControlServicesProducts;
    }
    else if(widget.categoryName=='Home Security Services video surveillance'){
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).homeSecurityProducts;
    }
    else{
      ServicesCubit.get(context).allProducts=ServicesCubit.get(context).paintingServicesProducts;
    }


  }
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
            child: cubit.allProducts.isNotEmpty? Container(
              padding: const EdgeInsets.all(10),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                children: List.generate(cubit.allProducts.length, (index) => GestureDetector(
                  onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder: (_){
                      return ViewServicesDetails(
                        productName: cubit.allProducts[index].productName!,
                        productPrice: cubit.allProducts[index].productPrice!,
                        productCategory: cubit.allProducts[index].productCategory!,
                        productDescribtion: cubit.allProducts[index].productDescribtion!,
                        productImage: cubit.allProducts[index].productImage!,
                      );
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
                          image: NetworkImage(cubit.allProducts[index].productImage!),
                          height: MediaQuery.of(context).size.height*.15,
                          width: double.infinity,
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height*.02,),

                        Expanded(
                          child: Text(
                            cubit.allProducts[index].productName!,
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
            ):
            Container(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*.1,),
                    Lottie.asset('assets/images/empty.json',),
                    Text(
                      AppLocalizations.of(context)!.translate('orderEmpty').toString(),
                      style: GoogleFonts.cairo(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
            ),
          ),
        );
      },

    );
  }
}
