import 'package:flutter/material.dart';
import '../models/astronomy_item.dart';
import '../services/astronomy_service.dart';
import '../widgets/astronomy_card.dart';
import 'details_screen.dart';

/// Tela de Catálogo/Explorar do Astrova.
///
/// Requisitos acadêmicos atendidos:
/// - Consumo da API REST através de AstronomyService (com async/await);
/// - Uso obrigatório de ListView (ListView.builder);
/// - Gerenciamento de estado nativo com setState();
/// - Filtro por categorias ("Todos", "Planetas", "Estrelas", "Galáxias");
/// - Busca em tempo real por nome/categoria;
/// - Tratamento de estados: Carregando, Erro e Sucesso;
/// - Navegação nativa para a tela de Detalhes via Navigator.push().
class ExploreScreen extends StatefulWidget {
  final String? initialCategory;

  const ExploreScreen({super.key, this.initialCategory});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // Instância do serviço que consome a API REST
  final AstronomyService _astronomyService = AstronomyService();

  // Controlador para o campo de texto da busca
  final TextEditingController _searchController = TextEditingController();

  // Lista com todos os itens retornados pela API
  List<AstronomyItem> _allItems = [];

  // Lista filtrada que será exibida no ListView
  List<AstronomyItem> _filteredItems = [];

  // Controle de carregamento e mensagens de erro
  bool _isLoading = true;
  String? _errorMessage;

  // Categoria atualmente selecionada no filtro
  String _selectedCategory = 'Todos';

  // Categorias disponíveis para filtragem
  final List<String> _categories = [
    'Todos',
    'Planetas',
    'Estrelas',
    'Galáxias',
  ];

  @override
  void initState() {
    super.initState();
    // Se recebeu uma categoria inicial da Home (ex: Planetas), utiliza-a
    if (widget.initialCategory != null) {
      _selectedCategory = widget.initialCategory!;
    }
    // Dispara a busca dos dados na API REST
    _fetchItems();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Busca os dados astronômicos através do serviço REST.
  ///
  /// Demonstra o uso de async/await, setState e tratamento de exceções.
  Future<void> _fetchItems() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // 1. Requisição assíncrona ao serviço REST
      final items = await _astronomyService.getAstronomyItems();

      // 2. Atualização do estado com os dados recebidos
      setState(() {
        _allItems = items;
        _isLoading = false;
        _applyFilters();
      });
    } catch (error) {
      // 3. Tratamento em caso de falha na comunicação
      setState(() {
        _errorMessage = 'Não foi possível carregar os dados astronômicos.';
        _isLoading = false;
      });
    }
  }

  /// Aplica a filtragem por categoria e pelo texto pesquisado pelo usuário.
  void _applyFilters() {
    final query = _searchController.text.trim().toLowerCase();

    setState(() {
      _filteredItems = _allItems.where((item) {
        // Filtro 1: Categoria
        final matchesCategory = _selectedCategory == 'Todos' ||
            item.category.toLowerCase() == _selectedCategory.toLowerCase();

        // Filtro 2: Texto de busca (pesquisa por nome ou categoria)
        final matchesQuery = query.isEmpty ||
            item.name.toLowerCase().contains(query) ||
            item.type.toLowerCase().contains(query) ||
            item.shortDescription.toLowerCase().contains(query);

        return matchesCategory && matchesQuery;
      }).toList();
    });
  }

  /// Seleciona uma nova categoria e reexecuta os filtros
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
            // =================================================================
            // CABEÇALHO DA TELA EXPLORAR
            // =================================================================
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tag superior "CATÁLOGO ASTRONÔMICO"
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

                  // Título principal
                  const Text(
                    'Explorar',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Subtítulo descritivo
                  const Text(
                    'Descubra mundos além do nosso.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFA0A5BD),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // ===========================================================
                  // CAMPO DE BUSCA
                  // ===========================================================
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

                  // ===========================================================
                  // FILTROS DE CATEGORIA (Pills/Chips)
                  // ===========================================================
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
                                      : const Color(0xFF20264A),
                                ),
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

                  // ===========================================================
                  // CONTADOR DE ITENS
                  // ===========================================================
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

            // =================================================================
            // LISTVIEW DE OBJETOS ASTRONÔMICOS OU ESTADOS (Loading/Erro/Vazio)
            // =================================================================
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  /// Constrói o corpo dinâmico da tela conforme o estado atual
  Widget _buildContent() {
    // 1. Estado de Carregamento
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

    // 2. Estado de Erro
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

    // 3. Estado de Busca Sem Resultados
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

    // 4. Estado de Sucesso: ListView.builder
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 20),
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        final item = _filteredItems[index];
        return AstronomyCard(
          item: item,
          onTap: () {
            // Navegação nativa simples para a tela de detalhes
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
