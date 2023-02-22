import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import '../helper/documentation_constants.dart';
import '../helper/string_extention.dart';

class NetworkModelJsonImplementationConvention extends DartLintRule {
  const NetworkModelJsonImplementationConvention() : super(code: _code);

  static const _code = LintCode(
      name: 'network_nodel_json_implementation_convention',
      problemMessage: '⚠️Method toJson or fromJson is not implemented',
      correctionMessage: 'Add toJson method and fromJson method'
          '\n\n${DocumentationConstants.modelAnnotationConvention}',
      errorSeverity: ErrorSeverity.WARNING);

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    bool isFromJsonImplemented(CompilationUnitMember compilationUnitMember) {
      if (compilationUnitMember.toString().contains('FromJson')) {
        return true;
      }
      return false;
    }

    bool isToJsonImplemented(CompilationUnitMember compilationUnitMember) {
      if (compilationUnitMember.toString().contains('ToJson')) {
        return true;
      }
      return false;
    }

    context.registry.addCompilationUnit((node) {
      final declaredElement = node.declaredElement;
      final declarations = node.declarations;

      if (declaredElement != null && declarations.isNotEmpty) {
        final classes = declaredElement.classes;
        if (classes.isEmpty) return;
        var path = declaredElement.source.uri.path;
        var offset = classes.first.nameOffset;
        var length = classes.first.nameLength;

        if (path.isPathModel()) {
          for (final declaration in declarations) {
            if (!isFromJsonImplemented(declaration) || !isToJsonImplemented(declaration)) {
              reporter.reportErrorForOffset(code, offset, length);
            }
          }
        }
      }
    });
  }
}
