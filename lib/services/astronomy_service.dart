import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/astronomy_item.dart';

class AstronomyService {
  // Onde se encontra a API: Endpoint REST com os dados astronômicos em formato JSON
  static const String _apiUrl =
      'https://raw.githubusercontent.com/maddumuller/astrova/main/assets/data/astronomy_items.json';

  // Onde se encontra a API: Endpoint da NASA APOD (Astronomy Picture of the Day)
  static const String _nasaApodUrl =
      'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY';

  static AstronomyItem? _cachedApod;

  Future<AstronomyItem> getNasaApod() async {
    if (_cachedApod != null) {
      return _cachedApod!;
    }

    try {
      // Requisito: Consumo de API REST - Requisição HTTP GET assíncrona (com async/await)
      final response = await http
          .get(Uri.parse(_nasaApodUrl))
          .timeout(const Duration(seconds: 8));

      // Requisito: Consumo de API REST - Recebimento e validação da resposta (statusCode 200)
      if (response.statusCode == 200) {
        // Requisito: Consumo de API REST - Decodificação do JSON (jsonDecode) e conversão para objetos AstronomyItem
        final Map<String, dynamic> json =
            jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

        final explanation = json['explanation'] as String? ?? '';
        final shortDesc = explanation.length > 130
            ? '${explanation.substring(0, 130)}...'
            : explanation;
        final imageUrl = json['url'] as String? ??
            (json['hdurl'] as String? ??
                'https://images.unsplash.com/photo-1506703719100-a0f3a48c0f86?w=400&q=80');
        final date = json['date'] as String? ?? '';
        final copyright = json['copyright'] as String?;

        _cachedApod = AstronomyItem(
          id: 'nasa_apod',
          name: json['title'] as String? ?? 'Destaque Astronômico',
          category: 'NASA APOD',
          type: 'FOTO ASTRONÔMICA DO DIA',
          shortDescription: shortDesc,
          description: explanation,
          imageUrl: imageUrl,
          distance: date.isNotEmpty ? 'Data: $date' : 'Hoje',
          diameter: copyright != null
              ? 'Créditos: ${copyright.replaceAll('\n', ' ').trim()}'
              : 'Créditos: NASA / APOD',
          curiosity:
              'A Astronomy Picture of the Day (APOD) é um serviço mantido pela NASA que apresenta diariamente uma imagem ou fotografia diferente do universo.',
        );

        return _cachedApod!;
      } else {
        return _obterDadosLocais()[3];
      }
    } catch (e) {
      return _obterDadosLocais()[3];
    }
  }

  Future<List<AstronomyItem>> getAstronomyItems() async {
    try {
      // Requisito: Consumo de API REST - Requisição HTTP GET assíncrona (com async/await)
      final response = await http
          .get(Uri.parse(_apiUrl))
          .timeout(const Duration(seconds: 5));

      // Requisito: Consumo de API REST - Recebimento e validação da resposta (statusCode 200)
      if (response.statusCode == 200) {
        // Requisito: Consumo de API REST - Decodificação do JSON (jsonDecode) e conversão para objetos AstronomyItem
        final List<dynamic> listaJson = jsonDecode(utf8.decode(response.bodyBytes));
        final List<AstronomyItem> itens = listaJson
            .map((item) => AstronomyItem.fromJson(item as Map<String, dynamic>))
            .toList();

        return itens;
      } else {
        return _obterDadosLocais();
      }
    } catch (e) {
      return _obterDadosLocais();
    }
  }

