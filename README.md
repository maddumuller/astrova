# 🪐  Astrova 

<div align="center">

  <p align="center">
    <strong>Aplicativo mobile em Flutter para visualização, pesquisa e exploração de dados do cosmos.</strong><br />
    Desenvolvido para a disciplina de <em>Desenvolvimento para Dispositivos Móveis (DDM)</em>.
  </p>

</div>

---

## 🌌 Sobre o Projeto

O Astrova é um aplicativo mobile que conecta entusiastas do espaço a dados científicos reais do universo. Ele combina a API oficial da NASA para exibir a Imagem Astronômica do Dia (*APOD*) com um catálogo interativo de corpos celestes (planetas, estrelas e galáxias), tudo envolvido em uma interface moderna com tema espacial (*Cosmic Dark*).

---

## ✨ Funcionalidades Principais

### 1. Tela Inicial (Home)
- **NASA APOD Diária:** Integração direta com a API da NASA exibindo a imagem do dia, data oficial e explicação científica.
- **Atalhos Rápidos:** Acesso direto a categorias celestes (*Planetas*, *Galáxias* e *Estrelas*).
- **Curiosidade Cósmica:** Destaque educativo rotativo com fatos sobre o universo.

###  2. Explorar (Catálogo Cósmico)
- **Consumo de API REST:** Carregamento dinâmico e assíncrono dos objetos celestes em formato JSON.
- **Lista Fluida (`ListView.builder`):** Exibição otimizada com cards personalizados, miniatura de imagens e dados rápidos.
- **Busca em Tempo Real:** Pesquisa instantânea por nome, tipo ou descrição.
- **Filtros por Categoria:** Navegação dinâmica por chips (*Todos*, *Planetas*, *Estrelas*, *Galáxias*).
- **Tratamento de Estados:** Telas e indicadores visuais para *Carregando*, *Erro com botão de tentar novamente* e *Nenhum resultado encontrado*.

###  3. Detalhes do Objeto
- **Visualização Imersiva:** Fotografia em alta resolução com tratamento de falhas e loading progressivo.
- **Dados Técnicos:** Cards destacados com métricas astronômicas (distância da Terra, diâmetro e tipo cósmico).
- **Curiosidade Científica:** Fatos específicos sobre o objeto selecionado.
- **Navegação Nativa:** Retorno intuitivo com suporte à pilha de rotas (`Navigator.pop`).

###  4. Sobre o Projeto
- Ficha técnica do aplicativo com identificação acadêmica da disciplina.
- Lista interativa de tecnologias utilizadas e checklist visual dos requisitos cumpridos.

---

## 🛰️ APIs Integradas

| API | Descrição | Formato |
| :--- | :--- | :--- |
| **NASA APOD** | Foto Astronômica do Dia oficial fornecida pela NASA | REST / JSON |
| **Astrova Catalog API** | Catálogo com objetos do Sistema Solar, galáxias e estrelas | REST / JSON |


## 📁 Estrutura de Pastas

```text
astrova/
├── assets/
│   ├── data/
│   │   └── astronomy_items.json      # Base de dados JSON local/fallback
│   └── images/                       # Imagens estáticas e recursos visuais
├── lib/
│   ├── models/
│   │   └── astronomy_item.dart       # Modelo de dados AstronomyItem e conversão JSON
│   ├── screens/
│   │   ├── about_screen.dart         # Tela Sobre e requisitos acadêmicos
│   │   ├── details_screen.dart       # Tela de detalhes astronômicos
│   │   ├── explore_screen.dart       # Catálogo, busca, filtros e ListView
│   │   └── home_screen.dart          # Destaque NASA APOD e atalhos da Home
│   ├── services/
│   │   └── astronomy_service.dart    # Consumo das APIs REST (NASA e Catálogo)
│   ├── widgets/
│   │   ├── astronomy_card.dart       # Card de item celeste para ListView
│   │   └── category_shortcut.dart    # Card de atalho de categoria
│   └── main.dart                     # Entrada principal, temas e BottomNavigationBar
├── pubspec.yaml                      # Dependências e configuração de assets
└── README.md                         # Documentação do projeto
```

---

##  Como Executar o Projeto

### Pré-requisitos
- [Flutter SDK](https://flutter.dev/docs/get-started/install) instalado (versão `>= 3.13.2`).
- Dispositivo físico conectado (Android/iOS) ou emulador configurado.

### Passo a Passo

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/maddumuller/astrova.git
   cd astrova
   ```

2. **Instale as dependências:**
   ```bash
   flutter pub get
   ```

3. **Execute o aplicativo:**
   ```bash
   flutter run
   ```

---

---

<div align="center">
  <sub>Desenvolvido com 💙 em Flutter para a disciplina de Desenvolvimento para Dispositivos Móveis.</sub>
</div>
