part of 'handler.dart';

@immutable
abstract class MainShopState {}

class MainShopStateInitial extends MainShopState {}

class MainShopStateToggleDirectionality extends MainShopState {}

class MainShopStateToggleDarkTheme extends MainShopState {}

class MainShopStateBottomNavBarIndexChanged extends MainShopState {}

class MainShopStateProductsRetrieveDone extends MainShopState {}

class MainShopStateProductsRetrieveLoading extends MainShopState {}

class MainShopStateProductsRetrieveError extends MainShopState {
  final String error;
  MainShopStateProductsRetrieveError(this.error);
}
