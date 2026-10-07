import 'package:flutter/material.dart';
import '../models/astronomy_item.dart';

class DetailsScreen extends StatelessWidget {
  final AstronomyItem item;

  const DetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090A15),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            // Requisito: Navegação entre telas com Navigator.pop
            Navigator.pop(context);
          },
        ),
        title: Text(
          item.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Container(
                height: 240,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF10142B),
                  border: Border.all(color: const Color(0xFF20264A)),
                ),
                child: Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.blur_on,
                        color: Color(0xFF7B8CDE),
                        size: 64,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1A3A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0x804338CA),
                ),
              ),
              child: Text(
                item.type.toUpperCase(),
                style: const TextStyle(
                  color: Color(0xFFC084FC),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              item.name,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              item.description,
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
                color: Color(0xFFA0A5BD),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Informações Adicionais',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                _buildInfoCard(
                  title: 'Distância da Terra',
                  value: item.distance,
                  icon: Icons.straighten,
                  iconColor: const Color(0xFF38BDF8),
                ),
                const SizedBox(width: 12),
                _buildInfoCard(
                  title: 'Diâmetro / Tamanho',
                  value: item.diameter,
                  icon: Icons.radio_button_checked,
                  iconColor: const Color(0xFFC084FC),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF10142B),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF20264A)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        color: Color(0xFF818CF8),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Curiosidade',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF818CF8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.curiosity,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFFD1D5DB),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF10142B),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFF20264A)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF9CA3AF),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
