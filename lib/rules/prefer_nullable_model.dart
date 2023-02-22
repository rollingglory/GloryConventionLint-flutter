import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import '../helper/documentation_constants.dart';
import '../helper/string_extention.dart';

class PreferNullableModel extends DartLintRule {
  const PreferNullableModel() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_nullable_model',
    problemMessage: '⚠️Implement nullable attributes for models',
    correctionMessage: "add nullable <ex:String?> to models's attributes,"
        "\n\n${DocumentationConstants.preferNullableForModels}",
      errorSeverity: ErrorSeverity.WARNING

  );

  @override
  void run(
      CustomLintResolver resolver,
      ErrorReporter reporter,
      CustomLintContext context,
      ) {
    context.registry.addCompilationUnit((node) {
      final declaredElement = node.declaredElement;
      if (declaredElement != null) {
        final path = declaredElement.source.uri.path;
        if (path.isCorrectFileModelName() && path.isPathModel()) {
          for (final element in declaredElement.classes) {
            for (final field in element.fields) {
              if (!field.toString().isCorrectVariableNullable()) {
                reporter.reportErrorForOffset(code, field.nameOffset, field.nameLength);
              }
            }
          }
        }
      }
    });
  }
}