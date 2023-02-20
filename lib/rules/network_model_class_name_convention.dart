import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../helper/documentation_constants.dart';
import '../helper/string_extention.dart';

class NetworkModelClassNameConvention extends DartLintRule {
  const NetworkModelClassNameConvention() : super(code: _code);

  static const _code = LintCode(
    name: 'network_model_class_name_convention',
    problemMessage: '⚠️The class name incorrect name for model class. '
        'Model class should only contains their name without prefixes. Example: Gift, User',
    correctionMessage: DocumentationConstants.modelClassNameConvention,
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
        final fileName = declaredElement.source.uri.path;
        final classes = declaredElement.classes;

        for (final classInstance in classes) {
          final offset = classInstance.nameOffset;
          final length = classInstance.nameLength;
          final name = classInstance.name;

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
      final declaredElement = node.declaredElement;
      final classes = declaredElement?.classes;

      if (classes == null || classes.isEmpty) return;
      final className = classes.first.name;
      final correctName = className.rawClassName;

      final offset = classes.first.nameOffset;
      final length = classes.first.nameLength;

      reporter.createChangeBuilder(
        message: 'Change to $correctName',
        priority: 1,
      )
      .addDartFileEdit((builder) {
        builder.addSimpleReplacement(
          SourceRange(offset, length),
          correctName,
        );
      });
    });
  }
}
