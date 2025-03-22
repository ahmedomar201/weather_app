import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/dataLayer/networks/models/weather_model.dart';
import 'package:weather_app/dataLayer/networks/repository/repository.dart';
import 'package:weather_app/dataLayer/networks/remote/dio_helper.dart';
import 'package:weather_app/core/error/exceptions.dart';

import 'dio_helper.mocks.mocks.dart';

@GenerateMocks([DioHelper])
void main() {
  late MockDioHelper mockDioHelper;
  late RepoImplementation repository;

  setUp(() {
    mockDioHelper = MockDioHelper();
    repository = RepoImplementation(dioHelper: mockDioHelper);
  });

  const cityName = 'Cairo';
  final weatherData = {
    "name": cityName,
    "main": {"temp": 30.0, "humidity": 50},
    "wind": {"speed": 10.0},
    "weather": [{"main": "Clear"}]
  };

  test('returns WeatherModel when API call is successful', () async {
    when(mockDioHelper.get(url: anyNamed('url'))).thenAnswer(
      (_) async => Future.value(Response(data: weatherData, statusCode: 200,  requestOptions: RequestOptions(path: ''),)),
    );

    final result = await repository.getWeather(cityName);

    expect(result, isA<Right>());
    expect(result.getOrElse(() => WeatherModel()).name, cityName);
  });

  test('returns failure when API call fails', () async {
    when(mockDioHelper.get(url: anyNamed('url')))
        .thenThrow(ServerException(message: "Server Error", code: 500));

    final result = await repository.getWeather(cityName);

    expect(result, isA<Left>());
    expect(result.fold((l) => l, (r) => null), "Server Error");
  });
}
