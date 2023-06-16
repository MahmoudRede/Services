abstract class ServicesStates{}

class InitialState extends ServicesStates{}

class UserLoginLoadingState extends ServicesStates{}
class UserLoginSuccessState extends ServicesStates{
  String uId;
  UserLoginSuccessState(this.uId);

}
class UserLoginErrorState extends ServicesStates{}

class UserRegisterLoadingState extends ServicesStates{}
class UserRegisterSuccessState extends ServicesStates{}
class UserRegisterErrorState extends ServicesStates{}

class SaveUserDataLoadingState extends ServicesStates{}
class SaveUserDataSuccessState extends ServicesStates{}
class SaveUserDataErrorState extends ServicesStates{}

class GetUserLoadingState extends ServicesStates{}
class GetUserSuccessState extends ServicesStates{}
class GetUserErrorState extends ServicesStates{}

class PickProductImageSuccessState extends ServicesStates{}
class PickProductImageErrorState extends ServicesStates{}

class AddProductLoadingStates extends ServicesStates{}
class AddProductSuccessStates extends ServicesStates{}
class AddProductErrorStates extends ServicesStates{}

class UploadProductImageLoadingState extends ServicesStates{}
class UploadProductImageSuccessState extends ServicesStates{}
class UploadProductImageErrorState extends ServicesStates{}

class GetProductsLoadingState extends ServicesStates{}
class GetProductsSuccessState extends ServicesStates{}
class GetProductsErrorState extends ServicesStates{}