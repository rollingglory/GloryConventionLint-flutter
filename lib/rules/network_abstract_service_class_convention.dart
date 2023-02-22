import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../helper/documentation_constants.dart';
import '../helper/string_extention.dart';

class NetworkAbstractServiceClassConvention extends DartLintRule {
  const NetworkAbstractServiceClassConvention() : super(code: _code);

  static const _code = LintCode(
      name: 'network_abstract_service_class_convention',
      problemMessage:
          "⚠️Services class must be abstract, Please add abstract modifier to the services class",
      errorSeverity: ErrorSeverity.WARNING,
      correctionMessage: DocumentationConstants.serviceClassNameConvention);

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
          var offset = classInstance.nameOffset;
          var length = classInstance.nameLength;
          var name = classInstance.name;

          if (fileName.isPathServices()) {
            if (name.isCorrectClassServiceName()) {
              if (!classInstance.isAbstract) {
                reporter.reportErrorForOffset(code, offset, length);
              }
            }
          }
        }
      }
    });
  }

  @override
  List<Fix> getFixes() => [_AddAbstractToServicesClass()];
}

class _AddAbstractToServicesClass extends DartFix {
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
      final classLength = "class ".length;

      if (classes == null || classes.isEmpty) return;
      final offset = classes.first.nameOffset;

      reporter
          .createChangeBuilder(
        message: 'Add abstract',
        priority: 1,
      )
          .addDartFileEdit((builder) {
        builder.addSimpleReplacement(
          SourceRange(offset - classLength, 0),
          'abstract ',
        );
      });
    });
  }
}
