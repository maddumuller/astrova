import 'package:flutter/material.dart';

/// Tela Sobre do Astrova.
///
/// Apresenta as informações do projeto acadêmico desenvolvido para a
/// disciplina de Desenvolvimento para Dispositivos Móveis (DDM).
///
/// Detalha as tecnologias utilizadas (Flutter, Dart, API REST)
/// e os requisitos avaliados na disciplina.
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090A15),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===============================================================
              // IDENTIFICAÇÃO DO APLICATIVO
              // ===============================================================
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF7B8CDE), Color(0xFF4F46E5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x4D7B8CDE),
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.rocket_launch,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Astrova',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF161B36),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF232B52)),
                      ),
                      child: const Text(
                        'TRABALHO ACADÊMICO — DDM',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF8699FB),
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ===============================================================
              // DESCRIÇÃO DO PROJETO
              // ===============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF10142B),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF20264A)),
                ),
                child: const Text(
                  'Aplicativo de visualização de informações astronômicas desenvolvido em Flutter para a disciplina de Desenvolvimento para Dispositivos Móveis (DDM).',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFA0A5BD),
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ===============================================================
              // TECNOLOGIAS UTILIZADAS
              // ===============================================================
              const Text(
                'Tecnologias Utilizadas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              _buildTechCard(
                title: 'Flutter',
                subtitle: 'Framework de interface multiplataforma da Google',
                icon: Icons.flutter_dash,
                iconColor: const Color(0xFF38BDF8),
              ),
              const SizedBox(height: 10),

              _buildTechCard(
                title: 'Dart',
                subtitle: 'Linguagem tipada, moderna e orientada a objetos',
                icon: Icons.code,
                iconColor: const Color(0xFF818CF8),
              ),
              const SizedBox(height: 10),

              _buildTechCard(
                title: 'API REST (http)',
                subtitle:
                    'Consumo assíncrono de dados astronômicos via requisições HTTP',
                icon: Icons.cloud_sync,
                iconColor: const Color(0xFFC084FC),
              ),
              const SizedBox(height: 24),

              // ===============================================================
              // REQUISITOS ACADÊMICOS CUMPRIDOS
              // ===============================================================
              const Text(
                'Requisitos Acadêmicos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF10142B),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF20264A)),
                ),
                child: Column(
                  children: [
                    _buildRequirementRow('Uso de Flutter e Dart'),
                    _buildRequirementRow('Navegação com BottomNavigationBar e Navigator'),
                    _buildRequirementRow('Exibição de itens com ListView'),
                    _buildRequirementRow('Consumo de API REST com async/await e JSON'),
                    _buildRequirementRow('Gerenciamento de estado nativo com setState'),
                    _buildRequirementRow('Separação modular de arquivos e pastas'),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ===============================================================
              // RODAPÉ COM VERSÃO
              // ===============================================================
              const Center(
                child: Text(
                  'Astrova • Versão 1.0.0',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  /// Constrói um card para exibição de tecnologia
  Widget _buildTechCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF10142B),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF20264A)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Constrói uma linha com ícone de confirmação para os requisitos atendidos
  Widget _buildRequirementRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFF34D399),
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFFD1D5DB),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
