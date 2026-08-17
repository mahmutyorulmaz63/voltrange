import 'package:flutter_test/flutter_test.dart';
import 'package:ev_battery_tracker/main.dart';

void main() {
  testWidgets('EV Battery App yukleme testi', (WidgetTester tester) async {
    
    await tester.pumpWidget(const EVBatteryApp());

    
    expect(find.text('Elektrikli Motorum'), findsOneWidget);
  });
}