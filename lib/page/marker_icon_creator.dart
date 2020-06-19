import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerIconCreator {
  Future<BitmapDescriptor> create(int num, Color tagColor) async {
    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: num.toString(),
      style: TextStyle(fontSize: 32.0, color: Colors.white),
    );
    textPainter.layout();

    final padding = 32.0;

    print('MarkerIconCreator: textSize=${textPainter.size}');
    final size = Size(
        textPainter.size.width + padding, textPainter.size.width + padding);

    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);

    final radius = Radius.circular(size.width / 2);

    final Paint shadowPaint = Paint()..color = tagColor;

    canvas.drawRRect(
        RRect.fromRectAndCorners(Rect.fromLTWH(0, 0, size.width, size.height),
            topLeft: radius,
            topRight: radius,
            bottomLeft: radius,
            bottomRight: radius),
        shadowPaint);

    textPainter.paint(
        canvas, Offset(padding / 2, (size.height / 2) - (textPainter.height / 2)));

    final markerAsImage = await pictureRecorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());
    final bytes =
        await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final uint8list = bytes.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8list);
  }
}
