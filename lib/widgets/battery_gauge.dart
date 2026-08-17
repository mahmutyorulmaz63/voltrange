import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BatteryGauge extends StatelessWidget {
  final double level;
  final int percentageInt;
  final Color currentColor;

  const BatteryGauge({
    super.key,
    required this.level,
    required this.percentageInt,
    required this.currentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // DIŞ HALKA (ŞARJ GÖSTERGESİ)
          SizedBox(
            width: 220,
            height: 220,
            child: CircularProgressIndicator(
              value: level,
              strokeWidth: 16,
              backgroundColor: Colors.white10,
              color: currentColor,
            ),
          ),

          
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.electric_scooter,
                color: currentColor,
                size: 32,
              ),
              const SizedBox(height: 8),
              
              Text(
                '%$percentageInt',
                style: GoogleFonts.poppins(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              
              Text(
                'Batarya Seviyesi',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}