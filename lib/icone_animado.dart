import 'package:flutter/material.dart';

class IconeAnimado extends StatefulWidget {
  const IconeAnimado({super.key});

  @override
  State<IconeAnimado> createState() => _IconeAnimadoState();
}

class _IconeAnimadoState extends State<IconeAnimado>
    with TickerProviderStateMixin {
  late AnimationController _controlador;
  late CurvedAnimation _animacao;

  double duracaoTransicao = 0.5;
  int get duracaoEmMilisegundos => (duracaoTransicao * 1000).toInt();

  bool estaTocando = false;

  @override
  void initState() {
    super.initState();

    _controlador = AnimationController(
      duration: Duration(milliseconds: duracaoEmMilisegundos),
      vsync: this,
    );

    _animacao = CurvedAnimation(
      parent: _controlador,
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ícone animado',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedIcon(
            color: Colors.orange,
            icon: AnimatedIcons.play_pause,
            progress: _animacao,
            size: 250,
          ),
          Column(
            children: [
              const Text(
                'DURAÇÃO DA TRANSIÇÃO',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                '$duracaoEmMilisegundos milisegundos',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              Slider.adaptive(
                value: duracaoTransicao,
                onChanged: (value) {
                  setState(() {
                    duracaoTransicao = value;
                    final duracao =
                        Duration(milliseconds: duracaoEmMilisegundos);
                    _controlador.duration = duracao;
                    _controlador.reverseDuration = duracao;
                  });
                },
                thumbColor: Colors.orange,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          if (estaTocando) {
            _controlador.reverse();
          } else {
            _controlador.forward();
          }
          setState(() {
            estaTocando = !estaTocando;
          });
        },
        child: AnimatedIcon(
          icon: AnimatedIcons.play_pause,
          progress: _animacao,
        ),
      ),
    );
  }
}
