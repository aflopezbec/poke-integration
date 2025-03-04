import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart' as gen;

class AppLocalizations {
  AppLocalizations();

  static gen.AppLocalizations? _current;

  static gen.AppLocalizations get current {
    assert(_current != null,
        'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
    return _current!;
  }

  static void load(BuildContext context) {
    final instance = gen.AppLocalizations.of(context);
    assert(instance != null,
        'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    _current = instance;
  }
}