  List<AstronomyItem> _obterDadosLocais() {
    return const [
      AstronomyItem(
        id: '1',
        name: 'Marte',
        category: 'Planetas',
        type: 'PLANETA ROCHOSO',
        shortDescription: 'O planeta vermelho e seu passado moldado por água.',
        description:
            'Marte é o quarto planeta a partir do Sol e o segundo menor do Sistema Solar. Conhecido como o Planeta Vermelho devido ao óxido de ferro predominante em sua superfície, possui montanhas gigantes como o Monte Olimpo e vales profundos como o Valles Marineris.',
        imageUrl:
            'https://images.unsplash.com/photo-1614728894747-a83421e2b9c9?w=400&q=80',
        distance: '225 milhões de km',
        diameter: '6.779 km',
        curiosity:
            'Marte abriga o maior vulcão do Sistema Solar, o Monte Olimpo, com cerca de 22 km de altura.',
      ),
      AstronomyItem(
        id: '2',
        name: 'Júpiter',
        category: 'Planetas',
        type: 'GIGANTE GASOSO',
        shortDescription:
            'O maior planeta do Sistema Solar e sua Grande Mancha.',
        description:
            'Júpiter é o maior planeta do Sistema Solar, tanto em diâmetro quanto em massa. É um gigante gasoso composto principalmente por hidrogênio e hélio, famoso por suas faixas atmosféricas e pela Grande Mancha Vermelha, uma tempestade colossal que dura há séculos.',
        imageUrl:
            'https://images.unsplash.com/photo-1614314107768-6018061b5b72?w=400&q=80',
        distance: '778 milhões de km',
        diameter: '139.820 km',
        curiosity:
            'A Grande Mancha Vermelha de Júpiter é uma tempestade anticiclônica maior do que o próprio planeta Terra.',
      ),
      AstronomyItem(
        id: '3',
        name: 'Saturno',
        category: 'Planetas',
        type: 'GIGANTE GASOSO',
        shortDescription:
            'Um mundo cercado pelo mais fascinante sistema de anéis.',
        description:
            'Saturno é o sexto planeta a partir do Sol e o segundo maior do Sistema Solar. É mundialmente reconhecido por seu espetacular e complexo sistema de anéis formados por bilhões de partículas de gelo e rocha.',
        imageUrl:
            'https://images.unsplash.com/photo-1614732484003-ef9881555dc3?w=400&q=80',
        distance: '1,4 bilhão de km',
        diameter: '116.460 km',
        curiosity:
            'Apesar de seu tamanho imenso, Saturno é o planeta menos denso do Sistema Solar — se houvesse uma banheira grande o suficiente, ele flutuaria na água!',
      ),
      AstronomyItem(
        id: '4',
        name: 'Andrômeda',
        category: 'Galáxias',
        type: 'GALÁXIA ESPIRAL',
        shortDescription: 'Nossa grande vizinha no Grupo Local de galáxias.',
        description:
            'A Galáxia de Andrômeda (Messier 31) é uma galáxia espiral localizada a aproximadamente 2,5 milhões de anos-luz da Terra. É a galáxia mais próxima da Via Láctea e o objeto mais distante visível a olho nu no céu noturno.',
        imageUrl:
            'https://images.unsplash.com/photo-1506703719100-a0f3a48c0f86?w=400&q=80',
        distance: '2,5 milhões de anos-luz',
        diameter: '220.000 anos-luz',
        curiosity:
            'Em cerca de 4 a 5 bilhões de anos, a Galáxia de Andrômeda e a Via Láctea vão colidir e se fundir em uma gigantesca galáxia elíptica.',
      ),
      AstronomyItem(
        id: '5',
        name: 'Sirius',
        category: 'Estrelas',
        type: 'ESTRELA BINÁRIA',
        shortDescription: 'A estrela mais brilhante do céu noturno terrestre.',
        description:
            'Sirius (Alfa Canis Majoris) é a estrela mais brilhante observável no céu noturno da Terra. Na verdade, trata-se de um sistema binário composto por Sirius A, uma estrela branca da sequência principal, e Sirius B, uma anã branca tênue.',
        imageUrl:
            'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=400&q=80',
        distance: '8,6 anos-luz',
        diameter: '2,4 milhões de km',
        curiosity:
            'Sirius é tão brilhante não apenas por sua luminosidade intrínseca, mas principalmente por estar muito próxima do nosso Sistema Solar.',
      ),
    ];
  }
}
