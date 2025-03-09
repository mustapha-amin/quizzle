import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'DEEPSEEK_KEY', obfuscate: true)
  static final String deepseekApiKey = _Env.deepseekApiKey;
}