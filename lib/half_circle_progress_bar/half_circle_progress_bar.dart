import 'dart:math';

import 'package:flutter/material.dart';

class HalfCircleProgressBar extends StatelessWidget {
  const HalfCircleProgressBar({
    Key? key,
    required this.progress,
    required this.dotColor,
    required this.progressDotColor,
    this.dotRadius = _defaultDotRadius,
    this.startBarRadius = _defaultStartBarRadius,
    this.layers = _defaultLayers,
    this.layersSpacing = _defaultLayersSpacing,
    this.dotsSpacing = _defaultDotsSpacing,
  }) : super(key: key);

  final double progress;
  final double dotRadius;
  final double startBarRadius;
  final int layers;
  final double layersSpacing;
  final double dotsSpacing;
  final Color dotColor;
  final Color progressDotColor;

  static const _defaultDotRadius = 4.0;
  static const _defaultStartBarRadius = 68.0;
  static const _defaultLayers = 10;
  static const _defaultLayersSpacing = 1.0;
  static const _defaultDotsSpacing = 1.0;

  @override
  Widget build(BuildContext context) {
    final height = startBarRadius + (layersSpacing + dotRadius * 2) * layers;
    return ClipRect(
      child: CustomPaint(
        size: Size(height * 2, height),
        painter: _DiagramPainter(
          dotRadius: dotRadius,
          startBarRadius: startBarRadius,
          layers: layers,
          layersSpacing: layersSpacing,
          dotsSpacing: dotsSpacing,
          progress: progress,
          dotColor: dotColor,
          progressDotColor: progressDotColor,
        ),
      ),
    );
  }
}

class _DiagramPainter extends CustomPainter {
  _DiagramPainter({
    required this.dotRadius,
    required this.startBarRadius,
    required this.layers,
    required this.layersSpacing,
    required this.dotsSpacing,
    required this.progress,
    required Color dotColor,
    required Color progressDotColor,
  })  : _paint = Paint()
          ..color = dotColor
          ..style = PaintingStyle.fill,
        _progressPaint = Paint()
          ..color = progressDotColor
          ..style = PaintingStyle.fill,
        _dotDiameter = dotRadius * 2,
        _dotsSizeWithSpacing = dotRadius * 2 + dotsSpacing;

  final double dotRadius;
  final double startBarRadius;
  final int layers;
  final double layersSpacing;
  final double dotsSpacing;
  final double progress;

  final Paint _paint;
  final Paint _progressPaint;

  final double _dotDiameter;
  final double _dotsSizeWithSpacing;

  static const _startAngle = 270.0;
  static const _circle = 360.0;
  static const _halfCircle = 180.0;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.bottomCenter(Offset(0, -dotRadius));

    var radius = startBarRadius;

    for (var layer = 0; layer < layers; layer++) {
      final lengthOfHalfCircle = pi * radius;

      final dotsNumber = (lengthOfHalfCircle / _dotsSizeWithSpacing).floor();

      final angleStep = _halfCircle / (dotsNumber - 1);
      var angle = _startAngle;

      final progressItems = (dotsNumber * progress).toInt();

      for (var dot = 0; dot < dotsNumber; dot++) {
        final radian = pi * 2 * angle / _circle;

        canvas.drawCircle(
          Offset(
            radius * sin(radian) + center.dx,
            radius * cos(radian) + center.dy,
          ),
          dotRadius,
          dot < progressItems ? _progressPaint : _paint,
        );

        angle -= angleStep;
      }

      radius += _dotDiameter + layersSpacing;
    }
  }

  @override
  bool shouldRepaint(covariant _DiagramPainter oldDelegate) =>
      dotRadius != oldDelegate.dotRadius ||
      startBarRadius != oldDelegate.startBarRadius ||
      layers != oldDelegate.layers ||
      layersSpacing != oldDelegate.layersSpacing ||
      dotsSpacing != oldDelegate.dotsSpacing ||
      progress != oldDelegate.progress;
}
