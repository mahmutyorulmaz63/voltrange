import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TestButtons extends StatelessWidget {
  final ValueChanged<double> onBatteryChanged;

  const TestButtons({
    super.key,
    required this.onBatteryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Simülasyon Test Butonları',
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.white38,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton('%100', 1.0, const Color(0xFF10B981)),
            _buildButton('%45', 0.45, Colors.amber),
            _buildButton('%20', 0.20, Colors.redAccent), // 🔴 %12 yerine %20 yapıldı
          ],
        ),
      ],
    );
  }

  Widget _buildButton(String label, double value, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: color.withOpacity(0.5)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          onPressed: () => onBatteryChanged(value),
          child: Text(
            label,
            style: GoogleFonts.poppins(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}