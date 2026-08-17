import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConsumptionCard extends StatelessWidget {
  const ConsumptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withAlpha(13)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Haftalık Ortalama Tüketim',
            style: GoogleFonts.poppins(fontSize: 11, color: Colors.white54),
          ),
          const SizedBox(height: 6),
          Text(
            '4.2 kWh / Hafta',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}