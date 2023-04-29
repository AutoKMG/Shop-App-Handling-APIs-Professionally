abstract class SearchStates {}

class SearchStatesInitial extends SearchStates {}

class SearchStatesLoading extends SearchStates {}

class SearchStatesSuccess extends SearchStates {}

class SearchStatesError extends SearchStates {
  final String error;
  SearchStatesError(this.error);
}
