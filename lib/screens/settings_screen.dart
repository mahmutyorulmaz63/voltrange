import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/vehicle_model.dart';

class SettingsScreen extends StatefulWidget {
  final Vehicle selectedVehicle;
  final Function(String name, String mac, int nominalVoltage, double maxRangeKm) onAddVehicle;
  final Function(String id) onDeleteVehicle;

  const SettingsScreen({
    super.key,
    required this.selectedVehicle,
    required this.onAddVehicle,
    required this.onDeleteVehicle,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedThreshold = 20;
  bool _notificationsEnabled = true;
  bool _autoConnectBluetooth = true;

  void _showAddVehicleDialog() {
    final nameController = TextEditingController();
    final macController = TextEditingController();
    final rangeController = TextEditingController(text: '26');
    int selectedVoltage = 48; 

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          title: Text(
            'Yeni Araç Ekle',
            style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Araç Adı (örn: Elektrikli Bisiklet)',
                    labelStyle: TextStyle(color: Colors.white60),
                  ),
                ),
                const SizedBox(height: 12),
                
                
                DropdownButtonFormField<int>(
                  value: selectedVoltage,
                  dropdownColor: const Color(0xFF1E293B),
                  style: GoogleFonts.poppins(color: const Color(0xFF38BDF8), fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    labelText: 'Akü Voltaj Tipi',
                    labelStyle: TextStyle(color: Colors.white60),
                  ),
                  items: const [
                    DropdownMenuItem(value: 36, child: Text('36V Akü Sistemi')),
                    DropdownMenuItem(value: 48, child: Text('48V Akü Sistemi')),
                    DropdownMenuItem(value: 52, child: Text('52V Akü Sistemi')),
                    DropdownMenuItem(value: 60, child: Text('60V Akü Sistemi')),
                  ],
                  onChanged: (val) {
                    if (val != null) {
                      setDialogState(() => selectedVoltage = val);
                    }
                  },
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: rangeController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Tam Şarj Fabrika Menzili (KM)',
                    hintText: 'örn: 26',
                    labelStyle: TextStyle(color: Colors.white60),
                  ),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: macController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'MAC Adresi (örn: AA:BB:CC:DD:EE)',
                    labelStyle: TextStyle(color: Colors.white60),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal', style: TextStyle(color: Colors.white54)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
              ),
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  final double enteredRange = double.tryParse(rangeController.text) ?? 26.0;

                  widget.onAddVehicle(
                    nameController.text,
                    macController.text.isEmpty ? '00:11:22:33:44' : macController.text,
                    selectedVoltage,
                    enteredRange,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Ekle', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ayarlar & Tercihler',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white),
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
              
              _buildSectionHeader('AKTİF ARAÇ & YÖNETİM'),
              const SizedBox(height: 10),
              _buildCard(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.two_wheeler, color: Color(0xFF10B981)),
                      title: Text(
                        widget.selectedVehicle.name,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      subtitle: Text(
                        '${widget.selectedVehicle.nominalVoltage}V Sistem | Maks: ${widget.selectedVehicle.maxRangeKm.toInt()} KM',
                        style: GoogleFonts.poppins(fontSize: 11, color: Colors.white38),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                        onPressed: () => widget.onDeleteVehicle(widget.selectedVehicle.id),
                      ),
                    ),
                    const Divider(height: 1, color: Colors.white12),
                    ListTile(
                      leading: const Icon(Icons.add_circle_outline, color: Color(0xFF38BDF8)),
                      title: Text(
                        'Yeni Araç Ekle',
                        style: GoogleFonts.poppins(color: const Color(0xFF38BDF8), fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      onTap: _showAddVehicleDialog,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              _buildSectionHeader('BİLDİRİM & UYARI EŞİKLERİ'),
              const SizedBox(height: 10),
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SwitchListTile(
                      activeColor: const Color(0xFF10B981),
                      title: Text(
                        'Kritik Şarj Bildirimleri',
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
                      ),
                      subtitle: Text(
                        'Pil belirlediğin eşiğin altına inince uyar',
                        style: GoogleFonts.poppins(fontSize: 11, color: Colors.white38),
                      ),
                      value: _notificationsEnabled,
                      onChanged: (val) => setState(() => _notificationsEnabled = val),
                    ),
                    const Divider(height: 1, color: Colors.white12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kritik Şarj Eşiği',
                            style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: SegmentedButton<int>(
                              segments: const [
                                ButtonSegment(value: 15, label: Text('%15')),
                                ButtonSegment(value: 20, label: Text('%20')),
                                ButtonSegment(value: 25, label: Text('%25')),
                              ],
                              selected: {_selectedThreshold},
                              onSelectionChanged: (Set<int> newSelection) {
                                setState(() {
                                  _selectedThreshold = newSelection.first;
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.resolveWith<Color>(
                                  (states) {
                                    if (states.contains(WidgetState.selected)) {
                                      return Colors.redAccent.withOpacity(0.3);
                                    }
                                    return const Color(0xFF0F172A);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              _buildSectionHeader('DONANIM & BAĞLANTI (ESP32)'),
              const SizedBox(height: 10),
              _buildCard(
                child: SwitchListTile(
                  activeColor: const Color(0xFF38BDF8),
                  title: Text(
                    'Otomatik Bluetooth Bağlantısı',
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
                  ),
                  subtitle: Text(
                    'Yakındaki ESP32 cihazına otomatik bağlan',
                    style: GoogleFonts.poppins(fontSize: 11, color: Colors.white38),
                  ),
                  value: _autoConnectBluetooth,
                  onChanged: (val) => setState(() => _autoConnectBluetooth = val),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white38,
        letterSpacing: 1.1,
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}