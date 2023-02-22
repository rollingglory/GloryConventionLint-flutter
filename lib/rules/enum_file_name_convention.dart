import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:glory_convention_lint/helper/string_extention.dart';

import '../helper/documentation_constants.dart';

class EnumFileNameConvention extends DartLintRule {
  const EnumFileNameConvention() : super(code: _code);

  static const _code = LintCode(
    name: 'enum_file_name_convention',
    problemMessage:
        "⚠️The file name '{0}' incorrect name for enum file. file name should end with '_enum'",
    correctionMessage: 'Try changing the file name that ends with "_enum". Example: user_enum.dart.'
        '\n\n${DocumentationConstants.enumFileNameConvention}',
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
        var path = declaredElement.source.uri.path;
        var fileName = declaredElement.source.shortName;
        var enums = declaredElement.enums;

        if (enums.isEmpty){
          if (path.isPathEnum()) {
            if (!path.isCorrectFileEnumName()) {
              reporter.reportErrorForOffset(code, 0, 0);
            }
          }
          return;
        }

        final offset = enums.first.nameOffset;
        final length = enums.first.nameLength;
        if (path.isPathEnum()) {
          if (!path.isCorrectFileEnumName()) {
            reporter.reportErrorForOffset(code, offset, length, [fileName]);
          }
        }
      }
    });
  }
}
