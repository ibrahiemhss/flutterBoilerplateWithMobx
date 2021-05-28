import 'package:flutterBoilerplateWithMobx/constants/general_constants.dart';

class UserModel {
  final String? key;
  final bool? error;
  final String? errorMessage;
  dynamic? acceptableNominations;
  dynamic nominationsCount;
  dynamic logedIn;
  dynamic id;
  dynamic birthday;
  dynamic email;
  dynamic userTypeId;
  dynamic displayName;
  dynamic name;
  dynamic address;
  dynamic password;
  dynamic lastLoginTime;
  dynamic registrationTime;
  dynamic phone;
  dynamic job;
  dynamic token;

  UserModel(
      {this.key,
      this.error,
      this.address,
      this.acceptableNominations,
      this.nominationsCount,
      this.errorMessage,
      this.logedIn,
      this.id,
      this.email,
      this.birthday,
      this.userTypeId,
      this.displayName,
      this.name,
      this.lastLoginTime,
      this.registrationTime,
      this.password,
      this.phone,
      this.job,
      this.token});

  factory UserModel.fromJson({key, required Map<dynamic, dynamic> map}) {
    return new UserModel(
      key: key,
      id: map[GeneralConstants.id],
      logedIn: map[GeneralConstants.logedIn],
      acceptableNominations: map[GeneralConstants.acceptableNominations],
      nominationsCount: map[GeneralConstants.nominationsCount],
      userTypeId: map[GeneralConstants.userTypeId],
      token: map[GeneralConstants.token],
      address: map[GeneralConstants.address],
      birthday: map[GeneralConstants.birthday],
      email: map[GeneralConstants.email],
      lastLoginTime: map[GeneralConstants.lastLoginTime],
      registrationTime: map[GeneralConstants.registrationTime],
      displayName: map[GeneralConstants.displayName],
      name: map[GeneralConstants.name],
      password: map[GeneralConstants.password],
      phone: map[GeneralConstants.phone],
      job: map[GeneralConstants.job],
    );
  }

  factory UserModel.fromMap(Map<dynamic, dynamic> map) => UserModel(
        id: map[GeneralConstants.id] ?? "",
        token: map[GeneralConstants.token] ?? "",
        userTypeId: map[GeneralConstants.userTypeId] ?? "",
        logedIn: map[GeneralConstants.logedIn] ?? "",
        address: map[GeneralConstants.address] ?? "",
        email: map[GeneralConstants.email] ?? "",
        acceptableNominations:
            map[GeneralConstants.acceptableNominations] ?? "",
        nominationsCount: map[GeneralConstants.nominationsCount] ?? "",
        birthday: map[GeneralConstants.birthday] ?? "",
        lastLoginTime: map[GeneralConstants.lastLoginTime] ?? "",
        registrationTime: map[GeneralConstants.registrationTime] ?? "",
        displayName: map[GeneralConstants.displayName] ?? "",
        name: map[GeneralConstants.name] ?? "",
        password: map[GeneralConstants.password] ?? "",
        phone: map[GeneralConstants.phone] ?? "",
        job: map[GeneralConstants.job] ?? "",
      );

  Map<dynamic, dynamic> toJson() => <String, dynamic>{
        GeneralConstants.id: id,
        GeneralConstants.token: token,
        GeneralConstants.logedIn: logedIn,
        GeneralConstants.userTypeId: userTypeId,
        GeneralConstants.email: email,
        GeneralConstants.address: address,
        GeneralConstants.acceptableNominations: acceptableNominations,
        GeneralConstants.nominationsCount: nominationsCount,
        GeneralConstants.name: name,
        GeneralConstants.birthday: birthday,
        GeneralConstants.lastLoginTime: lastLoginTime,
        GeneralConstants.lastLoginTime: registrationTime,
        GeneralConstants.displayName: displayName,
        GeneralConstants.phone: phone,
        GeneralConstants.password: password,
        GeneralConstants.job: job,
      };

  Map<dynamic, dynamic> toMap() => {
        GeneralConstants.id: id,
        GeneralConstants.token: token,
        GeneralConstants.logedIn: logedIn,
        GeneralConstants.userTypeId: userTypeId,
        GeneralConstants.email: email,
        GeneralConstants.address: address,
        GeneralConstants.acceptableNominations: acceptableNominations,
        GeneralConstants.nominationsCount: nominationsCount,
        GeneralConstants.birthday: birthday,
        GeneralConstants.name: name,
        GeneralConstants.lastLoginTime: lastLoginTime,
        GeneralConstants.lastLoginTime: registrationTime,
        GeneralConstants.displayName: displayName,
        GeneralConstants.phone: phone,
        GeneralConstants.password: password,
        GeneralConstants.job: job,
      };
}
