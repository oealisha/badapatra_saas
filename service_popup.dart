import 'package:flutter/material.dart';

class ServicePopup extends StatelessWidget {
  final Map<String, String> service;
  final VoidCallback onClose;

  const ServicePopup({super.key, required this.service, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Service Details - ID ${service['ID No']}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            _buildDetailRow('Service Type', service['Service Type']!),
            _buildDetailRow(
              'Service Requirement',
              service['Service Requirement']!,
            ),
            _buildDetailRow('Price', service['Price']!),
            _buildDetailRow('Time', service['Time']!),
            _buildDetailRow('Service Branch', service['Service Branch']!),
            _buildDetailRow('Comments', service['Comment Section']!),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: onClose, child: const Text('Close')),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text('$title: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
