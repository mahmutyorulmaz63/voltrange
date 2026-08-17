import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/vehicle_model.dart';

class TopBar extends StatelessWidget {
  final List<Vehicle> vehicles;
  final Vehicle selectedVehicle;
  final ValueChanged<Vehicle?> onVehicleChanged;
  final Color currentColor;

  const TopBar({
    super.key,
    required this.vehicles,
    required this.selectedVehicle,
    required this.onVehicleChanged,
    required this.currentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton<Vehicle>(
                  value: selectedVehicle,
                  dropdownColor: const Color(0xFF1E293B),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
                  items: vehicles.map((Vehicle vehicle) {
                    return DropdownMenuItem<Vehicle>(
                      value: vehicle,
                      child: Text(
                        vehicle.name,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: onVehicleChanged,
                ),
              ),
              Text(
                'MAC: ${selectedVehicle.macAddress}',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: currentColor.withAlpha(38),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: currentColor.withAlpha(128)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(radius: 4, backgroundColor: currentColor),
              const SizedBox(width: 6),
              Text(
                'CANLI',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: currentColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}