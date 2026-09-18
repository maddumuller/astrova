import 'package:flutter_test/flutter_test.dart';
import 'package:astrova/main.dart';

void main() {
  testWidgets('AstrovaApp smoke test - carrega tela inicial', (WidgetTester tester) async {
    // Constrói o aplicativo Astrova
    await tester.pumpWidget(const AstrovaApp());

    // Verifica a presença do título da Home e botões
    expect(find.text('Andrômeda em detalhes'), findsOneWidget);
    expect(find.text('Explore o universo'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Explorar'), findsOneWidget);
    expect(find.text('Sobre'), findsOneWidget);
  });
}
