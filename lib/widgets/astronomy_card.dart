import 'package:flutter/material.dart';
import '../models/astronomy_item.dart';

/// Card que representa um objeto astronômico na lista (ListView) da tela Explorar.
///
/// Reproduz fielmente o visual dos prints:
/// - Fundo escuro azulado com borda sutil;
/// - Imagem com cantos arredondados;
/// - Categoria em caixa alta na cor lilás/azul;
/// - Título em branco e descrição resumida;
/// - Seta indicadora (chevron_right).
class AstronomyCard extends StatelessWidget {
  final AstronomyItem item;
  final VoidCallback onTap;

  const AstronomyCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF10142B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF20264A),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Imagem do astro com cantos arredondados
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    width: 70,
                    height: 70,
                    color: const Color(0xFF090A15),
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      // Tratamento caso a imagem demore para carregar
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFF7B8CDE),
                            ),
                          ),
                        );
                      },
                      // Fallback elegante caso a imagem falhe
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFF161B36),
                          child: const Icon(
                            Icons.blur_on,
                            color: Color(0xFF7B8CDE),
                            size: 32,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Informações textuais (Categoria, Nome, Descrição)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tag da categoria/tipo
                      Text(
                        item.type.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF8699FB),
                          letterSpacing: 0.6,
                        ),
                      ),
                      const SizedBox(height: 3),

                      // Nome do objeto celeste
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 3),

                      // Descrição curta
                      Text(
                        item.shortDescription,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF9CA3AF),
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),

                // Ícone de seta para detalhes
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF7A829E),
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
