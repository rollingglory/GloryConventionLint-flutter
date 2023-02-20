import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:glory_convention_lint/helper/string_extention.dart';

import '../helper/documentation_constants.dart';

//correct_network_service..

class NetworkServiceAnnotationConvention extends DartLintRule {
  NetworkServiceAnnotationConvention() : super(code: _code);

  static const _code = LintCode(
      name: 'network_service_annotation_convention',
      problemMessage:
          "⚠️RestApi Annotation is required to declare service for retrofit pattern.",
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
      var declaredElement = node.declaredElement;
      if (declaredElement != null) {
        bool isLintSatisfied = false;
        var fileName = declaredElement.source.uri.path;
        var classes = declaredElement.classes;

        if (!fileName.isPathServices()) {
          return;
        }

        if (node.declarations.isEmpty) {
          isLintSatisfied = false;
          return;
        }

        for (var declaration in node.declarations) {
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

        ClassElement classInstance = classes.first;
        var offset = classInstance.nameOffset;

        var length = classInstance.nameLength;

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
      var declaredElement = node.declaredElement;
      var classes = declaredElement?.classes;
      int classLength = 'abstract class '.length;

      if (classes == null || classes.isEmpty) return;
      var offset = classes.first.nameOffset;

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Add @RestApi()',
        priority: 2,
      );
      changeBuilder.addDartFileEdit((builder) {
        builder.addSimpleReplacement(
          SourceRange(offset - classLength, 0),
          '@RestApi()\n',
        );
      });
    });
  }
}
