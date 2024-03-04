import 'package:uuid/uuid.dart';
import '../core/endpoints.dart';

List<String> generateAvatarUrl() {
  final randString = const Uuid().v4();
  final urls =
      List.generate(8, (_) => "${Endpoints.avatarEndpoint}$randString");
  return urls;
}