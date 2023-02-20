import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferSingleEnumPerFile extends DartLintRule {
  PreferSingleEnumPerFile() : super(code: _code);

  static const _code = LintCode(
      name: 'prefer_single_enum_per_file',
      problemMessage: '⚠️Theres only should be one enum per file',
      correctionMessage: 'Move enum to another file \n\n'
          '',
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
        var enums = declaredElement.enums;

        if (enums.length > 1) {
          for (var enumInstance in enums) {
            var offset = enumInstance.nameOffset;
            var length = enumInstance.nameLength;

            reporter.reportErrorForOffset(code, offset, length);
          }
        }
      }
    });
  }
}
