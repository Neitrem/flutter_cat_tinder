import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Interface for AppEnv. This will help us test our code. 
interface class IAppEnv {
  String catApiKey;
  IAppEnv(this.catApiKey);
}

class AppEnv implements IAppEnv {
  @override
  String catApiKey = dotenv.get('CAT_API_KEY');
}

final appEnv = AppEnv();