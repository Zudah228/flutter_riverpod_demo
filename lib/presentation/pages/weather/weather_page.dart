import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/weather/current_weather_response/current_weather_response.dart';
import '../../../domain/entities/weather/weather_error/weather_error.dart';
import '../../../domain/use_cases/weather/weather_current_get.dart';

class WeatherPage extends ConsumerStatefulWidget {
  const WeatherPage._();

  static const routeName = '/weather';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const WeatherPage._(),
    );
  }

  @override
  ConsumerState<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends ConsumerState<WeatherPage> {
  final _locationController = TextEditingController(text: 'Tokyo');
  final _fetchedWeathers = <CurrentWeatherResponse>[];

  Future<void> _onSubmitted() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    try {
      final data =
          await ref.read(weatherCurrentGet)(location: _locationController.text);
      _fetchedWeathers.add(data);
      _locationController.clear();

      setState(() {});
    } on WeatherError catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
            e.message,
            style: TextStyle(color: colorScheme.onError),
          ),
          backgroundColor: colorScheme.error,
        ),
      );
    } on Exception catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            style: TextStyle(color: colorScheme.onError),
          ),
          backgroundColor: colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('現在の天気')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _locationController,
                    onEditingComplete: _onSubmitted,
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _onSubmitted,
                  child: const Icon(Icons.search),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final weather = _fetchedWeathers[index];

                  return ListTile(
                    leading: Image.network(weather.current.condition.iconUrl),
                    title: Text(weather.current.condition.text),
                    subtitle: Text(
                      '${weather.location.name} ${DateFormat('y年M月d日').format(weather.location.localtime)}',
                    ),
                  );
                },
                separatorBuilder: (_, __) {
                  return const SizedBox(height: 16);
                },
                itemCount: _fetchedWeathers.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
