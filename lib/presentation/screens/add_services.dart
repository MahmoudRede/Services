import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:services/business_logic/cubit/services_cubit.dart';
import 'package:services/business_logic/cubit/services_states.dart';
import 'package:services/business_logic/localization_cubit/app_localization.dart';
import 'package:services/presentation/screens/services_screen.dart';
import 'package:services/presentation/screens/verified_screen.dart';
import 'package:services/presentation/widgets/default_text_field.dart';
import 'package:services/styles/color_manager/color_manager.dart';

class AddProductScreen extends StatelessWidget {

  final String ?categoryName;
  static TextEditingController name=TextEditingController();
  static TextEditingController price=TextEditingController();
  static TextEditingController describtion=TextEditingController();

  @override
  var formKey=GlobalKey<FormState>();

   AddProductScreen({Key? key,required this.categoryName}) : super(key: key);

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
            elevation: 0.0,
            backgroundColor: ColorManager.darkGrey,
            title: Text(AppLocalizations.of(context)!.translate('addService').toString(),style:GoogleFonts.cairo(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: ColorManager.white,
            ),),

          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Text(AppLocalizations.of(context)!.translate('addImageService').toString(),style:GoogleFonts.almarai(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.white,
                    ),),

                    SizedBox(height: MediaQuery.of(context).size.height*.03,),

                    GestureDetector(
                      onTap: (){
                        cubit.getProductImage();
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          height: MediaQuery.of(context).size.height*.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                  color: ColorManager.textColor
                              )
                          ),
                          child:
                          cubit.productImage ==null?
                          const Image(
                              image: NetworkImage('https://img.freepik.com/premium-vector/illustrated-signboard_592324-10076.jpg')
                          ):
                          Image(
                            image: FileImage(cubit.productImage!),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.05,),
                    Text(AppLocalizations.of(context)!.translate('addNameService').toString(),style:GoogleFonts.almarai(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.white,
                    ),),
                    SizedBox(height: MediaQuery.of(context).size.height*.025,),

                    DefaultTextField(
                        hintText: AppLocalizations.of(context)!.translate('serviceName').toString(),
                        controller: name,
                        textInputType: TextInputType.text,
                        prefixIcon: Icons.recycling
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.05,),
                    Text(AppLocalizations.of(context)!.translate('addPriceService').toString(),style:GoogleFonts.almarai(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.white,
                    ),),
                    SizedBox(height: MediaQuery.of(context).size.height*.025,),

                    DefaultTextField(
                        hintText: AppLocalizations.of(context)!.translate('servicePrice').toString(),
                        controller: price,
                        textInputType: TextInputType.text,
                        prefixIcon: Icons.money
                    ),


                    SizedBox(height: MediaQuery.of(context).size.height*.035,),
                    Text(AppLocalizations.of(context)!.translate('addDesService').toString(),style:GoogleFonts.almarai(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.white,
                    ),),
                    SizedBox(height: MediaQuery.of(context).size.height*.025,),

                    DefaultTextField(
                      hintText: AppLocalizations.of(context)!.translate('serviceDes').toString(),
                      controller: describtion,
                      lines: 5,
                      textInputType: TextInputType.text,
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.02,),


                    state is AddProductLoadingStates || state is UploadProductImageLoadingState?
                    const Center(
                      child: CircularProgressIndicator(color: ColorManager.white,),
                    ):
                    Container(
                      margin: EdgeInsets.all(MediaQuery.of(context).size.height*.02),
                      width: MediaQuery.of(context).size.width,
                      child: MaterialButton(
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)
                        ),

                        color: ColorManager.primaryColor,
                        onPressed: (){

                          if(formKey.currentState!.validate()){

                            cubit.uploadProductImage(
                                productName: name.text,
                                productPrice: price.text,
                                productDescription: describtion.text,
                                productCategory: categoryName!
                            ).then((value) {
                              name.clear();
                              price.clear();
                              describtion.clear();
                              cubit.productImage=null;
                            });


                          }

                          Navigator.push(context, MaterialPageRoute(builder: (_){

                            return const VerifiedScreen();

                          }));



                        },
                        child:Text(AppLocalizations.of(context)!.translate('addService').toString(),style: GoogleFonts.almarai(
                            fontWeight: FontWeight.w600,
                            fontSize: MediaQuery.of(context).size.height*.022,
                            color: ColorManager.white
                        ),),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
