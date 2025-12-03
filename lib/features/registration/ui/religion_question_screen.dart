import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/rounded_button.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_sizes.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_event.dart';

class ReligionQuestionScreen extends StatefulWidget {
  const ReligionQuestionScreen({super.key});
  @override
  State<ReligionQuestionScreen> createState() => _ReligionQuestionScreenState();
}

class _ReligionQuestionScreenState extends State<ReligionQuestionScreen> {
  String? tradition;
  String? attendance;
  bool involved = false;

  void _submit() {
    final answers = {
      'tradition': tradition,
      'attendance': attendance,
      'involved': involved,
    };
    BlocProvider.of<RegistrationBloc>(context).add(ReligionAnswerUpdated(answers));
    BlocProvider.of<RegistrationBloc>(context).add(SubmitRegistration());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Registration completed'),
        content: const Text('This is a dummy flow. Replace repository with real API to persist.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final traditions = [
      'Roman Catholic',
      'Protestant (Pentecostal/Evangelical)',
      'Orthodox (Syrian/Jacobite/Mar Thoma)',
      'Methodist',
      'Lutheran',
      'Baptist',
      'Presbyterian',
      'Independent/Non-denominational',
      'Still exploring different traditions',
    ];

    final attendanceOptions = [
      'Weekly (almost every Sunday)',
      'Biweekly (2-3 times a month)',
      'Monthly (once a month)',
      'Occasionally (festivals & special occasions)',
      'Rarely',
    ];

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: const BackButton(color: Colors.black)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18),
            Text('Which Christian tradition feels most like home to you?', style: AppTextStyles.heading(context)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  ...traditions.map((t) => RadioListTile<String>(
                    title: Text(t),
                    value: t,
                    groupValue: tradition,
                    onChanged: (v) => setState(() => tradition = v),
                  )),
                  const SizedBox(height: 8),
                  Text('How often do you attend church services?', style: AppTextStyles.heading(context).copyWith(fontSize: 18)),
                  ...attendanceOptions.map((a) => RadioListTile<String>(
                    title: Text(a),
                    value: a,
                    groupValue: attendance,
                    onChanged: (v) => setState(() => attendance = v),
                  )),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    value: involved,
                    onChanged: (v) => setState(() => involved = v),
                    title: const Text('Are you involved in any church activities or ministries?'),
                  ),
                ],
              ),
            ),
            RoundedButton(label: 'Next', onPressed: _submit),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
