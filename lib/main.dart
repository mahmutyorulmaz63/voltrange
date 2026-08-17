import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/battery_model.dart';
import 'models/vehicle_model.dart';
import 'screens/home_screen.dart';
import 'screens/analytics_screen.dart';
import 'screens/settings_screen.dart';
import 'widgets/splash_screen.dart';

void main() {
  runApp(const EVBatteryApp());
}

class EVBatteryApp extends StatelessWidget {
  const EVBatteryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VoltRange',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  bool _isLoading = true;

  List<Vehicle> _vehicles = [
    Vehicle(
      id: '1',
      name: 'Ola Bisiklet',
      macAddress: '24:0A:C4:00:01',
      nominalVoltage: 48,
      maxRangeKm: 26.0,
      batteryData: BatteryData(
        level: 0.75,
        voltage: 50.7,
        temperature: 28,
        healthPercentage: 98,
        chargeCycles: 45,
      ),
    ),
  ];

  late Vehicle _selectedVehicle;

  @override
  void initState() {
    super.initState();
    _selectedVehicle = _vehicles[0];
    _loadVehiclesFromStorage();
  }

  Future<void> _loadVehiclesFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? vehiclesJson = prefs.getString('saved_vehicles');

    if (vehiclesJson != null) {
      final List<dynamic> decodedList = jsonDecode(vehiclesJson);
      final List<Vehicle> loadedVehicles =
          decodedList.map((item) => Vehicle.fromJson(item)).toList();

      if (loadedVehicles.isNotEmpty) {
        setState(() {
          _vehicles = loadedVehicles;
          _selectedVehicle = _vehicles.first;
        });
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveVehiclesToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData =
        jsonEncode(_vehicles.map((v) => v.toJson()).toList());
    await prefs.setString('saved_vehicles', encodedData);
  }

  void _onVehicleChanged(Vehicle? newVehicle) {
    if (newVehicle != null) {
      setState(() {
        _selectedVehicle = newVehicle;
      });
    }
  }

  void _addNewVehicle(String name, String mac, int nominalVoltage, double maxRangeKm) {
    double initialVoltage = nominalVoltage == 36 ? 38.0 : (nominalVoltage == 48 ? 50.0 : 54.0);

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
    double calculatedLevel = ((initialVoltage - minV) / (maxV - minV)).clamp(0.0, 1.0);

    final newVehicle = Vehicle(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      macAddress: mac,
      nominalVoltage: nominalVoltage,
      maxRangeKm: maxRangeKm,
      batteryData: BatteryData(
        level: calculatedLevel,
        voltage: initialVoltage,
        temperature: 25,
        healthPercentage: 100,
        chargeCycles: 0,
      ),
    );

    setState(() {
      _vehicles.add(newVehicle);
      _selectedVehicle = newVehicle;
    });
    _saveVehiclesToStorage();
  }

  void _deleteVehicle(String id) {
    if (_vehicles.length <= 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('En az bir araç kayıtlı kalmalıdır!')),
      );
      return;
    }

    setState(() {
      _vehicles.removeWhere((v) => v.id == id);
      if (_selectedVehicle.id == id) {
        _selectedVehicle = _vehicles.first;
      }
    });
    _saveVehiclesToStorage();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const CustomSplashScreen();
    }

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            vehicles: _vehicles,
            selectedVehicle: _selectedVehicle,
            onVehicleChanged: _onVehicleChanged,
          ),
          AnalyticsScreen(batteryData: _selectedVehicle.batteryData),
          SettingsScreen(
            selectedVehicle: _selectedVehicle,
            onAddVehicle: _addNewVehicle,
            onDeleteVehicle: _deleteVehicle,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: const Color(0xFF1E293B),
        selectedItemColor: const Color(0xFF10B981),
        unselectedItemColor: Colors.white38,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: 'Analiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Ayarlar',
          ),
        ],
      ),
    );
  }
}