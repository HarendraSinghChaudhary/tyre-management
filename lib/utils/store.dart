import 'package:PrimeMetrics/models/user_info.dart';
import 'package:PrimeMetrics/utils/constants.dart';
import 'package:get_storage/get_storage.dart';

setUser(UserInfo? userInfo) async {
  print(userInfo?.data.toString());
  final store = GetStorage();
  await store.write(userinfo, userInfo);
}

UserInfo? getUserInfo() {
  final store = GetStorage();
  if (store.read(userinfo) is Map) {
   return  UserInfo.fromJson(store.read(userinfo));
  }
 return  store.read<UserInfo?>(userinfo);
}

setEmail(String email) async {
  final store = GetStorage();
  await store.write('email', email);
}

getEmail() {
  final store = GetStorage();
 return  store.read<String?>("email");
}

setPassword(String email) async {
  final store = GetStorage();
  await store.write('password', email);
}

getPassword() {
  final store = GetStorage();
  return store.read<String?>("password");
}

setSecret(String email) async {
  final store = GetStorage();
  await store.write('secret', email);
}

getSecret() {
  final store = GetStorage();
  return store.read<String?>("secret");
}
