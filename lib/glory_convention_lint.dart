library glory_convention_lint;

import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'rules/correct_base_response_import_convention.dart';
import 'rules/correct_one_variable_for_lang_convention.dart';
import 'rules/enum_file_name_convention.dart';
import 'rules/enum_name_convention.dart';
import 'rules/network_model_annotation_convention.dart';
import 'rules/network_model_class_name_convention.dart';
import 'rules/network_model_file_name_convention.dart';
import 'rules/network_model_json_implementation_convention.dart';
import 'rules/network_request_class_name_convention.dart';
import 'rules/network_request_file_name_convention.dart';
import 'rules/network_response_class_name_convention.dart';
import 'rules/network_response_file_name_convention.dart';
import 'rules/network_service_annotation_convention.dart';
import 'rules/network_service_class_name_convention.dart';
import 'rules/network_service_file_name_convention.dart';
import 'rules/prefer_nullable_model.dart';
import 'rules/prefer_single_class_per_file.dart';
import 'rules/prefer_single_enum_per_file.dart';
import 'rules/prefer_static_const_lang_variable.dart';
import 'rules/prefer_upper_camel_case.dart';

PluginBase createPlugin() => _RgbCustomLint();

class _RgbCustomLint extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
    const NetworkModelFileNameConvention(),
    const NetworkModelAnnotationConvention(),
    const NetworkModelClassNameConvention(),
    const NetworkModelJsonImplementationConvention(),
    const PreferNullableModel(),

    const  NetworkServiceAnnotationConvention(),
    const NetworkServiceClassNameConvention(),
    const NetworkServiceFileNameConvention(),

    const NetworkResponseClassNameConvention(),
    const NetworkResponseFileNameConvention(),

    const NetworkRequestClassNameConvention(),
    const NetworkRequestFileNameConvention(),

    const EnumFileNameConvention(),
    const EnumNameConvention(),

    const CorrectBaseResponseImportConvention(),
    const CorrectOneVariableForLangConvention(),

    const PreferUpperCamelCase(),
    const PreferStaticConstLangVariable(),
    const PreferSingleClassPerFile(),
    const PreferSingleEnumPerFile(),
  ];
}