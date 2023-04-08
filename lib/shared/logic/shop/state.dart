part of 'handler.dart';

@immutable
abstract class MainShopState {}

class MainShopStateInitial extends MainShopState {}

class MainShopStateToggleDirectionality extends MainShopState {}

class MainShopStateToggleDarkTheme extends MainShopState {}

class MainShopStateBottomNavBarIndexChanged extends MainShopState {}
