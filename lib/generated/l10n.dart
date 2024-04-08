// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `PokemonApp`
  String get pokemonapp {
    return Intl.message(
      'PokemonApp',
      name: 'pokemonapp',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get dashboardSkipButtonTitle {
    return Intl.message(
      'Skip',
      name: 'dashboardSkipButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get dashboardNextButtonTitle {
    return Intl.message(
      'Next',
      name: 'dashboardNextButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `GO!`
  String get dashboardGoButtonTitle {
    return Intl.message(
      'GO!',
      name: 'dashboardGoButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Find out who`
  String get dashboardFirstPageTitle {
    return Intl.message(
      'Find out who',
      name: 'dashboardFirstPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Find out about the abilities`
  String get dashboardSecondPageTitle {
    return Intl.message(
      'Find out about the abilities',
      name: 'dashboardSecondPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Collect them all`
  String get dashboardThirdPageTitle {
    return Intl.message(
      'Collect them all',
      name: 'dashboardThirdPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `IFunny is fun of your life. Images, GIFs and videos featured seven times a day. Your anaconda definitely wants some.`
  String get dashBoardPageDescription {
    return Intl.message(
      'IFunny is fun of your life. Images, GIFs and videos featured seven times a day. Your anaconda definitely wants some.',
      name: 'dashBoardPageDescription',
      desc: '',
      args: [],
    );
  }

  /// `All pokemon`
  String get listAppBarTitle {
    return Intl.message(
      'All pokemon',
      name: 'listAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Nothing was found for your query, try changing the search value.`
  String get listNothingFoundMessage {
    return Intl.message(
      'Nothing was found for your query, try changing the search value.',
      name: 'listNothingFoundMessage',
      desc: '',
      args: [],
    );
  }

  /// `Pokemon name...`
  String get searchFieldPlaceholder {
    return Intl.message(
      'Pokemon name...',
      name: 'searchFieldPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get searchFieldCancelButtonTitle {
    return Intl.message(
      'Cancel',
      name: 'searchFieldCancelButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Base experience`
  String get detailsAppBarTitle {
    return Intl.message(
      'Base experience',
      name: 'detailsAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get detailsHeightColumnTitle {
    return Intl.message(
      'Height',
      name: 'detailsHeightColumnTitle',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get detailsWeightColumnTitle {
    return Intl.message(
      'Weight',
      name: 'detailsWeightColumnTitle',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get detailsOrderColumnTitle {
    return Intl.message(
      'Order',
      name: 'detailsOrderColumnTitle',
      desc: '',
      args: [],
    );
  }

  /// `Abilities`
  String get DetailsAbilitiesSectionTitle {
    return Intl.message(
      'Abilities',
      name: 'DetailsAbilitiesSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Forms`
  String get DetailsFormsSectionTitle {
    return Intl.message(
      'Forms',
      name: 'DetailsFormsSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Moves`
  String get DetailsMovesSectionTitle {
    return Intl.message(
      'Moves',
      name: 'DetailsMovesSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `kg`
  String get DetailsWeightColumnUnit {
    return Intl.message(
      'kg',
      name: 'DetailsWeightColumnUnit',
      desc: '',
      args: [],
    );
  }

  /// `cm`
  String get DetailsHeightColumnUnit {
    return Intl.message(
      'cm',
      name: 'DetailsHeightColumnUnit',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
