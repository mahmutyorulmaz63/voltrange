import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickStatusCard extends StatelessWidget {
  final double batteryLevel;

  const QuickStatusCard({
    super.key,
    required this.batteryLevel,
  });

  Map<String, dynamic> _getStatusInfo() {
    if (batteryLevel >= 0.50) {
      return {
        'title': 'Sürüşe Hazır',
        'subtitle': 'Uzun mesafe ve günlük turlar için ideal.',
        'icon': Icons.check_circle_outline,
        'color': const Color(0xFF10B981),
      };
    } else if (batteryLevel >= 0.20) {
      return {
        'title': 'Şehir İçi Kullanım',
        'subtitle': 'Kısa mesafeli sürüşler için yeterli seviye.',
        'icon': Icons.info_outline,
        'color': Colors.amber,
      };
    } else {
      return {
        'title': 'Kritik Şarj',
        'subtitle': 'Yola çıkmadan önce mutlaka şarja takın!',
        'icon': Icons.warning_amber_rounded,
        'color': Colors.redAccent,
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = _getStatusInfo();
    final Color color = status['color'];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              status['icon'],
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status['title'],
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  status['subtitle'],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}