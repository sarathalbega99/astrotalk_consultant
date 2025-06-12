import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppHiveUtils {
  // initialize
  static initializeHive() async => await Hive.initFlutter();

// generate secure key and read write using hive & secureStorage
  static getSecureKeyForHiveBox() async {
    // init storage
    const secureStorage = FlutterSecureStorage();
    // assign secureKey from Env to variable
    final encryptionKeyString = await secureStorage.read(
        key: const String.fromEnvironment('hiveSecureKey'));
    //  null validate KeyString then generate key & write
    if (encryptionKeyString == null) {
      // generate key from hive
      final hiveGeneratedKey = Hive.generateSecureKey();
      // write data on secureStorage with base64 encoded along with hive generated key
      await secureStorage.write(
          key: const String.fromEnvironment('hiveSecureKey'),
          value: base64Encode(hiveGeneratedKey));
    }
    //  not null then
    final encryptionKey = await secureStorage.read(
        key: const String.fromEnvironment('hiveSecureKey'));
    //   decode key
    final encryptionKeyUnit8List = base64Decode(encryptionKey!);
    //   return key
    return encryptionKeyUnit8List;
  }

  // whenever create new box call this function
  static Future createSecureHiveBox({String? boxName}) async =>
      await Hive.openBox(boxName!,
          encryptionCipher:
              HiveAesCipher(await AppHiveUtils.getSecureKeyForHiveBox()));

  // remove boxes
  // add all the box to remove bulk
  static Future deleteAllHiveBox() async {
    await AppHiveBox.appBox!.clear();
  }

  // remove single box
  static Future deleteHiveBox(Box? appHiveBoxName) async =>
      await appHiveBoxName!.clear();
}

//hive box names
class AppHiveBoxNames {
  static String? hIVEaPPbOX = 'hIVEaPPbOX';
}

// hive box
class AppHiveBox {
  static Box? appBox;
}

// hive key
class AppHiveKeys {
  static String accessTokenKey = 'aCCESStOKEN';
}