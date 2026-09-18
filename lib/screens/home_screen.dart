import 'package:flutter/material.dart';
import '../models/astronomy_item.dart';
import '../widgets/category_shortcut.dart';
import 'details_screen.dart';

/// Tela Home do Astrova.
///
/// Reproduz fielmente o print da tela inicial:
/// - Destaque astronômico ("Andrômeda em detalhes") com data e botão de ação;
/// - Seção "Explore o universo" com atalhos interativos para Planetas, Galáxias e Estrelas;
/// - Botão "Ver tudo >" que direciona para a aba Explorar;
/// - Card "CURIOSIDADE CÓSMICA" ("O som não viaja pelo espaço").
class HomeScreen extends StatelessWidget {
  final Function(String? category)? onNavigateToExplore;

  const HomeScreen({
    super.key,
    this.onNavigateToExplore,
  });

  // Objeto de destaque (Andrômeda) exibido no card principal
  static const AstronomyItem _destaqueAndromeda = AstronomyItem(
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
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090A15),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===============================================================
              // CARD DE DESTAQUE ASTRONÔMICO
              // ===============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF131735),
                      Color(0xFF0D1024),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFF232B52),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Data do destaque
                    const Text(
                      '16 DE SETEMBRO DE 2026',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF8699FB),
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Título do destaque
                    const Text(
                      'Andrômeda em detalhes',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Subtítulo descritivo
                    const Text(
                      'Conheça a vizinha espiral da Via Láctea, a 2,5 milhões de anos-luz de nós.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFA0A5BD),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Botão "Ver detalhes ->"
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7B8CDE),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                        onPressed: () {
                          // Navegação nativa para os detalhes do objeto em destaque
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailsScreen(
                                item: _destaqueAndromeda,
                              ),
                            ),
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Ver detalhes',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, size: 18),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // ===============================================================
              // SEÇÃO "EXPLORE O UNIVERSO"
              // ===============================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Explore o universo',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Ao tocar em "Ver tudo >", muda para a aba Explorar
                      onNavigateToExplore?.call(null);
                    },
                    child: const Row(
                      children: [
                        Text(
                          'Ver tudo',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF7B8CDE),
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.chevron_right,
                          color: Color(0xFF7B8CDE),
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // 3 Cards de Atalho de Categoria
              Row(
                children: [
                  CategoryShortcut(
                    title: 'Planetas',
                    icon: Icons.blur_circular,
                    iconColor: const Color(0xFF38BDF8),
                    onTap: () => onNavigateToExplore?.call('Planetas'),
                  ),
                  CategoryShortcut(
                    title: 'Galáxias',
                    icon: Icons.auto_awesome,
                    iconColor: const Color(0xFFC084FC),
                    onTap: () => onNavigateToExplore?.call('Galáxias'),
                  ),
                  CategoryShortcut(
                    title: 'Estrelas',
                    icon: Icons.star_border_rounded,
                    iconColor: const Color(0xFF67E8F9),
                    onTap: () => onNavigateToExplore?.call('Estrelas'),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // ===============================================================
              // CARD "CURIOSIDADE CÓSMICA"
              // ===============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF10142B),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: const Color(0xFF20264A),
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ícone circular com interrogação
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Color(0xFF211838),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.help_outline,
                        color: Color(0xFFC084FC),
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Conteúdo da curiosidade
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CURIOSIDADE CÓSMICA',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFC084FC),
                              letterSpacing: 0.8,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'O som não viaja pelo espaço',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Sem ar para transportar ondas sonoras, o espaço permanece essencialmente silencioso.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF9CA3AF),
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
