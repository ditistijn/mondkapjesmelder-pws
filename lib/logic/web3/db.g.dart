// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
import 'package:web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
    '[{"constant":true,"inputs":[],"name":"checkIfUserAdmin","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"_studentId","type":"uint256"}],"name":"getStudentInfo","outputs":[{"name":"firstName","type":"string"},{"name":"lastName","type":"string"},{"name":"classId","type":"string"},{"name":"timesReported","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"_studentId","type":"uint256"}],"name":"getReports","outputs":[{"name":"","type":"string[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_address","type":"address"}],"name":"setAdmin","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_studentId","type":"uint256"},{"name":"_dateTime","type":"string"}],"name":"reportStudent","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_studentId","type":"uint256"},{"name":"_firstName","type":"string"},{"name":"_lastName","type":"string"},{"name":"_classId","type":"string"}],"name":"addStudent","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"getStudents","outputs":[{"name":"","type":"string[]"}],"payable":false,"stateMutability":"view","type":"function"}]',
    'Db');

class Db extends _i1.GeneratedContract {
  Db(
      {required _i1.EthereumAddress address,
      required _i1.Web3Client client,
      int? chainId})
      : super(_i1.DeployedContract(_contractAbi, address), client, chainId);

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> checkIfUserAdmin({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[0];
    assert(checkSignature(function, '1dadad31'));
    final params = [];
    final response = await read(function, params, atBlock);
    return (response[0] as bool);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<GetStudentInfo> getStudentInfo(BigInt _studentId,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, '65a81d7d'));
    final params = [_studentId];
    final response = await read(function, params, atBlock);
    return GetStudentInfo(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<String>> getReports(BigInt _studentId,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '6ccdb778'));
    final params = [_studentId];
    final response = await read(function, params, atBlock);
    return (response[0] as List<dynamic>).cast<String>();
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> setAdmin(_i1.EthereumAddress _address,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, '704b6c02'));
    final params = [_address];
    return write(credentials, transaction, function, params);
  }

  Future<String> getUserAdmin(_i1.EthereumAddress _address,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, '704b6c02'));
    final params = [_address];
    return write(credentials, transaction, function, params);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> reportStudent(BigInt _studentId, String _dateTime,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, '7f681139'));
    final params = [_studentId, _dateTime];
    return write(credentials, transaction, function, params);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> addStudent(
      BigInt _studentId, String _firstName, String _lastName, String _classId,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, 'e498b84e'));
    final params = [_studentId, _firstName, _lastName, _classId];
    return write(credentials, transaction, function, params);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<String>> getStudents({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[6];
    assert(checkSignature(function, 'f1d064b3'));
    final params = [];
    final response = await read(function, params, atBlock);
    return (response[0] as List<dynamic>).cast<String>();
  }
}

class GetStudentInfo {
  GetStudentInfo(List<dynamic> response)
      : firstName = (response[0] as String),
        lastName = (response[1] as String),
        classId = (response[2] as String),
        timesReported = (response[3] as BigInt);

  final String firstName;

  final String lastName;

  final String classId;

  final BigInt timesReported;
}
