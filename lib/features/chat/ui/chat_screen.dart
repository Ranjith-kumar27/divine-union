import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes.dart';
import 'chat_detail_screen.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  /// Dummy chat list (future: API)
  final List<Map<String, dynamic>> chatList = [
      {
        "name": "Maria Joseph",
        "image": "https://i.pinimg.com/736x/3e/86/1c/3e861cace82afdabcfbd7d5d354edda4.jpg",
        "lastMessage": "I’ll keep you posted on this.",
        "time": "2m ago",
        "unread": 1,
        "online": true
      },
      {
        "name": "Anna Paul",
        "image": "https://i.pinimg.com/1200x/e8/5e/10/e85e1004513e5d550e4094ed6640ae88.jpg",
        "lastMessage": "That sounds perfect.",
        "time": "18m ago",
        "unread": 2,
        "online": true
      },
      {
        "name": "Ruth Mathew",
        "image": "https://i.pinimg.com/1200x/29/65/b9/2965b94b6b98dcc95e306f9665c71713.jpg",
        "lastMessage": "Thanks for explaining.",
        "time": "50m ago",
        "unread": 0,
        "online": false
      },
      {
        "name": "Esther John",
        "image": "https://i.pinimg.com/1200x/24/0b/29/240b2912880da864e767dddbefb9f4be.jpg",
        "lastMessage": "Let’s discuss this tomorrow.",
        "time": "2h ago",
        "unread": 1,
        "online": true
      },
      {
        "name": "Rachel Thomas",
        "image": "https://i.pinimg.com/736x/96/6c/11/966c11c2de865314f078cc34becd2670.jpg",
        "lastMessage": "I have shared the file.",
        "time": "4h ago",
        "unread": 0,
        "online": false
      },
      {
        "name": "Grace Antony",
        "image": "https://i.pinimg.com/1200x/96/0e/6c/960e6cc2da83705a8e1ea685527290b3.jpg",
        "lastMessage": "Will update you shortly.",
        "time": "7h ago",
        "unread": 1,
        "online": false
      },
      {
        "name": "Lydia Fernandes",
        "image": "https://i.pinimg.com/736x/70/70/1a/70701a672ecdd1bbaa8400a04977e718.jpg",
        "lastMessage": "Sure, noted.",
        "time": "1d ago",
        "unread": 0,
        "online": false
      }
  ];

  @override
  Widget build(BuildContext context) {
    final bool hasChats = chatList.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.horizontalPadding,
                vertical: AppSizes.mediumSpacing,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.messages,
                    style: AppTextStyles.heading(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// SEARCH BOX (TOP)
            if (hasChats) _searchBox(context),

            const SizedBox(height: 20),

            /// CONTENT
            Expanded(
              child: hasChats
                  ? ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.horizontalPadding,
                      ),
                      itemCount: chatList.length,
                      separatorBuilder: (_, __) => const Divider(height: 24),
                      itemBuilder: (context, index) {
                        final chat = chatList[index];
                        return _chatTile(context, chat);
                      },
                    )
                  : _emptyState(context),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------- SEARCH BOX ---------------

  Widget _searchBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.liteDisabled,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            SvgPicture.asset(
              AppAssets.search,
              width: 18,
              height: 18,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: AppTextStyles.body(
                    context,
                  ).copyWith(color: AppColors.textSecondary),
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------- CHAT TILE ----------------

  Widget _chatTile(BuildContext context, Map<String, dynamic> chat) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ChatDetailScreen(profile: chat)),
        );
      },
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundImage: NetworkImage(chat["image"]),
              ),
              if (chat["online"] == true)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(chat["name"], style: AppTextStyles.bold(context)),
                const SizedBox(height: 4),
                Text(
                  chat["lastMessage"],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body(context),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (chat["unread"] > 0)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    chat["unread"].toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              const SizedBox(height: 6),
              Text(chat["time"], style: AppTextStyles.label(context)),
            ],
          ),
        ],
      ),
    );
  }

  /// ---------------- EMPTY STATE ----------------

  Widget _emptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.chatEmpty),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.main);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.whiteHeart),
                    const SizedBox(width: 10),
                    Text(
                      AppStrings.exploreMatches,
                      style: AppTextStyles.buttonLabel(context),
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
}
