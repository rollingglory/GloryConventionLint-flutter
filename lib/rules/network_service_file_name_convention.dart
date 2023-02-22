import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../helper/documentation_constants.dart';
import '../helper/string_extention.dart';

class NetworkServiceFileNameConvention extends DartLintRule {
  const NetworkServiceFileNameConvention() : super(code: _code);

  static const _code = LintCode(
    name: 'network_service_file_name_convention',
    problemMessage:
        "⚠️The file name '{0}' isn't a correct name for services file. file name should end with '_services'",
    correctionMessage: 'Try changing the file name that ends with "_services". Example: user_services.dart. '
        '\n\n${DocumentationConstants.serviceFileNameConvention}',
      errorSeverity: ErrorSeverity.WARNING

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
        final path = declaredElement.source.uri.path;
        final classes = declaredElement.classes;
        var fileName = declaredElement.source.shortName;

        if (classes.isEmpty){
          if (path.isPathServices()) {
            if (!path.isCorrectFileServiceName()) {
              reporter.reportErrorForOffset(code, 0, 0);
            }
          }
          return;
        }

        final offset = classes.first.nameOffset;
        final length = classes.first.nameLength;
        if (path.isPathServices()) {
          if (!path.isCorrectFileServiceName()) {
            reporter.reportErrorForOffset(code, offset, length,[fileName]);
          }
        }
      }
    });
  }
}
