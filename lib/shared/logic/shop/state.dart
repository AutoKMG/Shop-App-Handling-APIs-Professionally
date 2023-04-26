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

class MainShopStateCategoriesRetrieveDone extends MainShopState {}

class MainShopStateCategoriesRetrieveLoading extends MainShopState {}

class MainShopStateCategoriesRetrieveError extends MainShopState {
  final String error;
  MainShopStateCategoriesRetrieveError(this.error);
}

class MainShopStateLocalProductFavoriteChange extends MainShopState {}

class MainShopStateProductFavoriteChangeSuccess extends MainShopState {}

class MainShopProductFavoriteChangeError extends MainShopState {
  final String error;

  MainShopProductFavoriteChangeError(this.error);
}

class MainShopStateFavoritesRetrieveDone extends MainShopState {}

class MainShopStateFavoritesRetrieveLoading extends MainShopState {}

class MainShopStateFavoritesRetrieveError extends MainShopState {
  final String error;
  MainShopStateFavoritesRetrieveError(this.error);
}

class MainShopStateProfileRetrieveDone extends MainShopState {}

class MainShopStateProfileRetrieveLoading extends MainShopState {}

class MainShopStateProfileRetrieveError extends MainShopState {
  final String error;
  MainShopStateProfileRetrieveError(this.error);
}

class MainShopStateProfileUpdateDone extends MainShopState {}

class MainShopStateProfileUpdateLoading extends MainShopState {}

class MainShopStateProfileUpdateError extends MainShopState {
  final String error;
  MainShopStateProfileUpdateError(this.error);
}
