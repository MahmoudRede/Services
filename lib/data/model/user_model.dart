class UserModel {
  String? name;
  String? phoneNumber;
  String? email;
  String? countryCode;
  // String? image;
  String? uId ;


  UserModel ({
    required this.name ,
    // required this.image,
    required this.phoneNumber,
    required this.email,
    required this.uId ,
    required this.countryCode ,
  });

  UserModel.fromFire(Map <String , dynamic> fire){
    name = fire['name'];
    // image = fire['image'];
    phoneNumber = fire['phoneNumber'];
    email = fire['email'];
    uId = fire['uId'];
    countryCode = fire['countryCode'];

  }

  Map <String , dynamic> toMap ()
  {
    return{
      'name' : name,
      // 'image' : image,
      'phoneNumber' : phoneNumber,
      'email' : email,
      'uId' : uId,
      'countryCode' : countryCode,
    };
  }

}