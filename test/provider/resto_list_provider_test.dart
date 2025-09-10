import 'package:mocktail/mocktail.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/data/model/resto_brief.dart';
import 'package:resto_app/data/model/resto_list_response.dart';
import 'package:resto_app/provider/home/resto_list_provider.dart';
import 'package:resto_app/static/resto_list_result_state.dart';
import 'package:test/test.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService apiService;
  late RestoListProvider restoListProvider;

  final expectedRestoList = [
    RestoBrief(
      id: "id_1",
      name: "Test Restaurant",
      description: "Test Description",
      pictureId: "1",
      city: "Test City",
      rating: 4.5,
    ),
    RestoBrief(
      id: "id_2",
      name: "Test Restaurant 2",
      description: "Test Description 2",
      pictureId: "2",
      city: "Test City 2",
      rating: 4.2,
    ),
  ];
  final apiRestoList = [
    RestoBrief(
      id: "id_1",
      name: "Test Restaurant",
      description: "Test Description",
      pictureId: "1",
      city: "Test City",
      rating: 4.5,
    ),
    RestoBrief(
      id: "id_2",
      name: "Test Restaurant 2",
      description: "Test Description 2",
      pictureId: "2",
      city: "Test City 2",
      rating: 4.2,
    ),
  ];
  final restoListResponse = RestoListResponse(
    error: false,
    message: "success",
    count: 2,
    restaurants: apiRestoList,
  );

  final expectedErrorStatusCode = "Failed to load resto list";
  final expectedErrorNoConnection =
      "No Internet Connection. Please try again later.";
  setUp(() {
    apiService = MockApiService();
    restoListProvider = RestoListProvider(apiService);
  });

  group("RestoListProvider", () {
    test("Should return RestoListNoneState() when first initialized", () {
      final state = restoListProvider.resultState;
      expect(state, isA<RestoListNoneState>());
    });
    group("fetchRestoList()", () {
      test(
        "Should return list of resto when ApiService call is success (http status code == 200)",
        () async {
          when(
            () => apiService.getRestoList(),
          ).thenAnswer((_) async => restoListResponse);

          await restoListProvider.fetchRestoList();
          final state = restoListProvider.resultState;

          expect(state, isA<RestoListLoadedState>());
          expect(state, equals(RestoListLoadedState(expectedRestoList)));
        },
      );

      test(
        "Should return error when ApiService call is failed (http status code != 200)",
        () async {
          final error = "Failed to load resto list";
          when(() => apiService.getRestoList()).thenThrow(error);

          await restoListProvider.fetchRestoList();
          final state = restoListProvider.resultState;

          expect(state, isA<RestoListErrorState>());
          expect(state, equals(RestoListErrorState(expectedErrorStatusCode)));
        },
      );

      test(
        "Should return error when ApiService call is failed (no connection)",
        () async {
          final error = "No Internet Connection. Please try again later.";
          when(() => apiService.getRestoList()).thenThrow(error);

          await restoListProvider.fetchRestoList();
          final state = restoListProvider.resultState;

          expect(state, isA<RestoListErrorState>());
          expect(state, equals(RestoListErrorState(expectedErrorNoConnection)));
        },
      );
    });
  });
}
