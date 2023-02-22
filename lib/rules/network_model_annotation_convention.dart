import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:glory_convention_lint/helper/documentation_constants.dart';
import 'package:glory_convention_lint/helper/string_extention.dart';

class NetworkModelAnnotationConvention extends DartLintRule {
  const NetworkModelAnnotationConvention() : super(code: _code);

  static const _code = LintCode(
      name: 'network_model_annotation_convention',
      problemMessage:
          '⚠️JsonSerializable Annotation is required to declare model for retrofit pattern.',
      correctionMessage:
          "You have to add '@JsonSerializable()' on top of your model class. "
              "\n\n${DocumentationConstants.modelAnnotationConvention}",
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

        //Check if path is model path
        if (!fileName.isPathModel()) {
          return;
        }

        if (node.declarations.isEmpty) {
          isLintSatisfied = false;
          return;
        }

        //Check if annotation already implementing JsonSerializable
        for (final declaration in node.declarations) {
          if (declaration is ClassDeclaration) {
            final classAnnotations = declaration.metadata;
            for (final annotation in classAnnotations) {
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

        final classInstance = classes.first;
        final offset = classInstance.nameOffset;
        final length = classInstance.nameLength;

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
      final declaredElement = node.declaredElement;
      final classes = declaredElement?.classes;
      const classLength = 'class '.length;

      if (classes == null || classes.isEmpty) return;
      final offset = classes.first.nameOffset;

      reporter.createChangeBuilder(
        message: 'Add @JsonSerializable()',
        priority: 2,
      )
      .addDartFileEdit((builder) {
        builder.addSimpleReplacement(
          SourceRange(offset - classLength, 0),
          '@JsonSerializable()\n',
        );
      });
    });
  }
}
