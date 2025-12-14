import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class ChatDetailScreen extends StatelessWidget {
  final Map<String, dynamic> profile;

  const ChatDetailScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(AppAssets.back, width: 42, height: 42),
        ),
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(profile["image"])),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(profile["name"], style: AppTextStyles.bold(context)),
                const SizedBox(height: 2),
                Text(
                  "Active now",
                  style: AppTextStyles.label(
                    context,
                  ).copyWith(color: AppColors.success),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => _openProfileInfo(context),
            icon: SvgPicture.asset(AppAssets.info),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Divider(height: 1, thickness: 1, color: AppColors.border),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _incoming("Hi! How are you doing?"),
                _outgoing("I'm doing great! How about you?"),
                _incoming(
                  "Doing well, thanks! I saw on your profile that you enjoy volunteering.",
                ),
                _outgoing(
                  "I volunteer at our local food bank and youth programs 😊",
                ),
                _incoming("That’s great work. Appreciate!!"),
              ],
            ),
          ),
          _messageInput(),
        ],
      ),
    );
  }

  // ---------------- PROFILE INFO BOTTOM SHEET ----------------

  void _openProfileInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 36,
                backgroundImage: NetworkImage(profile["image"]),
              ),
              const SizedBox(height: 12),
              Text(
                "${profile["name"]}, ${profile["age"]}",
                style: AppTextStyles.bold(context),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.heart,
                    width: 14,
                    height: 14,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "${profile["match"]}% Match",
                    style: AppTextStyles.label(
                      context,
                    ).copyWith(color: AppColors.primary),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppAssets.whiteHeart,
                        width: 18,
                        height: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "View Profile",
                        style: AppTextStyles.buttonLabel(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ---------------- CHAT BUBBLES ----------------

  Widget _incoming(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _outgoing(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  // ---------------- MESSAGE INPUT ----------------

  Widget _messageInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Message...",
                filled: true,
                fillColor: AppColors.surface,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    AppAssets.emoji,
                    width: 20,
                    height: 20,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
