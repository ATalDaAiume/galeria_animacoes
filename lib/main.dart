import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const GaleriaAnimacoesApp());
}

// REQUISITO 4
class GaleriaAnimacoesApp extends StatelessWidget {
  const GaleriaAnimacoesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removedor da faixa debug
      title: 'Galeria de Animações',
      theme: ThemeData(
        useMaterial3: true, // Habilitando M3
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const TelaGaleria(),
    );
  }
}

// TELA PRINCIPAL
class TelaGaleria extends StatelessWidget {
  const TelaGaleria({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeria de Produtos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          // REQUISITO 5
          ProdutoCard(
            id: '1',
            titulo: 'Tênis Esportivo',
            corBase: Colors.blue,
            icone: Icons.directions_run,
          ),
          SizedBox(height: 16),
          ProdutoCard(
            id: '2',
            titulo: 'Mochila Casual',
            corBase: Colors.orange,
            icone: Icons.backpack,
          ),
          SizedBox(height: 16),
          ProdutoCard(
            id: '3',
            titulo: 'Relógio Smart',
            corBase: Colors.green,
            icone: Icons.watch,
          ),
        ],
      ),
    );
  }
}

// REQUISITO 5
class ProdutoCard extends StatefulWidget {
  final String id;
  final String titulo;
  final Color corBase;
  final IconData icone;

  // Recebe parâmetros e possui const constructor
  const ProdutoCard({
    super.key,
    required this.id,
    required this.titulo,
    required this.corBase,
    required this.icone,
  });

  @override
  State<ProdutoCard> createState() => _ProdutoCardState();
}

class _ProdutoCardState extends State<ProdutoCard> {
  bool _expandido = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Altera o estado para acionar a animação implícita
        setState(() {
          _expandido = !_expandido;
        });
      },
      onLongPress: () {
        // Navega para a tela de detalhes para a animação Hero
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TelaDetalhes(
              id: widget.id,
              titulo: widget.titulo,
              corBase: widget.corBase,
              icone: widget.icone,
            ),
          ),
        );
      },
      // REQUISITO 1
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300), // Duração
        curve: Curves.easeInOut, // Curva para movimento natural
        height: _expandido ? 180 : 120, // Mudança de tamanho
        decoration: BoxDecoration(
          color: widget.corBase.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: widget.corBase,
            width: _expandido ? 4 : 2, // Mudança na borda
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // REQUISITO 3
            Hero(
              tag: 'hero-icon-${widget.id}', // Tag única
              child: Icon(widget.icone, size: 60, color: widget.corBase),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.titulo,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _expandido ? 'Pressione e segure para detalhes' : 'Toque para expandir',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TELA DE DETALHES
class TelaDetalhes extends StatefulWidget {
  final String id;
  final String titulo;
  final Color corBase;
  final IconData icone;

  const TelaDetalhes({
    super.key,
    required this.id,
    required this.titulo,
    required this.corBase,
    required this.icone,
  });

  @override
  State<TelaDetalhes> createState() => _TelaDetalhesState();
}

// SingleTickerProviderStateMixin necessário para a animação explícita
class _TelaDetalhesState extends State<TelaDetalhes> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animacao;

  @override
  void initState() {
    super.initState();
    // REQUISITO 2
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true); // Loop da animação

    final curva = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut, // Movimento natural
    );

    _animacao = Tween<double>(begin: 0.8, end: 1.2).animate(curva);
  }

  @override
  void dispose() {
    _controller.dispose(); // REQUISITO 2
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.titulo)),
      body: Stack(
        children: [
          // REQUISITO BÔNUS: CustomPainter
          Positioned.fill(
            child: CustomPaint(
              painter: FundoGeometricoPainter(widget.corBase),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // REQUISITO 3
                Hero(
                  tag: 'hero-icon-${widget.id}', // Tag idêntica à tela de origem
                  child: Material(
                    color: Colors.transparent,
                    child: Icon(widget.icone, size: 150, color: widget.corBase),
                  ),
                ),
                const SizedBox(height: 40),
                
                // REQUISITO 2
                AnimatedBuilder(
                  animation: _animacao,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animacao.value,
                      child: child,
                    );
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 40),
                      Text(
                        ' SUPER OFERTA!',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                
                // Uso de componente Material Design 3
                FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Voltar para Galeria'),
                  style: FilledButton.styleFrom(
                    backgroundColor: widget.corBase,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// REQUISITO BÔNUS
class FundoGeometricoPainter extends CustomPainter {
  final Color cor;

  FundoGeometricoPainter(this.cor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = cor.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Desenhando dois círculos decorativos gigantes no fundo
    final centro1 = Offset(size.width * 0.1, size.height * 0.2);
    final centro2 = Offset(size.width * 0.9, size.height * 0.8);

    canvas.drawCircle(centro1, 150, paint);
    canvas.drawCircle(centro2, 200, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false; // Implementado corretamente
}