import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:glory_convention_lint/helper/lint_type_constant.dart';
import 'package:glory_convention_lint/helper/string_extention.dart';

import '../helper/documentation_constants.dart';

class NetworkModelClassNameConvention extends DartLintRule {
  NetworkModelClassNameConvention() : super(code: _code);

  static const _code = LintCode(
    name: 'network_model_class_name_convention',
    problemMessage: "⚠️The class name incorrect name for model class. "
        "Model class should only contains their name without prefixes. Example: Gift, User",
    correctionMessage: "${DocumentationConstants.modelClassNameConvention}",
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
        var fileName = declaredElement.source.uri.path;
        var classes = declaredElement.classes;

        for (var classInstance in classes) {
          var offset = classInstance.nameOffset;
          var length = classInstance.nameLength;
          var name = classInstance.name;

          if (fileName.isPathModel()) {
            if (!name.isCorrectModelClassName()) {
              reporter.reportErrorForOffset(code, offset, length);
            }
          }
        }
      }
    });
  }

  @override
  List<Fix> getFixes() => [_RenameModelClass()];
}

class _RenameModelClass extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    context.registry.addCompilationUnit((node) {
      var declaredElement = node.declaredElement;
      var classes = declaredElement?.classes;

      if (classes == null || classes.isEmpty) return;
      var className = classes.first.name;
      String correctName = className.rawClassName;

      var offset = classes.first.nameOffset;
      var length = classes.first.nameLength;

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Change to $correctName',
        priority: 1,
      );
      changeBuilder.addDartFileEdit((builder) {
        builder.addSimpleReplacement(
          SourceRange(offset, length),
          correctName,
        );
      });
    });
  }
}
