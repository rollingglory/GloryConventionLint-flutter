import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../helper/documentation_constants.dart';

class PreferSingleTopLevelPerFile extends DartLintRule {
  const PreferSingleTopLevelPerFile() : super(code: _code);

  static const _code = LintCode(
      name: 'prefer_single_top_level_per_file',
      problemMessage: '⚠️Theres only should be only one class/enum/top level declaration in one file',
      correctionMessage: 'In case of multiple class you should move class to another file.\n'
          'In case of multiple enum, you should move enum to file inside of enum directory.\n'
          'In case of multiple top level declaration, you should move your declaration to constant file inside of constant directory.'
          '\n\n${DocumentationConstants.preferSingleClassPerFile}',
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
        final topLevels = declaredElement.topLevelVariables;
        final enums = declaredElement.enums;
        final classes = declaredElement.classes;
        final total = topLevels.length + enums.length + classes.length;

        if (total > 1) {
          for (final topLevel in topLevels) {
            final offset = topLevel.nameOffset;
            final length = topLevel.nameLength;
            reporter.reportErrorForOffset(code, offset, length);
          }

          for (final enumInstance in enums) {
            final offset = enumInstance.nameOffset;
            final length = enumInstance.nameLength;
            reporter.reportErrorForOffset(code, offset, length);
          }

          for (final classInstance in classes) {
            final offset = classInstance.nameOffset;
            final length = classInstance.nameLength;
            reporter.reportErrorForOffset(code, offset, length);
          }
        }
      }
    });
  }
}
