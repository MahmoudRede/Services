import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:services/business_logic/cubit/services_states.dart';
import 'package:services/constants/constants.dart';
import 'package:services/data/model/product_model.dart';
import 'package:services/data/model/user_model.dart';
import 'package:services/uitiles/local/cash_helper.dart';

class ServicesCubit extends Cubit<ServicesStates>{


  ServicesCubit():super(InitialState());

  static ServicesCubit get(context)=>BlocProvider.of(context);



  List<String> servicesImages=[
    'https://img.freepik.com/free-vector/medical-elements-collection_1212-262.jpg?w=740&t=st=1685021101~exp=1685021701~hmac=a009c8ff741ec836a34ba1e41b66de903b8d9685e8ca4c22dc71e4da72746063',
    'https://img.freepik.com/free-photo/dental-hygiene-concept-with-blue-background_23-2150312461.jpg?w=740&t=st=1685021278~exp=1685021878~hmac=f90cba44b77e3ef17ec666793abe39fc1397070fa7e424dd8c6e1d14abe32997',
    'https://img.freepik.com/free-photo/modern-beauty-salon-interior_23-2148910541.jpg?w=740&t=st=1685021362~exp=1685021962~hmac=ce0db2631698654b39d3d7d2b196f029f2a5fb26cf65e78c9e5a1f2e6e75798a',
    'https://img.freepik.com/free-vector/epilation-procedure-illustration_1284-32617.jpg?w=740&t=st=1685021583~exp=1685022183~hmac=9e9516dc5271e468dfd05b99f8ff5dfe3a86bf17f119ed469200003ad02f8bda',
    'https://img.freepik.com/free-vector/healthy-nutrition-dietitian-recommendation-flat-composition-with-body-mass-index-control-vegetables-salmon-eggs-supplements_1284-60046.jpg?w=740&t=st=1685021838~exp=1685022438~hmac=f90ac22198c63505afac47356411614bc4b7b9e1215872a1cab3dcabe5ed70e5',
    'https://img.freepik.com/free-photo/athlete-playing-sport-with-hand-drawn-doodles_23-2150036350.jpg?w=360&t=st=1685021905~exp=1685022505~hmac=2a857c331ae1f70f744906e89f194d2d8edb9ae70d5553533d869a564336e123',
    'https://img.freepik.com/free-photo/medical-banner-with-doctor-wearing-glove_23-2149611205.jpg?w=826&t=st=1685021966~exp=1685022566~hmac=22900ef475ef4a9b24d34ec6c2c4e5e734526f4b659193908fe2a8e21d0a4bde',
    'https://img.freepik.com/free-vector/higher-education-characters-elements-composition-set-with-learning-knowledge-student-isolated-vector-illustration_98292-6627.jpg?w=740&t=st=1685022014~exp=1685022614~hmac=0bd8296c550a430e392fdb8096d3a38417df40fae7820937411f8a0a3ce858e1',
    'https://img.freepik.com/free-vector/linear-flat-technical-car-diagnostic-dismantling-repair-service-concepts-set-website-hero-images-tire-fix-motor-battery-test-mechanic-workers-happy-client-characters_126523-2725.jpg?w=740&t=st=1685096514~exp=1685097114~hmac=fa177a46002eb3d0859a6c2017ee60f7a4dbcc37796e96abd189960b6eb2de1d',
    'https://img.freepik.com/free-vector/internet-things-home-automation-system-iot-retro-cartoon-composition-poster_1284-14825.jpg?w=740&t=st=1685096608~exp=1685097208~hmac=d1665a6fba370978669a309a95f3747fcf8316cb7f4e9fc11bc998855ba1a25c',
    'https://img.freepik.com/free-photo/loan-agreement-budget-capital-credit-borrow-concept_53876-127721.jpg?w=740&t=st=1685096706~exp=1685097306~hmac=b010dde758f2ecacc23d997fc3d3df802c9d3b2963c1ccfed30e6c3f0d3d240f',
    'https://img.freepik.com/free-vector/online-courses-concept_23-2148529257.jpg?w=740&t=st=1685096752~exp=1685097352~hmac=9aac05687ed96d0d51c3f21df9bd1b23b6298483584a04fd73e7ef1f6408ae74',
    'https://img.freepik.com/free-photo/world-tourism-day-with-lettering_23-2148608839.jpg?w=740&t=st=1685096837~exp=1685097437~hmac=875f216be867061ddb52f418a1c81e602e0084299003d9844c2132b7a596c9c3',
    'https://img.freepik.com/free-vector/smart-city-illustration_24908-57048.jpg?w=740&t=st=1685096918~exp=1685097518~hmac=8c693fe817e70cb5b028495d0ac12a98f2c9e97a48b11b56cee8de064d3526db',
    'https://img.freepik.com/free-photo/festive-friends-home-party_23-2147651788.jpg?w=740&t=st=1685097026~exp=1685097626~hmac=d769b9163587b6b5608cab0c9b6d2adaf9a791bed1da4fe268d49c074f15b63b',
    'https://img.freepik.com/free-photo/front-view-quinceanera-arrangement-birthday-girl_23-2148478064.jpg?w=740&t=st=1685097161~exp=1685097761~hmac=741b7c40cf3b32df5eae79294b1b71a3c936a89daa6c55a82bd8ab822a0a8ce8',
    'https://img.freepik.com/free-photo/unrecognizable-man-ironing-shirts-laundry-home_1098-17141.jpg?w=740&t=st=1685097265~exp=1685097865~hmac=785034afc164ef4a19cacda3cc29eadd11544b72075bbdb54fe76dab08b4d87f',
    'https://img.freepik.com/free-photo/hotel-maid-knocking-hotel-door-room-service_171337-12721.jpg?w=740&t=st=1685097350~exp=1685097950~hmac=3ffa378f64322e72195211056f6269bba96539c95c9cf299cad3bebf75dbb584',
    'https://img.freepik.com/free-vector/pet-care-concept-illustration_114360-9499.jpg?w=740&t=st=1685097412~exp=1685098012~hmac=07e1111e8b7d3b66b108ad5e2a0b1c0654214af9a0f3aa4876a112a00e7b79f0',
    'https://img.freepik.com/free-vector/home-renovation-concept_1284-6314.jpg?w=740&t=st=1685097464~exp=1685098064~hmac=d6de0c9d7f5a7e2826e95b1ea477e999de84cc3191727d26e9a849fb6be56c70',
    'https://img.freepik.com/free-vector/professional-technicians-repair-solve-various-equipment-problems-house_1150-39383.jpg?w=740&t=st=1685097546~exp=1685098146~hmac=ddc726d35674e2198ca8de322eb1b369d4b8201c0214e72878bd80885fa91e04',
    'https://img.freepik.com/free-photo/3d-rendering-gas-cylinder_23-2149290453.jpg?w=740&t=st=1685097611~exp=1685098211~hmac=e5d8ac4985d33ac8d74609cf3033dfef7abd8cbe7ec9a95f5cdf91ac2755b2f9',
    'https://img.freepik.com/free-photo/gardener_23-2148013417.jpg?w=740&t=st=1685097671~exp=1685098271~hmac=ad114da18e438f8083b7498288b902409f64fbe0bac51e1311c627d22213d788',
    'https://img.freepik.com/free-photo/nurse-retirement-home-listening-old-sick-man-heart-bead-pensioner-lies-hospital-bed_482257-20652.jpg?w=900&t=st=1685097764~exp=1685098364~hmac=b77a2922820c68129cd97669360ff64c301bc979518578934aedf3aadc51b72e',
    'https://img.freepik.com/free-photo/supply-chain-representation-still-life_23-2150172377.jpg?w=740&t=st=1685097829~exp=1685098429~hmac=bbd065c9b0550b44e39273472f7ef78efb0d7089b7a0356692cf29940101c902',
    'https://img.freepik.com/free-vector/isometric-business-lunch-people-colored-composition_1284-24397.jpg?w=740&t=st=1685097884~exp=1685098484~hmac=66ef7031e6670c917c2ecd1db2c40e68c33bf27242cad0266bf4ebf7fabc81a2',
    'https://img.freepik.com/free-vector/hand-drawn-cleaning-services-infographic_23-2150105830.jpg?w=740&t=st=1685097936~exp=1685098536~hmac=9865c5cafafdc595561c81a4f002e69774c95524007e0a945b9d8a1fb9e54fdc',
    'https://img.freepik.com/free-vector/plumbing-service-advertising-banner-repairman-uniform-standing-with-wrench-hand-tools-box-near-sink_575670-1705.jpg?w=740&t=st=1685097993~exp=1685098593~hmac=f9dd912391e74f4f5c68d149983144bd49fd18aa52b865a149b0f32a738d7d4e',
    'https://img.freepik.com/free-vector/professional-electrician-round_98292-7301.jpg?w=740&t=st=1685099603~exp=1685100203~hmac=f9c9d42ef79cf66643b03da34ca5c3e5ba7adc8b71134329141afe8c630fc1cc',
    'https://img.freepik.com/free-vector/pest-control-services-flat-infographic-poster_1284-15469.jpg?w=740&t=st=1685099643~exp=1685100243~hmac=76ffcde890aa32f841c60a64332c384281e4c14d2489f3bc75ce3dc10654825d',
    'https://img.freepik.com/free-vector/wireless-smart-home-automation-infographic_1284-54599.jpg?w=740&t=st=1685099697~exp=1685100297~hmac=89a29064df2cf9dd53c9ec31683d43ff44e456d45ca94bbc451771ae56836f67',
    'https://img.freepik.com/free-vector/business-man-painting-bar-graph-with-roller-paint_3446-427.jpg?w=740&t=st=1685099748~exp=1685100348~hmac=aab5d8d27d0ec483cd4718a2df890cd252771d0cf3d84fc3f32bdb7b6d2c5161',
  ];

