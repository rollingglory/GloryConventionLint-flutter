extension LintStringExt on String {
  String get fileName {
    return split("/").last;
  }

  bool isFileAllowedToBeObserved() {
    RegExp regExp = RegExp(r'.*(/lib/app/data/|/lib/data/|/lib/resources/).*');
    return regExp.hasMatch(this);
  }

  bool isFileAllowedToBeObservedSrcPattern() {
    RegExp regExp = RegExp(r'.*(/src/app/data/|/src/data/|/src/resources/).*');
    return regExp.hasMatch(this);
  }

  bool isPathModel() {
    RegExp regExp = RegExp(r'.*(/network/models/|/network/model/).*');
    return regExp.hasMatch(this);
  }

  bool isPathServices() {
    RegExp regExp = RegExp(r'.*(/network/services/|/network/service/).*');
    return regExp.hasMatch(this);
  }

  bool isPathEnum() {
    RegExp regExp = RegExp(r'.*(/enums/|/enum/).*');
    return regExp.hasMatch(this);
  }

  bool isPathResponse() {
    RegExp regExp = RegExp(r'.*(/responses/|/response/).*');
    return regExp.hasMatch(this);
  }

  bool isPathRequest() {
    RegExp regExp = RegExp(r'.*(/requests/|/request/).*');
    return regExp.hasMatch(this);
  }

  bool isPathResourceConstant() {
    RegExp regExp = RegExp(r'.*(/resources/constants/|/resources/constant/).*');
    return regExp.hasMatch(this);
  }

  bool isPathLang() {
    RegExp regExp = RegExp(r'.*(languages/en/|languages/id/).*');
    return regExp.hasMatch(this);
  }

  bool isPathRGBCodeBase() {
    RegExp regExp = RegExp(r'.*gloryconventionlintplayground/json_api/*');
    return regExp.hasMatch(this);
  }

  bool isCorrectModelClassName() {
    RegExp regExp = RegExp(r".*(Services|Response|Request|Constant|Enum)$");
    return !regExp.hasMatch(this);
  }

  bool isCorrectFileModelName() {
    RegExp regExp = RegExp(r"_model.dart$");
    return regExp.hasMatch(this);
  }

  bool isCorrectClassServiceName() {
    RegExp regExp = RegExp(r".*Services.*");
    return regExp.hasMatch(this);
  }

  bool isCorrectFileServiceName() {
    RegExp regExp = RegExp(r"_services.dart$");
    return regExp.hasMatch(this);
  }

  bool isCorrectClassResponseName() {
    RegExp regExp = RegExp(r".*Response.*");
    return regExp.hasMatch(this);
  }

  bool isCorrectFileResponseName() {
    RegExp regExp = RegExp(r"_response.dart$");
    return regExp.hasMatch(this);
  }

  bool isCorrectClassRequestName() {
    RegExp regExp = RegExp(r".*Request.*");
    return regExp.hasMatch(this);
  }

  bool isCorrectFileRequestName() {
    RegExp regExp = RegExp(r"_request.dart$");
    return regExp.hasMatch(this);
  }

  bool isCorrectClassEnumName() {
    RegExp regExp = RegExp(r".*Enum.*");
    return regExp.hasMatch(this);
  }

  bool isCorrectFileEnumName() {
    RegExp regExp = RegExp(r"_enum.dart$");
    return regExp.hasMatch(this);
  }

  bool isCorrectClassConstantName() {
    RegExp regExp = RegExp(r".*Constants.*");
    return regExp.hasMatch(this);
  }

  bool isCorrectFileConstantName() {
    RegExp regExp = RegExp(r"_constant.dart$");
    return regExp.hasMatch(this);
  }

  bool isCorrectFileLang() {
    RegExp regExp = RegExp(r"_lang.dart$");
    return regExp.hasMatch(this);
  }

  bool isCorrectVariableNullable() {
    RegExp regExp = RegExp(r'.*\?.*');
    return regExp.hasMatch(this);
  }

  bool isCorrectFileBaseResponse() {
    RegExp regExp = RegExp(r".*base_response.dart.*");
    return regExp.hasMatch(this);
  }

  bool isCorrectUsingBaseResponse() {
    RegExp regExp = RegExp(r".*BaseResponse|BaseListResponse.*");
    return regExp.hasMatch(this);
  }

  String renameClass({required String type}) {
    String rawClassName = this.rawClassName;
    String newClassName = rawClassName + type;
    return newClassName;
  }

  String get rawClassName {
    List<String> words = split(RegExp(r'(?=[A-Z])'));
    words.removeWhere((w) {
      if (w == "Service" || w == "Services") return true;
      if (w == "Enum" || w == "Enums") return true;
      if (w == "Constant" || w == "Constants") return true;
      if (w == "Response") return true;
      if (w == "Request") return true;
      return false;
    });
    String rawClassName = words.join();
    return rawClassName;
  }

  bool isLowerCamelCase() {
    final _camelCaseTester = RegExp(r'^[a-z]+(?:[A-Z][a-z]*)*$');
    return _camelCaseTester.hasMatch(this);
  }

  bool isUpperCamelCase() {
    final _camelCaseTester = RegExp(r'^_*(?:\$+_+)*[$?A-Z][$?a-zA-Z\d]*$');
    return _camelCaseTester.hasMatch(this);
  }


}
