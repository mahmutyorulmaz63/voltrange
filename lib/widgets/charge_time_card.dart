import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChargeTimeCard extends StatelessWidget {
  final double batteryLevel;

  const ChargeTimeCard({
    super.key,
    required this.batteryLevel,
  });

  int _calculateFullChargeMinutes() {
    if (batteryLevel >= 1.0) return 0;
    final remainingRatio = 1.0 - batteryLevel;
    return (remainingRatio * 120).round();
  }

  String _formatTime(int minutes) {
    if (minutes <= 0) return 'Tam Dolu';
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (hours > 0) {
      return '$hours sa $mins dk';
    }
    return '$mins dk';
  }

  @override
  Widget build(BuildContext context) {
    final remainingMinutes = _calculateFullChargeMinutes();
    final isFull = batteryLevel >= 1.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.access_time_filled,
                color: Color(0xFF38BDF8),
                size: 24,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tahmini Şarj Süresi',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '%100 dolum için kalan süre',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.white38,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isFull
                  ? const Color(0xFF10B981).withOpacity(0.2)
                  : const Color(0xFF38BDF8).withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _formatTime(remainingMinutes),
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isFull ? const Color(0xFF10B981) : const Color(0xFF38BDF8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}