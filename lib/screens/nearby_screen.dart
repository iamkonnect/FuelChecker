import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import '../models/fuel_gas_station.dart';
import '../services/nearby_service.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../providers/theme_provider.dart';

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({Key? key}) : super(key: key);

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  int _selectedIndex = 3;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() => _currentPosition = position);
  }

  void _onNavigationItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);

    final routes = [
      '/fuel_map',
      '/favorites',
      '/analytics',
      '/nearby',
      '/settings'
    ];
    Navigator.pushReplacementNamed(context, routes[index]);
  }

  String _formatDistance(double distance) {
    return distance > 1000
        ? '${(distance / 1000).toStringAsFixed(2)} km'
        : '${distance.toStringAsFixed(0)} m';
  }

  @override
  Widget build(BuildContext context) {
    final nearbyService = Provider.of<NearbyService>(context);
    final theme = Provider.of<ThemeProvider>(context).currentTheme;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/fuel_map');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nearby Stations'),
          backgroundColor: theme.appBarTheme.backgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/fuel_map'),
          ),
        ),
        body: _buildBody(nearbyService, theme),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onNavigationItemTapped,
        ),
      ),
    );
  }

  Widget _buildBody(NearbyService nearbyService, ThemeData theme) {
    if (_currentPosition == null) {
      return Center(child: CircularProgressIndicator());
    }

    if (nearbyService.nearbyStations.isEmpty) {
      return _buildEmptyState(theme);
    }

    return RefreshIndicator(
      onRefresh: _getCurrentLocation,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: nearbyService.nearbyStations.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final station = nearbyService.nearbyStations[index];
          final distance = Geolocator.distanceBetween(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
            station.latitude,
            station.longitude,
          );
          return _buildStationCard(station, distance, theme);
        },
      ),
    );
  }

  Widget _buildStationCard(
      GasStation station, double distance, ThemeData theme) {
    final distance = _currentPosition != null
        ? Geolocator.distanceBetween(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
            station.latitude,
            station.longitude,
          )
        : 0.0;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStationHeader(station, theme),
            const SizedBox(height: 12),
            _buildPriceRow(station, theme),
            const SizedBox(height: 16),
            _buildActionRow(station, distance, theme),
            const SizedBox(height: 12),
            _buildOpeningHours(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildStationHeader(GasStation station, ThemeData theme) {
    return Row(
      children: [
        Image.asset(station.logoAsset, height: 32),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            station.name,
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(GasStation station, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildPriceChip('Blend', station.blendPrice, theme),
        _buildPriceChip('Diesel', station.dieselPrice, theme),
      ],
    );
  }

  Widget _buildPriceChip(String label, double price, ThemeData theme) {
    return Chip(
      backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
      label: Text(
        '$label: \$${price.toStringAsFixed(2)}',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionRow(GasStation station, double distance, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(
          icon: Icons.directions,
          label: 'Directions',
          color: theme.colorScheme.primary,
          onPressed: () => _navigateToDirections(station),
        ),
        _buildActionButton(
          icon: Icons.favorite_border,
          label: 'Favorite',
          color: theme.colorScheme.secondary,
          onPressed: () => _toggleFavorite(station),
        ),
        _buildActionButton(
          icon: Icons.report,
          label: 'Report',
          color: theme.colorScheme.error,
          onPressed: _showReportDialog,
        ),
        _buildDistanceBadge(distance, theme),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: color),
          onPressed: onPressed,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDistanceBadge(double distance, ThemeData theme) {
    return Chip(
      backgroundColor: theme.colorScheme.surface,
      label: Row(
        children: [
          Icon(Icons.location_on, size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: 4),
          Text(
            _formatDistance(distance),
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildOpeningHours(ThemeData theme) {
    return Row(
      children: [
        Icon(Icons.access_time, size: 16, color: theme.colorScheme.secondary),
        const SizedBox(width: 8),
        Text(
          'Open 24 Hours',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.secondary,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.local_gas_station,
              size: 64, color: theme.colorScheme.secondary),
          const SizedBox(height: 24),
          Text(
            'No Stations Nearby',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Adjust your search radius or move to a different location '
              'to find nearby gas stations.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleFavorite(GasStation station) {
    // Implement favorite logic
  }

  void _navigateToDirections(GasStation station) {
    // Implement directions logic
  }

  void _showReportDialog() {
    // Implement report dialog
  }
}
