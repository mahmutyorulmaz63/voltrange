import 'battery_model.dart';

class Vehicle {
  final String id;
  final String name;
  final String macAddress;
  final int nominalVoltage;
  final double maxRangeKm;   
  BatteryData batteryData;

  Vehicle({
    required this.id,
    required this.name,
    required this.macAddress,
    this.nominalVoltage = 48,
    this.maxRangeKm = 26.0,
    required this.batteryData,
  });

  
  double calculateLevelFromVoltage(double voltage) {
    double minV = 39.0;
    double maxV = 54.6;

    if (nominalVoltage == 36) {
      minV = 30.0;
      maxV = 42.0;
    } else if (nominalVoltage == 48) {
      minV = 39.0;
      maxV = 54.6;
    } else if (nominalVoltage == 52) {
      minV = 42.0;
      maxV = 58.8;
    } else if (nominalVoltage == 60) {
      minV = 48.0;
      maxV = 67.2;
    }

    double level = (voltage - minV) / (maxV - minV);
    return level.clamp(0.0, 1.0);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'macAddress': macAddress,
      'nominalVoltage': nominalVoltage,
      'maxRangeKm': maxRangeKm,
      'batteryData': batteryData.toJson(),
    };
  }

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id']?.toString() ?? '1',
      name: json['name']?.toString() ?? 'Araç',
      macAddress: json['macAddress']?.toString() ?? '00:00:00:00:00',
      nominalVoltage: json['nominalVoltage'] != null 
          ? (json['nominalVoltage'] as num).toInt() 
          : 48, 
      maxRangeKm: json['maxRangeKm'] != null 
          ? (json['maxRangeKm'] as num).toDouble() 
          : 26.0,
      batteryData: BatteryData.fromJson(json['batteryData'] as Map<String, dynamic>),
    );
  }
}