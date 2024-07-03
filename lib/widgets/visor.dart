import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Visor extends StatelessWidget {
  final String entrada;

  const Visor({super.key, required this.entrada});

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
                  entrada,
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
