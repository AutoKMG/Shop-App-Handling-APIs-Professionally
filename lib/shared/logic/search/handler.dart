import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/logic/search/state.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchHandler extends Cubit<SearchStates> {
  SearchHandler() : super(SearchStatesInitial()) {
    token = CacheHelper.getData(key: 'token');
    lang = CacheHelper.getData(key: 'lang');
  }
  SearchModel searchModel;
  String token;
  String lang;
  Future<void> searchProducts(String searchText) async {
    emit(SearchStatesLoading());
    DioHelper.postData(
            url: SEARCH, data: {"text": searchText}, lang: lang, token: token)
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchStatesSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(SearchStatesError(error.toString()));
    });
  }
}
