import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bada_patra_task/l10n/app_localizations.dart';

class ServiceTable extends StatefulWidget {
  final List<Map<String, String>> services;
  final Function(int) onRowTap;

  const ServiceTable({required this.services, required this.onRowTap, Key? key})
    : super(key: key);

  @override
  _ServiceTableState createState() => _ServiceTableState();
}

class _ServiceTableState extends State<ServiceTable> {
  final ScrollController _tableController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Table header
        Container(
          width: double.infinity,
          height: 60,
          padding: const EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 221, 37, 24),
            border: Border.all(color: Colors.white),
          ),
          child: Row(
            children: [
              _buildHeaderCell(AppLocalizations.of(context)!.idNo),
              _buildHeaderCell(AppLocalizations.of(context)!.serviceType),
              _buildHeaderCell(
                AppLocalizations.of(context)!.serviceRequirement,
              ),
              _buildHeaderCell(AppLocalizations.of(context)!.price),
              _buildHeaderCell(AppLocalizations.of(context)!.time),
              _buildHeaderCell(AppLocalizations.of(context)!.serviceBranch),
              _buildHeaderCell(AppLocalizations.of(context)!.commentSection),
            ],
          ),
        ),

        // Table body
        Container(
          height: 400,
          child: ListView.builder(
            controller: _tableController,
            itemCount: widget.services.length,
            itemBuilder: (context, index) {
              final service = widget.services[index];
              return GestureDetector(
                onTap: () => widget.onRowTap(int.parse(service['ID No']!)),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: index % 2 == 0 ? Colors.grey[100] : Colors.white,
                  ),
                  child: Row(
                    children: [
                      _buildDataCell(service['ID No']!),
                      _buildDataCell(service['Service Type']!),
                      _buildDataCell(service['Service Requirement']!),
                      _buildDataCell(service['Price']!),
                      _buildDataCell(service['Time']!),
                      _buildDataCell(service['Service Branch']!),
                      _buildDataCell(service['Comment Section']!),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderCell(String text) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),
    );
  }

  Widget _buildDataCell(String text) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tableController.dispose();
    super.dispose();
  }
}
