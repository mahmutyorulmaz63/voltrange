class BatteryData {
  final double level; 
  final double voltage; 
  final double temperature; 
  final int healthPercentage; 
  final int chargeCycles; 

  BatteryData({
    required this.level,
    required this.voltage,
    required this.temperature,
    required this.healthPercentage,
    required this.chargeCycles,
  });

  
  int get percentageInt => (level * 100).round();

  // Ortalama menzil hesabı (100% şarj = ~45 km varsayımıyla)
  int get estimatedRange => (level * 45).round();

  
  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'voltage': voltage,
      'temperature': temperature,
      'healthPercentage': healthPercentage,
      'chargeCycles': chargeCycles,
    };
  }

  
  factory BatteryData.fromJson(Map<String, dynamic> json) {
    return BatteryData(
      level: (json['level'] as num).toDouble(),
      voltage: (json['voltage'] as num).toDouble(),
      temperature: (json['temperature'] as num).toDouble(),
      healthPercentage: json['healthPercentage'] as int,
      chargeCycles: json['chargeCycles'] as int,
    );
  }
}