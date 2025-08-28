import 'package:resto_app/data/model/customer_review.dart';

sealed class ReviewAddResultState {}

class ReviewAddNoneState extends ReviewAddResultState {}

class ReviewAddLoadingState extends ReviewAddResultState {}

class ReviewAddErrorState extends ReviewAddResultState {
  final String error;
  ReviewAddErrorState(this.error);
}

class ReviewAddLoadedState extends ReviewAddResultState {
  final List<CustomerReview> reviews;
  ReviewAddLoadedState(this.reviews);
}