  List<String> servicesTitles=[
    'Medical Clinic', 'Dentists', 'Beauty Salon', 'Laser', 'Nutrition\'s', 'Athletic coaching', 'Healthcare ',
    'Educational training, courses', 'Car services ', 'Home appliances and products installments', 'Financing and loans',
    'Online, offline teacher\'s ','Travel agencies ','Residential & commercial properties ','Clubs Events ',
    'Wedding organizers, parties birth days','Dry Cleaning, Laundries, carpet, blankets','Maid Service providers',
    'Pet Grooming','Home Repair and Maintenance service provider\'s','Air conditioning Repair',
    'Gas cylinder provider\'s ','Landscaping & Gardens care  ','Nurse, senior age care giver  ','New & Used equipment Rent',
    'New restaurants, Coffee shops, meals, drinks ','Cleaning Services ','Plumbing Services ','Electrical Services ',
    'Pest Control Services ','Home Security Services video surveillance','Painting Services ',

  ];

  List<ProductModel> medicalClinicProducts=[],dentistsProducts=[],beautySalonProducts=[],laserProducts=[],nutritionProducts=[];
  List<ProductModel> athleticCoachingProducts=[],healthcareProducts=[],educationalTrainingProducts=[],carServicesProducts=[],homeAppliancesProducts=[];
  List<ProductModel> financingProducts=[],onlineProducts=[],travelProducts=[],residentialProducts=[],clubsEventsProducts=[];
  List<ProductModel> weddingProducts=[],dryCleaningProducts=[],maidServiceProducts=[],petGroomingProducts=[],homeRepairProducts=[];
  List<ProductModel> applianceProducts=[],gasCylinderProducts=[],landscapingProducts=[],nurseProducts=[],newProducts=[];
  List<ProductModel> newRestaurantsProducts=[],cleaningServicesProducts=[],plumbingServicesProducts=[],electricalServicesProducts=[],pestControlServicesProducts=[];
  List<ProductModel> homeSecurityProducts=[],paintingServicesProducts=[];


