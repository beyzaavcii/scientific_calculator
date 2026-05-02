import 'package:flutter_test/flutter_test.dart';
import 'package:scientific_calculator/main.dart';

void main() {
  testWidgets('Scientific Calculator UI Test', (WidgetTester tester) async {
    // Uygulamayı başlat
    await tester.pumpWidget(const ScientificCalculatorApp());

    // Ekranda en az bir tane "0" metni bulunduğunu doğrula
    expect(find.text('0'), findsWidgets);
    
    // "sin(" butonunun ekranda var olduğunu doğrula
    expect(find.text('sin('), findsOneWidget);
  });
}