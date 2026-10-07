import 'package:flutter/material.dart';
import '../models/astronomy_item.dart';
import '../services/astronomy_service.dart';
import '../widgets/astronomy_card.dart';
import 'details_screen.dart';

// Requisitos acadêmicos atendidos:
// - Consumo da API REST através de AstronomyService (com async/await)
// - Uso obrigatório de ListView (ListView.builder)
// - Gerenciamento de estado nativo com setState()
// - Filtro por categorias e busca em tempo real
// - Tratamento de estados: Carregando, Erro e Sucesso
// - Navegação nativa para a tela de Detalhes via Navigator.push()
class ExploreScreen extends StatefulWidget {
  final String? initialCategory;

  const ExploreScreen({super.key, this.initialCategory});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // Requisito: Consumo de API REST - Instância do serviço da API
  final AstronomyService _astronomyService = AstronomyService();

  final TextEditingController _searchController = TextEditingController();
  List<AstronomyItem> _allItems = [];
  List<AstronomyItem> _filteredItems = [];
  bool _isLoading = true;
  String? _errorMessage;
  String _selectedCategory = 'Todos';

  final List<String> _categories = [
    'Todos',
    'Planetas',
    'Estrelas',
    'Galáxias',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialCategory != null) {
      _selectedCategory = widget.initialCategory!;
    }
    // Requisito: Consumo de API REST - Chamada para buscar dados da API
    _fetchItems();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Requisito: Consumo de API REST com async/await e setState
  Future<void> _fetchItems() async {
    // Requisito: Gerenciamento de estado nativo com setState (Carregando)
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Requisito: Consumo de API REST - Requisição assíncrona ao serviço REST
      final items = await _astronomyService.getAstronomyItems();

      // Requisito: Gerenciamento de estado nativo com setState (Sucesso)
      setState(() {
        _allItems = items;
        _isLoading = false;
        _applyFilters();
      });
    } catch (error) {
      // Requisito: Tratamento de erros na comunicação com a API
      setState(() {
        _errorMessage = 'Não foi possível carregar os dados astronômicos.';
        _isLoading = false;
      });
    }
  }

  // Requisito: Filtro por categorias e busca em tempo real
  void _applyFilters() {
    final query = _searchController.text.trim().toLowerCase();

    setState(() {
      _filteredItems = _allItems.where((item) {
        final matchesCategory = _selectedCategory == 'Todos' ||
            item.category.toLowerCase() == _selectedCategory.toLowerCase();

        final matchesQuery = query.isEmpty ||
            item.name.toLowerCase().contains(query) ||
            item.type.toLowerCase().contains(query) ||
            item.shortDescription.toLowerCase().contains(query);

        return matchesCategory && matchesQuery;
      }).toList();
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      _applyFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090A15),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CATÁLOGO ASTRONÔMICO',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF7B8CDE),
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Explorar',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Descubra mundos além do nosso.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFA0A5BD),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF0E1225),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFF1F243E),
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (_) => _applyFilters(),
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Pesquisar no universo...',
                        hintStyle: TextStyle(
                          color: Color(0xFF7A829E),
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xFF7A829E),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _categories.map((category) {
                        final isSelected = _selectedCategory == category;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () => _onCategorySelected(category),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF7B8CDE)
                                    : const Color(0xFF10142B),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFF7B8CDE)
                                        : const Color(0xFF20264A)),
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF9CA3AF),
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 14),
                  if (!_isLoading && _errorMessage == null)
                    Text(
                      '${_filteredItems.length} objetos encontrados',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF8C93AE),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    // Requisito: Tratamento de estado - Carregamento
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Color(0xFF7B8CDE),
            ),
            SizedBox(height: 16),
            Text(
              'Carregando dados astronômicos...',
              style: TextStyle(color: Color(0xFF8C93AE)),
            ),
          ],
        ),
      );
    }

    // Requisito: Tratamento de estado - Erro
    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.redAccent,
                size: 48,
              ),
              const SizedBox(height: 12),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _fetchItems,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7B8CDE),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.refresh),
                label: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      );
    }

    // Requisito: Tratamento de estado - Busca sem resultados
    if (_filteredItems.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                color: Color(0xFF7A829E),
                size: 48,
              ),
              SizedBox(height: 12),
              Text(
                'Nenhum objeto encontrado',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Tente alterar os termos da busca ou a categoria.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF8C93AE)),
              ),
            ],
          ),
        ),
      );
    }

    // Requisito: Exibição de itens com ListView (ListView.builder)
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 20),
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        final item = _filteredItems[index];
        return AstronomyCard(
          item: item,
          onTap: () {
            // Requisito: Navegação entre telas com Navigator.push
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(item: item),
              ),
            );
          },
        );
      },
    );
  }
}
