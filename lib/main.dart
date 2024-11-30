import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Screens/Nav_Screen.dart';
import 'package:flutter/services.dart';
// Providers
final tripTypeProvider = StateProvider<String>((ref) => "One-way");
final sliderIndexProvider = StateProvider<int>((ref) => 0);
final tripModeProvider = StateProvider<String>((ref) => "Outstation Trip");
final pickupCityProvider = StateProvider<String?>((ref) => null);
final dropCityProvider = StateProvider<String?>((ref) => null);
final pickupDateProvider = StateProvider<String?>((ref) => null);
final pickupTimeProvider = StateProvider<String?>((ref) => null);
final notificationCountProvider = StateProvider<int>((ref) => 1);
final roundTripDetailsProvider = StateProvider<bool>((ref) => false);
final toTheAirportProvider = StateProvider<bool>((ref) => true);
final fromDateProvider = StateProvider<DateTime?>((ref) => null);
final toDateProvider = StateProvider<DateTime?>((ref) => null);
final airtripTypeProvider = StateProvider<String>((ref) => "To The Airport");
final selectedIndexProvider = StateProvider<int>((ref) => 0);
final textProvider = StateProvider.family<String, int>((ref, id) => "");


void main() {
  debugPaintSizeEnabled=false;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NavScreen(),
    );
  }
}
