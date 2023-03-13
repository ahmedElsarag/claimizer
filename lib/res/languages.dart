import 'package:Cliamizer/generated/l10n.dart';

class Languages {
  Languages(this.lang);
  String lang;
  @override
  String toString() {
    return lang == 'en' ? S.current.en : S.current.ar;
  }
}
