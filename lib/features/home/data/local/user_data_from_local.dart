import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/features/home/data/remot/model/user_data_request.dart';

class UserDataFromLocal {
  static final UserDataFromLocal _instance = UserDataFromLocal._internal();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  UserDataFromLocal._internal();

  factory UserDataFromLocal() {
    return _instance;
  }

  static const String _keySId = 'sId';
  static const String _keyUsername = 'username';
  static const String _keyPhone = 'phone';
  static const String _keyEmail = 'email';
  static const String _keyGender = 'gender';
  static const String _keyImage = 'image';
  static const String _keyCity = 'city';
  static const String _keyState = 'state';
  static const String _keyBirthDay = 'birthDay';
  static const String _keyPlants = 'plants';

  UserDataFromLocal.fromResponse(UserDataResponse user) {
    _setData(_keySId, user.userData.sId);
    _setData(_keyUsername, user.userData.username);
    _setData(_keyPhone, user.userData.phone);
    _setData(_keyEmail, user.userData.email);
    _setData(_keyGender, user.userData.gender);
    _setData(_keyImage, user.userData.image);
    _setData(_keyCity, user.userData.city);
    _setData(_keyState, user.userData.state);
    _setData(_keyBirthDay, user.userData.birthDay);
    if (user.userData.plants != null) {
      _setData(_keyPlants, user.userData.plants!.join(','));
    }
  }

  Future<void> _setData(String key, String? value) async {
    if (value != null) {
      await _storage.write(key: key, value: value);
    }
  }

  Future<String?> _getData(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> _deleteData(String key) async => await _storage.delete(key: key);

  Future<String> getSId() async => await _getData(_keySId) ?? 'لا يوجد معرف';

  Future<void> deleteSId() async => await _deleteData(_keySId);

  Future<String> getUsername() async => await _getData(_keyUsername) ?? 'مستخدم';

  Future<void> deleteUsername() async => await _deleteData(_keyUsername);

  Future<String> getPhone() async => await _getData(_keyPhone) ?? 'غير متوفر';

  Future<void> deletePhone() async => await _deleteData(_keyPhone);

  Future<String> getEmail() async => await _getData(_keyEmail) ?? 'غير متوفر';

  Future<void> deleteEmail() async => await _deleteData(_keyEmail);

  Future<String> getGender() async => await _getData(_keyGender) ?? 'غير محدد';

  Future<void> deleteGender() async => await _deleteData(_keyGender);

  Future<String> getImage() async => await _getData(_keyImage) ?? 'assets/SVGs/home/profile_avatar.jpg';

  Future<void> deleteImage() async => await _deleteData(_keyImage);

  Future<String> getCity() async => await _getData(_keyCity) ?? 'غير معروف';

  Future<void> deleteCity() async => await _deleteData(_keyCity);

  Future<String> getState() async => await _getData(_keyState) ?? 'غير محدد';

  Future<void> deleteState() async => await _deleteData(_keyState);

  Future<String> getBirthDay() async => await _getData(_keyBirthDay) ?? 'غير معلوم';

  Future<void> deleteBirthDay() async => await _deleteData(_keyBirthDay);

  Future<List<String>> getPlants() async {
    final String? data = await _getData(_keyPlants);
    return data?.split(',') ?? ['لا توجد نباتات'];
  }

  Future<void> deletePlants() async => await _deleteData(_keyPlants);

  Future<void> clearAll() async => await _storage.deleteAll();
}
