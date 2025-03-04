import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart' as l10n;
import 'package:poke_detail/core/di/poke_locator.dart';
import 'package:poke_detail/l10n/app_localizations.dart';
import 'package:poke_detail/ui/design_system/poke_theme.dart';

import 'core/router/app_route.dart';

@pragma('vm:entry-point')
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PokeLocator.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouter.config(),
        theme: PokeTheme.of(context),
        localizationsDelegates: l10n.AppLocalizations.localizationsDelegates,
        supportedLocales: l10n.AppLocalizations.supportedLocales,
        builder: (context, child) {
          AppLocalizations.load(context);
          return child!;
        });
  }
}
