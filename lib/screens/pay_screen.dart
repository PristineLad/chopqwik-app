import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({super.key, this.initialService, this.onInitialServiceConsumed});
  final String? initialService;
  final VoidCallback? onInitialServiceConsumed;

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerController = TextEditingController();
  final _amountController = TextEditingController();
  String? _selectedService;
  String? _selectedNetwork;
  String? _selectedMeterType;

  static const _services = <String, IconData>{
    'Airtime': Icons.phone_android_rounded,
    'Mobile data': Icons.language_rounded,
    'Electricity': Icons.bolt_rounded,
    'Cable TV': Icons.live_tv_rounded,
  };
  static const _networks = ['MTN', 'Airtel', 'Glo', '9mobile'];

  @override
  void initState() {
    super.initState();
    _selectedService = widget.initialService;
    if (_selectedService != null) widget.onInitialServiceConsumed?.call();
  }

  @override
  void didUpdateWidget(covariant PayScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialService != null && widget.initialService != oldWidget.initialService) {
      _selectService(widget.initialService!);
      widget.onInitialServiceConsumed?.call();
    }
  }

  @override
  void dispose() {
    _customerController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _selectService(String service) {
    setState(() {
      _selectedService = service;
      _selectedNetwork = null;
      _selectedMeterType = null;
      _customerController.clear();
      _amountController.clear();
    });
  }

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 22, 20, 32),
    children: [
      const Text('Pay a bill', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
      const SizedBox(height: 8),
      const Text('Choose what you want to pay for. You can review a sample only; real payments are not switched on yet.', style: TextStyle(color: AppTheme.muted, height: 1.45)),
      const SizedBox(height: 22),
      const Text('1. Choose a service', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
      const SizedBox(height: 12),
      ..._services.entries.map((entry) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: _ServiceRow(icon: entry.value, title: entry.key, selected: _selectedService == entry.key, onTap: () => _selectService(entry.key)),
      )),
      if (_selectedService != null) ...[
        const SizedBox(height: 18),
        Text('2. Enter details', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            if (_selectedService == 'Airtime' || _selectedService == 'Mobile data') ...[
              DropdownButtonFormField<String>(
                value: _selectedNetwork,
                decoration: const InputDecoration(labelText: 'Mobile network', helperText: 'Choose the network for this phone'),
                items: _networks.map((network) => DropdownMenuItem(value: network, child: Text(network))).toList(),
                onChanged: (value) => setState(() => _selectedNetwork = value),
                validator: (value) => value == null ? 'Choose a mobile network' : null,
              ),
              const SizedBox(height: 14),
            ],
            if (_selectedService == 'Electricity') ...[
              DropdownButtonFormField<String>(
                value: _selectedMeterType,
                decoration: const InputDecoration(labelText: 'Meter type'),
                items: const [
                  DropdownMenuItem(value: 'prepaid', child: Text('Prepaid meter')),
                  DropdownMenuItem(value: 'postpaid', child: Text('Postpaid meter')),
                ],
                onChanged: (value) => setState(() => _selectedMeterType = value),
                validator: (value) => value == null ? 'Choose your meter type' : null,
              ),
              const SizedBox(height: 14),
            ],
            TextFormField(
              controller: _customerController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: _customerLabel, hintText: _customerHint, helperText: _customerHelp, prefixIcon: const Icon(Icons.person_outline_rounded)),
              validator: (value) {
                final input = value?.trim() ?? '';
                if (input.isEmpty) return 'Enter your ${_customerLabel.toLowerCase()}';
                if (_selectedService == 'Airtime' || _selectedService == 'Mobile data') {
                  final digits = input.replaceAll(RegExp(r'[^0-9]'), '');
                  if (digits.length < 10 || digits.length > 14) return 'Enter a valid phone number';
                }
                if ((_selectedService == 'Electricity' || _selectedService == 'Cable TV') && input.length < 5) return 'Check the number and enter it again';
                return null;
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: false),
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(labelText: 'Amount in naira (₦)', hintText: 'e.g. 1000', helperText: 'Enter a whole amount in naira', prefixIcon: Icon(Icons.payments_outlined)),
              validator: (value) {
                final amount = int.tryParse((value ?? '').trim());
                if (amount == null) return 'Enter an amount using numbers only';
                if (amount < 100) return 'Minimum preview amount is ₦100';
                if (amount > 500000) return 'Enter an amount of ₦500,000 or less';
                return null;
              },
            ),
            const SizedBox(height: 18),
            FilledButton.icon(onPressed: _reviewPreview, icon: const Icon(Icons.fact_check_outlined), label: const Text('Review details')),
          ]),
        ),
      ],
      const SizedBox(height: 18),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFFFFF3D9), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFFFE0A3))),
        child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(Icons.info_outline_rounded, color: AppTheme.primaryDark), SizedBox(width: 10),
          Expanded(child: Text('Preview only. No money will be collected and no bill will be paid. Do not treat this screen as a receipt.', style: TextStyle(color: AppTheme.primaryDark, height: 1.45))),
        ]),
      ),
    ],
  );

  String get _customerLabel => switch (_selectedService) {
    'Airtime' || 'Mobile data' => 'Phone number',
    'Electricity' => 'Meter number',
    'Cable TV' => 'Smartcard or IUC number',
    _ => 'Customer number',
  };
  String get _customerHint => switch (_selectedService) {
    'Airtime' || 'Mobile data' => 'e.g. 08012345678',
    'Electricity' => 'Enter the number on your meter card',
    'Cable TV' => 'Enter the number on your decoder card',
    _ => 'Enter your customer number',
  };
  String get _customerHelp => switch (_selectedService) {
    'Airtime' || 'Mobile data' => 'Check the phone number before continuing',
    'Electricity' => 'The actual customer check is not connected yet',
    'Cable TV' => 'The actual customer check is not connected yet',
    _ => '',
  };

  void _reviewPreview() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    final amount = int.parse(_amountController.text.trim());
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Review your details'),
        content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          _ReviewLine(label: 'Service', value: _selectedService ?? ''),
          if (_selectedNetwork != null) _ReviewLine(label: 'Network', value: _selectedNetwork!),
          if (_selectedMeterType != null) _ReviewLine(label: 'Meter type', value: _selectedMeterType == 'prepaid' ? 'Prepaid' : 'Postpaid'),
          _ReviewLine(label: _customerLabel, value: _customerController.text.trim()),
          _ReviewLine(label: 'Sample amount', value: '₦${amount.toString()}'),
          const SizedBox(height: 12),
          const Text('This is a design preview. No payment will be started.', style: TextStyle(color: AppTheme.primaryDark, fontWeight: FontWeight.w600)),
        ]),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Back to edit'))],
      ),
    );
  }
}

class _ReviewLine extends StatelessWidget {
  const _ReviewLine({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(child: Text(label, style: const TextStyle(color: AppTheme.muted))),
      const SizedBox(width: 12),
      Flexible(child: Text(value, textAlign: TextAlign.end, style: const TextStyle(fontWeight: FontWeight.w700))),
    ]),
  );
}

class _ServiceRow extends StatelessWidget {
  const _ServiceRow({required this.icon, required this.title, required this.selected, required this.onTap});
  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: selected ? const Color(0xFFFFE3E8) : Colors.white,
    borderRadius: BorderRadius.circular(16),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        constraints: const BoxConstraints(minHeight: 72),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: selected ? AppTheme.primary : AppTheme.border, width: selected ? 1.5 : 1)),
        child: Row(children: [
          Icon(icon, color: AppTheme.primary, size: 28), const SizedBox(width: 12),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))),
          Icon(selected ? Icons.radio_button_checked_rounded : Icons.radio_button_unchecked_rounded, color: selected ? AppTheme.primary : AppTheme.muted),
        ]),
      ),
    ),
  );
}
