import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AlertHelper {
  static String getTitle(bool isLow, bool isHigh) {
    if (isLow && isHigh) return 'DÜŞÜK ŞARJ VE YÜKSEK SICAKLIK';
    if (isLow) return 'KRİTİK ŞARJ SEVİYESİ';
    return 'YÜKSEK PİL SICAKLIĞI';
  }

  static String getMessage(bool isLow, bool isHigh, double level, double temp) {
    if (isLow && isHigh) return 'Akü seviyesi %20 altına düştü ve sıcaklık yüksek!';
    if (isLow) return 'Akü seviyesi %${(level * 100).round()}\'e düştü. Şarj edin.';
    return 'Pil sıcaklığı $temp°C! Lütfen cihazı soğumaya bırakın.';
  }
}
class AlertBanner extends StatelessWidget {
  final double batteryLevel;
  final double temperature;

  const AlertBanner({
    super.key,
    required this.batteryLevel,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLow = batteryLevel <= 0.20;
    final bool isHigh = temperature >= 40.0;

    if (!isLow && !isHigh) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.redAccent.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.redAccent.withAlpha(128)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AlertHelper.getTitle(isLow, isHigh),
                  style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.redAccent),
                ),
                Text(
                  AlertHelper.getMessage(isLow, isHigh, batteryLevel, temperature),
                  style: GoogleFonts.poppins(fontSize: 11, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}