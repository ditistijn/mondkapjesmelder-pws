import 'dart:io';

import 'package:http/http.dart';
import 'package:mondkapjesmelder/logic/web3/db.g.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
import 'package:web3dart/web3dart.dart';
import 'package:path/path.dart' show join, dirname;

var apiUrl = "http://rpc.mtv.ac/";

var httpClient = Client();
var ethClient = Web3Client(apiUrl, httpClient);

var credentials = EthPrivateKey.fromHex("");

Future<String> getCredentials() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getString('privKey') != "" && prefs.getString('privKey')!.isNotEmpty) {
    return 'Yes';
  } else {
    return 'None';
  }
}

final File abiFile = File(join(dirname(Platform.script.path), '/logic/web3/db.abi.json'));

final EthereumAddress dbAddress = EthereumAddress.fromHex('0xB966EE7363f1d273134E9c5F5681B8d8B8459569');

final dbInstance = Db(address: dbAddress, client: ethClient, chainId: 62621);