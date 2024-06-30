import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Visor extends StatefulWidget {
  final String entrada;

  const Visor({super.key, required this.entrada});

  @override
  State<Visor> createState() => _VisorState();
}

class _VisorState extends State<Visor> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.entrada,
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
