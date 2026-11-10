import 'package:flutter_test/flutter_test.dart';

import 'package:shop_easy/main.dart';

void main() {
  testWidgets('ShopEasy smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ShopEasyApp());
    expect(find.text('ShopEasy'), findsOneWidget);
  });
}
