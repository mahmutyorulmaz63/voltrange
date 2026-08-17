import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HealthCard extends StatelessWidget {
  final int healthPercentage;

  const HealthCard({super.key, required this.healthPercentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF10B981).withAlpha(100)),
      ),
      child: Column(
        children: [
          Text(
            'AKÜ SAĞLIK SKORU',
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF10B981),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '%$healthPercentage',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          Text(
            'Mükemmel Durumda',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF10B981),
            ),
          ),
        ],
      ),
    );
  }
}