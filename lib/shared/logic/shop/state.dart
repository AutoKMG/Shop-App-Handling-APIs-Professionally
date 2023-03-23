part of 'handler.dart';

@immutable
abstract class ShopState {}

class ShopStateInitial extends ShopState {}

class ShopStateToggleDirectionality extends ShopState {}

class ShopStateToggleDarkTheme extends ShopState {}
