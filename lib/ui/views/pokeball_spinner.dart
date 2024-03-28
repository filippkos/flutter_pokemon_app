import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/gen/assets.gen.dart';

class PokeballSpinner extends StatefulWidget {
  const PokeballSpinner({super.key});

  @override
  State<PokeballSpinner> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PokeballSpinner>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _rotation = Tween<double>(begin: 0.0, end: 6.28).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _controller.repeat();

    return AnimatedBuilder(
      animation: _controller, 
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotation.value,
          child: Pokeball(),
        );
      }
    );
  }
}

class Pokeball extends StatelessWidget {
  const Pokeball({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      child: Assets.images.spinner.spinner.image(),
    );
  }
}