  void userLogin({
     required String email,
     required String password,
    }){

    emit(UserLoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {

        debugPrint('User Login Successful');
        CashHelper.saveData(key: 'uId',value: value.user!.uid);
        uId=value.user!.uid;
        emit(UserLoginSuccessState(value.user!.uid));
    }).catchError((error){

      debugPrint('Error in userLogin is ${error.toString()}');
      emit(UserLoginErrorState());

    });



  }

  void userRegister({
    required String email,
    required String phone,
    required String name,
    required String password,
    required String countryCode,
  }){

    emit(UserRegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {

        saveUser(
            email: email,
            phone: phone,
            name: name,
            countryCode: countryCode,
            uId: value.user!.uid,
        );
        debugPrint('User Register Successful');
        emit(UserRegisterSuccessState());
    }).catchError((error){

      debugPrint('Error in userRegister is ${error.toString()}');
      emit(UserRegisterErrorState());

    });

}


  void saveUser({
    required String email,
    required String phone,
    required String name,
    required String uId,
    required String countryCode,
  }){

    UserModel userModel=UserModel(
        name: name,
        phoneNumber: phone,
        email: email,
        countryCode: countryCode,
        uId: uId
    );
    emit(SaveUserDataLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap()).then((value) {

        debugPrint('Save User Data Successful');
        emit(SaveUserDataSuccessState());
    }).catchError((error){

      debugPrint('Error in save userData is ${error.toString()}');
      emit(SaveUserDataErrorState());

    });

  }


  UserModel ?userModel;

