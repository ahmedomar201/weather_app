import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/dataLayer/cubit/app_cubit.dart';
import 'package:weather_app/dataLayer/cubit/app_state.dart';
import 'package:weather_app/dataLayer/networks/models/weather_model.dart';
import 'package:weather_app/dataLayer/networks/repository/repository.dart';

import 'app_bloc_test.mocks.dart';

@GenerateMocks([Repository])
void main() {
  late MockRepository mockRepository;
  late AppBloc appBloc;

  setUp(() {
    mockRepository = MockRepository();
    appBloc = AppBloc(repository: mockRepository);
  });

  tearDown(() {
    appBloc.close();
  });

  test('initial state should be Empty', () {
    expect(appBloc.state, Empty());
  });

  group('getWeather', () {
    const cityName = 'Cairo';
    final weatherModel = WeatherModel(
      name: cityName,
      main: Main(temp: 30.0, humidity: 50),
      wind: Wind(speed: 10.0),
      weather: [Weather(main: "Clear")],
    );

    test('emits [GetWeatherLoading, GetWeatherSuccess] when data is fetched successfully', () async {
      when(mockRepository.getWeather(cityName))
          .thenAnswer((_) async => Right(weatherModel));

      appBloc.cityController.text = cityName;
      appBloc.getWeather(null);

      await expectLater(
        appBloc.stream,
        emitsInOrder([isA<GetWeatherLoading>(), isA<GetWeatherSuccess>()]),
      );
    });

    test('emits [GetWeatherLoading, GetWeatherError] when API fails', () async {
      when(mockRepository.getWeather(cityName))
          .thenAnswer((_) async => Left("City not found"));

      appBloc.cityController.text = cityName;
      appBloc.getWeather(null);

      await expectLater(
        appBloc.stream,
        emitsInOrder([isA<GetWeatherLoading>(), isA<GetWeatherError>()]),
      );
    });
  });
}
