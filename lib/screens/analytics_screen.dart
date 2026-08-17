import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/battery_model.dart';

class AnalyticsScreen extends StatelessWidget {
  final BatteryData batteryData;

  const AnalyticsScreen({
    super.key,
    required this.batteryData,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E293B) : const Color(0xFF334155);
    final borderColor = isDark ? Colors.white10 : const Color(0xFF475569);
    const textColor = Color(0xFFF8FAFC);
    const subtitleColor = Color(0xFF94A3B8);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pil Analizi & Sağlık',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: textColor),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              _buildHealthOverviewCard(cardColor, borderColor, textColor, subtitleColor),
              const SizedBox(height: 24),

              
              Text(
                'DETAYLI METRİKLER',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: subtitleColor,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Sıcaklık',
                      value: '${batteryData.temperature} °C',
                      subtitle: batteryData.temperature > 40 ? 'Yüksek' : 'Normal',
                      icon: Icons.thermostat,
                      iconColor: batteryData.temperature > 40 ? Colors.redAccent : Colors.orange,
                      cardColor: cardColor,
                      borderColor: borderColor,
                      textColor: textColor,
                      subtitleColor: subtitleColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Şarj Döngüsü',
                      value: '${batteryData.chargeCycles}',
                      subtitle: 'Toplam Tam Dolum',
                      icon: Icons.autorenew,
                      iconColor: const Color(0xFF38BDF8),
                      cardColor: cardColor,
                      borderColor: borderColor,
                      textColor: textColor,
                      subtitleColor: subtitleColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Anlık Voltaj',
                      value: '${batteryData.voltage.toStringAsFixed(1)} V',
                      subtitle: 'Stabil Akım',
                      icon: Icons.bolt,
                      iconColor: Colors.amber,
                      cardColor: cardColor,
                      borderColor: borderColor,
                      textColor: textColor,
                      subtitleColor: subtitleColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Hücre Durumu',
                      value: 'Dengeli',
                      subtitle: 'BMS Kontrolü OK',
                      icon: Icons.verified_user_outlined,
                      iconColor: const Color(0xFF10B981),
                      cardColor: cardColor,
                      borderColor: borderColor,
                      textColor: textColor,
                      subtitleColor: subtitleColor,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              
              _buildRecommendationCard(cardColor, borderColor, textColor, subtitleColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHealthOverviewCard(Color cardColor, Color borderColor, Color textColor, Color subtitleColor) {
    final health = batteryData.healthPercentage;
    final Color healthColor = health > 85
        ? const Color(0xFF10B981)
        : (health > 70 ? Colors.amber : Colors.redAccent);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: healthColor.withOpacity(0.5), width: 1.5),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: health / 100,
                  strokeWidth: 8,
                  backgroundColor: Colors.white10,
                  valueColor: AlwaysStoppedAnimation<Color>(healthColor),
                ),
              ),
              Text(
                '%$health',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Batarya Sağlığı (SOH)',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  health > 85
                      ? 'Akü kondisyonu mükemmel durumda.'
                      : 'Akü performansı zamanla hafif düşmüş.',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: subtitleColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color cardColor,
    required Color borderColor,
    required Color textColor,
    required Color subtitleColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: iconColor, size: 24),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: iconColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: subtitleColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(Color cardColor, Color borderColor, Color textColor, Color subtitleColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF38BDF8).withOpacity(0.4)),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline, color: Color(0xFF38BDF8), size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Uzun Ömürlü İpucu',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF38BDF8),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Lityum bataryayı %20-%80 arasında tutmak pil ömrünü 2 katına çıkarır.',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: subtitleColor,
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