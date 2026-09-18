import 'package:flutter/material.dart';

/// Card de atalho de categoria utilizado na tela Home (seção "Explore o universo").
///
/// Reproduz fielmente os cards de Planetas, Galáxias e Estrelas:
/// - Ícone estilizado com cor personalizada;
/// - Título em negrito branco;
/// - Fundo azul-escuro com borda sutil.
class CategoryShortcut extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const CategoryShortcut({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
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
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Ícone da categoria com cor temática
                  Icon(
                    icon,
                    color: iconColor,
                    size: 32,
                  ),
                  const SizedBox(height: 14),

                  // Nome da categoria
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
