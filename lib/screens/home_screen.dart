import 'package:flutter/material.dart';
import '../models/astronomy_item.dart';
import '../services/astronomy_service.dart';
import '../widgets/category_shortcut.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(String? category)? onNavigateToExplore;

  const HomeScreen({
    super.key,
    this.onNavigateToExplore,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //API
  final AstronomyService _astronomyService = AstronomyService();

  AstronomyItem? _apodItem;
  bool _isLoadingApod = true;

  @override
  void initState() {
    super.initState();
    // NASA APOD
    _loadNasaApod();
  }

  Future<void> _loadNasaApod() async {
    final item = await _astronomyService.getNasaApod();
    if (mounted) {
      setState(() {
        _apodItem = item;
        _isLoadingApod = false;
      });
    }
  }

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
                child: _isLoadingApod
                    ? const SizedBox(
                        height: 180,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF7B8CDE),
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _apodItem?.distance.toUpperCase() ??
                                    'FOTO DO DIA • NASA',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF8699FB),
                                  letterSpacing: 0.8,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF20264A),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'NASA APOD',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFC084FC),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (_apodItem?.imageUrl != null &&
                              _apodItem!.imageUrl.isNotEmpty) ...[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                height: 160,
                                width: double.infinity,
                                color: const Color(0xFF090A15),
                                child: Image.network(
                                  _apodItem!.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(
                                        Icons.image_not_supported_outlined,
                                        color: Color(0xFF7B8CDE),
                                        size: 36,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                          ],
                          Text(
                            _apodItem?.name ?? '',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _apodItem?.shortDescription ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFFA0A5BD),
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF7B8CDE),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(26),
                                ),
                              ),
                              onPressed: () {
                                if (_apodItem != null) {
                                  // Requisito: Navegação entre telas com Navigator.push
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                        item: _apodItem!,
                                      ),
                                    ),
                                  );
                                }
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
                      widget.onNavigateToExplore?.call(null);
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
              Row(
                children: [
                  CategoryShortcut(
                    title: 'Planetas',
                    icon: Icons.blur_circular,
                    iconColor: const Color(0xFF38BDF8),
                    onTap: () => widget.onNavigateToExplore?.call('Planetas'),
                  ),
                  CategoryShortcut(
                    title: 'Galáxias',
                    icon: Icons.auto_awesome,
                    iconColor: const Color(0xFFC084FC),
                    onTap: () => widget.onNavigateToExplore?.call('Galáxias'),
                  ),
                  CategoryShortcut(
                    title: 'Estrelas',
                    icon: Icons.star_border_rounded,
                    iconColor: const Color(0xFF67E8F9),
                    onTap: () => widget.onNavigateToExplore?.call('Estrelas'),
                  ),
                ],
              ),
              const SizedBox(height: 28),
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
