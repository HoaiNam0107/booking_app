import 'package:injectable/injectable.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    // TODO: thay bằng connectivity_plus nếu cần check thật
    // final result = await connectivity.checkConnectivity();
    // return result != ConnectivityResult.none;
    return true;
  }
}