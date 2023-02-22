import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../helper/documentation_constants.dart';
import '../helper/string_extention.dart';

//correct_network_service..

class NetworkServiceAnnotationConvention extends DartLintRule {
  const NetworkServiceAnnotationConvention() : super(code: _code);

  static const _code = LintCode(
      name: 'network_service_annotation_convention',
      problemMessage:
          '⚠️RestApi Annotation is required to declare service for retrofit pattern.',
      correctionMessage:
          "You have to add '@RestApi()' on top of your model class, \n\n${DocumentationConstants.serviceAnnotationConvention}",
      errorSeverity: ErrorSeverity.WARNING);

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addCompilationUnit((node) {
      final declaredElement = node.declaredElement;
      if (declaredElement != null) {
        var isLintSatisfied = false;
        final fileName = declaredElement.source.uri.path;
        final classes = declaredElement.classes;

        if (!fileName.isPathServices()) {
          return;
        }

        if (node.declarations.isEmpty) {
          isLintSatisfied = false;
          return;
        }

        for (final declaration in node.declarations) {
          if (declaration is ClassDeclaration) {
            final classAnnotations = declaration.metadata;
            for (var annotation in classAnnotations) {
              final evaluatedAnnotation = annotation.name.name;
              if (evaluatedAnnotation.contains('RestApi')) {
                isLintSatisfied = true;
              } else {
                isLintSatisfied = false;
              }
            }
          }
        }

        if (classes.isEmpty) {
          return;
        }

        if (isLintSatisfied == true) {
          return;
        }

        final classInstance = classes.first;
        final offset = classInstance.nameOffset;

        final length = classInstance.nameLength;
        var isAbstract = classInstance.isAbstract;
        if (!isAbstract) return;

        reporter.reportErrorForOffset(code, offset, length);
      }
    });
  }

  @override
  List<Fix> getFixes() => [_AddRestApiAnnotation()];
}

class _AddRestApiAnnotation extends DartFix {
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
      const classLength = 'abstract class '.length;

      if (classes == null || classes.isEmpty) return;
      final offset = classes.first.nameOffset;
      final isAbstract = classes.first.isAbstract;
      if (!isAbstract) return;

      reporter.createChangeBuilder(
        message: 'Add @RestApi()',
        priority: 2,
      ).addDartFileEdit((builder) {
        builder.addSimpleReplacement(
          SourceRange(offset - classLength, 0),
          '@RestApi()\n',
        );
      });
    });
  }
}
