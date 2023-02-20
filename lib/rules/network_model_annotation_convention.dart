import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:glory_convention_lint/helper/documentation_constants.dart';
import 'package:glory_convention_lint/helper/string_extention.dart';

class NetworkModelAnnotationConvention extends DartLintRule {
  NetworkModelAnnotationConvention() : super(code: _code);

  static const _code = LintCode(
      name: 'network_model_annotation_convention',
      problemMessage:
          "⚠️JsonSerializable Annotation is required to declare model for retrofit pattern.",
      correctionMessage:
          "You have to add '@JsonSerializable()' on top of your model class. \n\n${DocumentationConstants.modelAnnotationConvention}",
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

        if (!fileName.isPathModel()) {
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
              if (evaluatedAnnotation.contains('JsonSerializable')) {
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
  List<Fix> getFixes() => [_AddJsonAnnotation()];
}

class _AddJsonAnnotation extends DartFix {
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
      int classLength = 'class '.length;

      if (classes == null || classes.isEmpty) return;
      var offset = classes.first.nameOffset;

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Add @JsonSerializable()',
        priority: 2,
      );
      changeBuilder.addDartFileEdit((builder) {
        builder.addSimpleReplacement(
          SourceRange(offset - classLength, 0),
          '@JsonSerializable()\n',
        );
      });
    });
  }
}
