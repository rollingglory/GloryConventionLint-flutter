extension LintStringExt on String {
  String get fileName => split('/').last;

  bool isFileAllowedToBeObserved() {
    final regExp = RegExp('.*(/lib/app/data/|/lib/data/|/lib/resources/).*');
    return regExp.hasMatch(this);
  }

  bool isFileAllowedToBeObservedSrcPattern() {
    final regExp = RegExp('.*(/src/app/data/|/src/data/|/src/resources/).*');
    return regExp.hasMatch(this);
  }

  bool isPathModel() {
    final regExp = RegExp('.*(/network/models/|/network/model/).*');
    return regExp.hasMatch(this);
  }

  bool isPathServices() {
    final regExp = RegExp('.*(/network/services/|/network/service/).*');
    return regExp.hasMatch(this);
  }

  bool isPathEnum() {
    final regExp = RegExp('.*(/enums/|/enum/).*');
    return regExp.hasMatch(this);
  }

  bool isPathResponse() {
    final regExp = RegExp('.*(/responses/|/response/).*');
    return regExp.hasMatch(this);
  }

  bool isPathRequest() {
    final regExp = RegExp('.*(/requests/|/request/).*');
    return regExp.hasMatch(this);
  }

  bool isPathResourceConstant() {
    final regExp = RegExp('.*(/resources/constants/|/resources/constant/).*');
    return regExp.hasMatch(this);
  }

  bool isPathLang() {
    final regExp = RegExp('.*(languages/en/|languages/id/).*');
    return regExp.hasMatch(this);
  }

  bool isPathRGBCodeBase() {
    final regExp = RegExp('.*gloryconventionlintplayground/json_api/*');
    return regExp.hasMatch(this);
  }

  bool isCorrectModelClassName() {
    final regExp = RegExp(r'.*(Services|Response|Request|Constant|Enum)$');
    return !regExp.hasMatch(this);
  }

  bool isCorrectFileModelName() {
    final regExp = RegExp(r'_model.dart$');
    return regExp.hasMatch(this);
  }

  bool isCorrectClassServiceName() {
    final regExp = RegExp('.*Services.*');
    return regExp.hasMatch(this);
  }

  bool isCorrectFileServiceName() {
    final regExp = RegExp(r'_services.dart$');
    return regExp.hasMatch(this);
  }

  bool isCorrectClassResponseName() {
    final regExp = RegExp('.*Response.*');
    return regExp.hasMatch(this);
  }

  bool isCorrectFileResponseName() {
    final regExp = RegExp(r'_response.dart$');
    return regExp.hasMatch(this);
  }

  bool isCorrectClassRequestName() {
    final regExp = RegExp('.*Request.*');
    return regExp.hasMatch(this);
  }

  bool isCorrectFileRequestName() {
    final regExp = RegExp(r'_request.dart$');
    return regExp.hasMatch(this);
  }

  bool isCorrectClassEnumName() {
    final regExp = RegExp(r".*Enum.*");
    return regExp.hasMatch(this);
  }

  bool isCorrectFileEnumName() {
    final regExp = RegExp(r'_enum.dart$');
    return regExp.hasMatch(this);
  }

  bool isCorrectClassConstantName() {
    final regExp = RegExp('.*Constants.*');
    return regExp.hasMatch(this);
  }

  bool isCorrectFileConstantName() {
    final regExp = RegExp(r'_constant.dart$');
    return regExp.hasMatch(this);
  }

  bool isCorrectFileLang() {
    final regExp = RegExp(r'_lang.dart$');
    return regExp.hasMatch(this);
  }

  bool isCorrectVariableNullable() {
    final regExp = RegExp(r'.*\?.*');
    return regExp.hasMatch(this);
  }

  bool isCorrectFileBaseResponse() {
    final regExp = RegExp('.*base_response.dart.*');
    return regExp.hasMatch(this);
  }

  bool isCorrectUsingBaseResponse() {
    final regExp = RegExp('.*BaseResponse|BaseListResponse.*');
    return regExp.hasMatch(this);
  }

  String renameClass({required String type}) {
    final rawClassName = this.rawClassName;
    final newClassName = rawClassName + type;
    return newClassName;
  }

  String get rawClassName {
    final words = split(RegExp('(?=[A-Z])'));
    // ignore: cascade_invocations
    words.removeWhere((w) {
      if (w == 'Service' || w == 'Services') {
        return true;
      }
      if (w == 'Enum' || w == 'Enums') {
        return true;
      }
      if (w == 'Constant' || w == 'Constants') {
        return true;
      }
      if (w == 'Response') {
        return true;
      }
      if (w == 'Request') {
        return true;
      }
      return false;
    });
    final rawClassName = words.join();
    return rawClassName;
  }

  bool isLowerCamelCase() {
    final camelCaseTester = RegExp(r'^[a-z]+(?:[A-Z][a-z]*)*$');
    return camelCaseTester.hasMatch(this);
  }

  bool isUpperCamelCase() {
    final camelCaseTester = RegExp(r'^_*(?:\$+_+)*[$?A-Z][$?a-zA-Z\d]*$');
    return camelCaseTester.hasMatch(this);
  }


}
