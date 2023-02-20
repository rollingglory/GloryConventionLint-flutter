import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:glory_convention_lint/helper/string_extention.dart';

class PreferNullableModel extends DartLintRule {
  PreferNullableModel() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_nullable_model',
    problemMessage: '⚠️Implement nullable attributes for models',
    correctionMessage: 'add nullable <ex:String?> to models\'s attributes',
      errorSeverity: ErrorSeverity.WARNING

  );

  @override
  void run(
      CustomLintResolver resolver,
      ErrorReporter reporter,
      CustomLintContext context,
      ) {
    context.registry.addCompilationUnit((node) {
      var declaredElement = node.declaredElement;
      if (declaredElement != null) {
        var path = declaredElement.source.uri.path;
        if (path.isCorrectFileModelName() && path.isPathModel()) {
          for (var element in declaredElement.classes) {
            for (var field in element.fields) {
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