import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';

class FuturePartnerMessagePage extends StatefulWidget {
  final String? initialMessage;
  final Function(String) onChanged;

  const FuturePartnerMessagePage({
    super.key,
    required this.onChanged,
    this.initialMessage,
  });

  @override
  State<FuturePartnerMessagePage> createState() =>
      _FuturePartnerMessagePageState();
}

class _FuturePartnerMessagePageState extends State<FuturePartnerMessagePage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialMessage ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Is there anything special you'd like your future partner to know about you?",
            style: AppTextStyles.heading(context),
          ),
          const SizedBox(height: AppSizes.largeSpacing),

          // Text Input Field
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: TextField(
              controller: _controller,
              onChanged: widget.onChanged,
              maxLines: null,
              expands: false,
              decoration: InputDecoration(
                hintText: "Type here...",
                hintStyle: TextStyle(color: AppColors.textSecondary),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
              style: AppTextStyles.bold(context),
            ),
          ),

          const SizedBox(height: AppSizes.largeSpacing),

          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
