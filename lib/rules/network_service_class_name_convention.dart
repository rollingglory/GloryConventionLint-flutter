import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../helper/documentation_constants.dart';
import '../helper/lint_type_constant.dart';
import '../helper/string_extention.dart';

class NetworkServiceClassNameConvention extends DartLintRule {
  const NetworkServiceClassNameConvention() : super(code: _code);

  static const _code = LintCode(
    name: 'network_service_class_name_convention',
    problemMessage: "⚠️The class name isn't a correct name for service class. "
        "Services class should end with 'Services'. Example: GiftServices",
      errorSeverity: ErrorSeverity.WARNING,
    correctionMessage: DocumentationConstants.serviceClassNameConvention

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

          if (fileName.isPathServices()) {
            if (!name.isCorrectClassServiceName()) {
              reporter.reportErrorForOffset(code, offset, length);
            }
          }
        }
      }
    });
  }

  @override
  List<Fix> getFixes() => [_RenameServicesClass()];
}

class _RenameServicesClass extends DartFix {
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
      final correctName = className.renameClass(type: LintTypeConstant.serviceLint);

      final offset = classes.first.nameOffset;
      final length = classes.first.nameLength;

       reporter.createChangeBuilder(
        message: 'Change to $correctName',
        priority: 1,
      ).addDartFileEdit((builder) {
        builder.addSimpleReplacement(
          SourceRange(offset, length),
          correctName,
        );
      });
    });
  }
}
