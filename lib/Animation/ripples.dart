import 'package:flutter/material.dart';

import 'circle_painter.dart';
import 'curve_waves.dart';
class RippleAnimation extends StatefulWidget {
  RippleAnimation({this.size = 70, this.color = Colors.redAccent});
  final double size;
  final Color color;
  @override
  _RippleAnimationState createState() => _RippleAnimationState(size: size, color: color);
}

class _RippleAnimationState extends State<RippleAnimation> with TickerProviderStateMixin{
  _RippleAnimationState({required this.size, required this.color});
  final double size;
  final Color color;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _ripples(){
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.size),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: <Color>[
                widget.color,
                //Color.fromRGBO(200, 220, 120, 100),
                Color.fromRGBO(0,150,139,1)
              ],
            ),
          ),
          child: ScaleTransition(
              scale: Tween(begin: 0.85, end: 0.95).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: const CurveWave(),
                ),
              ),
              child: SizedBox(
                child: Image.asset(
                  "assets/logo.png",
                ),
              )
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(
        _controller,
        color: widget.color,
      ),
      child: SizedBox(
        width: widget.size * 4.125,
        height: widget.size * 4.125,
        child: _ripples(),
      ),
    );

  }
}
