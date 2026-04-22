import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Manages the application locale.
///
/// Emits a [Locale] state that the root [MaterialApp] listens to
/// for switching between Arabic and English.
class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en'));

  void switchToArabic() => emit(const Locale('ar'));
  void switchToEnglish() => emit(const Locale('en'));

  void toggleLocale() {
    if (state.languageCode == 'ar') {
      emit(const Locale('en'));
    } else {
      emit(const Locale('ar'));
    }
  }

  void setLocale(Locale locale) => emit(locale);

  bool get isArabic => state.languageCode == 'ar';
  bool get isEnglish => state.languageCode == 'en';
}
