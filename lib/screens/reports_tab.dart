import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:file_picker/file_picker.dart';

class ReportsTab extends StatefulWidget {
  const ReportsTab({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ReportsTabState createState() => _ReportsTabState();
}

class _ReportsTabState extends State<ReportsTab> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final Map<String, List<FlSpot>> _dataSets = {
    'Weekly': List.generate(7, (i) => FlSpot(i.toDouble(), (i + 1) * 2.0)),
    'Monthly': List.generate(30, (i) => FlSpot(i.toDouble(), ((i % 7) + 1) * 1.5)),
    'Annual': List.generate(12, (i) => FlSpot(i.toDouble(), (i + 2) * 3.0)),
  };
  bool _uploading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  Future<void> _pickAndUpload() async {
    setState(() => _uploading = true);
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'jpg', 'png']);
    await Future.delayed(const Duration(seconds: 1)); // simulate upload
    if (result != null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Uploaded: ${result.files.single.name}')),
      );
    }
    setState(() => _uploading = false);
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        backgroundColor: const Color(0xFF8A3FFC),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: const Color(0xFF8A3FFC),
              unselectedLabelColor: Colors.grey,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(width: 4.0, color: Color(0xFF8A3FFC)),
                insets: EdgeInsets.symmetric(horizontal: 24.0),
              ),
              tabs: const [Tab(text: 'Weekly'), Tab(text: 'Monthly'), Tab(text: 'Annual')],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _dataSets.keys.map((period) => _buildPeriodView(period)).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickAndUpload,
        backgroundColor: const Color(0xFF8A3FFC),
        child: _uploading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.upload_file),
      ),
    );
  }

  Widget _buildPeriodView(String period) {
    final spots = _dataSets[period]!;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: ListView(
        key: ValueKey(period),
        padding: const EdgeInsets.all(16),
        children: [
          _buildChartCard(period, spots),
          const SizedBox(height: 24),
          _buildSectionTitle('$period Summary'),
          _buildSummaryItem('Avg Heart Rate', '76 bpm'),
          _buildSummaryItem('Avg Steps', '5,200'),
          _buildSummaryItem('Mood Swings', '3 events'),
          _buildSummaryItem('Pain Days', '2 days'),
        ],
      ),
    );
  }

  Widget _buildChartCard(String period, List<FlSpot> spots) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$period Vitals', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2B0A3D))),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: true, drawVerticalLine: false),
                  titlesData: const FlTitlesData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      barWidth: 3,
                      color: const Color(0xFF8A3FFC),
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(show: true, color: const Color(0xFF8A3FFC).withOpacity(0.2)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2B0A3D))),
    );
  }

  Widget _buildSummaryItem(String title, String value) {
    return ListTile(
      leading: const Icon(Icons.check_circle_outline, color: Color(0xFF8A3FFC)),
      title: Text(title),
      trailing: Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
