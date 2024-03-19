abstract class ImagePaths {
  static const _base = "assets/images";
  static const logo = "$_base/logo.png";
  static const google = "$_base/google.svg";

  static String quizCategoryGen(String? name) => "$_base/$name.png";
}
