import 'package:uuid/uuid.dart';
import '../core/endpoints.dart';

List<String> generateAvatarUrl() {
  final urls =
      List.generate(8, (_) => "${Endpoints.avatarEndpoint}${const Uuid().v4()}");
  return urls;
}