  void getUser(){

    emit(GetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(CashHelper.getData(key: 'uId'))
        .get().then((value) {
          userModel=UserModel.fromFire(value.data()!);
          debugPrint('Get User Data Successful');
          emit(GetUserSuccessState());
    }).catchError((error){
      debugPrint('Error in get userData is ${error.toString()}');
      emit(GetUserErrorState());

    });

  }



  // upload product image

  File? productImage;

  ImageProvider product = const AssetImage('assets/images/recycle1.png');

  var picker = ImagePicker();

  Future<void> getProductImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      productImage = File(pickedFile.path);
      product = FileImage(productImage!);
      debugPrint('Path is ${pickedFile.path}');
      emit(PickProductImageSuccessState());
    } else {
      debugPrint('No Image selected.');
      emit(PickProductImageErrorState());
    }

  }

  String ?productPath;

  Future uploadProductImage({
    required String productName,
    required String productPrice,
    required String productDescription,
    required String productCategory,
  }){

    emit(UploadProductImageLoadingState());
    return firebase_storage.FirebaseStorage.instance.ref()
        .child('productImages/${Uri.file(productImage!.path).pathSegments.last}')
        .putFile(productImage!).then((value) {

      value.ref.getDownloadURL().then((value) {

        debugPrint('Upload Success');
        productPath = value;

        uploadProduct(
            productName: productName,
            productPrice: productPrice,
            productDescription: productDescription,
            productCategory: productCategory,
            productImage: productPath!
        );

        emit(UploadProductImageSuccessState());

      }).catchError((error){

        debugPrint('Error in Upload profileImage ${error.toString()}');
        emit(UploadProductImageErrorState());

      });

    }).catchError((error){

      debugPrint('Error in Upload profileImage ${error.toString()}');
      emit(UploadProductImageErrorState());
    });
  }

  void uploadProduct({

    required String productName,
    required String productPrice,
    required String productDescription,
    required String productCategory,
    required String productImage,

  }){

    emit(AddProductLoadingStates());

    ProductModel productModel =ProductModel(
        productName: productName,
        productPrice: productPrice,
        productImage: productImage,
        productDescribtion: productDescription,
        productCategory: productCategory,
        productVerified: false
    );

    FirebaseFirestore.instance
        .collection('Products')
        .add(productModel.toMap())
        .then((value) {


      debugPrint('Add Product Success');
      emit(AddProductSuccessStates());

    }).catchError((error){

      debugPrint('Error in Add Product is:${error.toString()}');
      emit(AddProductErrorStates());

    });

  }

  List <ProductModel> allProducts=[];

  void getProducts(){

    emit(GetProductsLoadingState());

    FirebaseFirestore.instance
        .collection('Products')
        .get()
        .then((value) {

          for (var element in value.docs) {

            debugPrint(element['productCategory']);

            if(element['productVerified']==true){

              if(element['productCategory']=='Medical Clinic'){
                medicalClinicProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Dentists'){
                dentistsProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Beauty Salon'){
                beautySalonProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Laser'){
                laserProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Nutrition\'s'){
                nurseProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Athletic coaching'){
                athleticCoachingProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Healthcare '){
                healthcareProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Educational training, courses'){
                educationalTrainingProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Car services '){
                carServicesProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Home appliances and products installments'){
                homeAppliancesProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Financing and loans'){
                financingProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Online, offline teacher\'s '){
                onlineProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Travel agencies '){
                travelProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Residential & commercial properties '){
                residentialProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Clubs Events '){
                clubsEventsProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Wedding organizers, parties birth days'){
                weddingProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Dry Cleaning, Laundries, carpet, blankets'){
                dryCleaningProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Maid Service providers'){
                maidServiceProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Pet Grooming'){
                petGroomingProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Home Repair and Maintenance service provider\'s'){
                homeRepairProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Air conditioning Repair'){
                applianceProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Gas cylinder provider\'s '){
                gasCylinderProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Landscaping & Gardens care  '){
                landscapingProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Nurse, senior age care giver  '){
                nurseProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='New & Used equipment Rent'){
                newProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='New restaurants, Coffee shops, meals, drinks '){
                newRestaurantsProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Cleaning Services '){
                newProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Plumbing Services '){
                plumbingServicesProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Electrical Services '){
                electricalServicesProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Pest Control Services '){
                pestControlServicesProducts.add(ProductModel.fromFire(element.data()!));
              }
              else if(element['productCategory']=='Home Security Services video surveillance'){
                homeSecurityProducts.add(ProductModel.fromFire(element.data()!));
              }
              else{
                paintingServicesProducts.add(ProductModel.fromFire(element.data()!));
              }



            }

          }


      debugPrint('Get Product Success');
      emit(GetProductsSuccessState());

    }).catchError((error){

      debugPrint('Error in Get Product is:${error.toString()}');
      emit(GetProductsErrorState());

    });

  }



}