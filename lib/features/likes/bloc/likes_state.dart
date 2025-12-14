import 'package:equatable/equatable.dart';

class LikesState extends Equatable {
  final int selectedIndex;

  // Dummy data (moved from the widget)
  final List<Map<String, dynamic>> likesYouProfiles;
  final List<Map<String, dynamic>> likedByYouProfiles;
  final List<Map<String, dynamic>> mutualProfiles;

  const LikesState({
    this.selectedIndex = 0,
    this.likesYouProfiles = const [
      {
        "image":
            "https://i.pinimg.com/1200x/e8/5e/10/e85e1004513e5d550e4094ed6640ae88.jpg",
        "name": "Emily Johnson",
        "age": 26,
        "match": 94,
        "height": "5'10",
        "job": "UI/UX Designer",
        "education": "M.Des",
        "location": "Mumbai, Maharashtra",
      },
      {
        "image":
            "https://i.pinimg.com/originals/7e/61/37/7e613711bbcc148dde2ff971b969ba9d.png",
        "name": "Sarah Williams",
        "age": 24,
        "match": 96,
        "height": "5'10",
        "job": "Software Engineer",
        "education": "B.Tech in Computer Science",
        "location": "Bangalore, Karnataka",
      },
    ],
    this.likedByYouProfiles = const [
      {
        "image":
            "https://i.pinimg.com/1200x/e8/5e/10/e85e1004513e5d550e4094ed6640ae88.jpg",
        "name": "Rebecca Antony",
        "age": 25,
        "match": 95,
        "location": "Chennai",
      },
      {
        "image":
            "https://i.pinimg.com/1200x/b6/62/de/b662deb210fbc898489ac2031a3abdf7.jpg",
        "name": "Rachel Mary",
        "age": 24,
        "match": 92,
        "location": "Chennai",
      },
      {
        "image":
            "https://i.pinimg.com/1200x/29/65/b9/2965b94b6b98dcc95e306f9665c71713.jpg",
        "name": "Olivia Brown",
        "age": 23,
        "match": 75,
        "location": "Chennai",
      },
      {
        "image":
            "https://i.pinimg.com/736x/96/6c/11/966c11c2de865314f078cc34becd2670.jpg",
        "name": "Reni",
        "age": 24,
        "match": 85,
        "location": "Chennai",
      },
      {
        "image":
            "https://i.pinimg.com/1200x/96/0e/6c/960e6cc2da83705a8e1ea685527290b3.jpg",
        "name": "Rachel Mary",
        "age": 24,
        "match": 92,
        "location": "Chennai",
      },
    ],
    this.mutualProfiles = const [],
  });

  // Getter for tabs data
  List<Map<String, dynamic>> get tabs => [
    {"label": "Likes you", "count": likesYouProfiles.length},
    {"label": "Liked by you", "count": likedByYouProfiles.length},
    {"label": "Mutual", "count": mutualProfiles.length},
  ];

  // Getter for subtitle text
  String get subtitleText {
    switch (selectedIndex) {
      case 0: // Likes You
        return likesYouProfiles.isNotEmpty
            ? "Someone's got their eyes on you. ✨"
            : "Your perfect match is just around the corner ✨";

      case 1: // Liked by You
        return likedByYouProfiles.isNotEmpty
            ? "You made the first move. 💫"
            : "Start connecting with people you like 💫";

      case 2: // Mutual
        return mutualProfiles.isNotEmpty
            ? "Find your special someone today 💜"
            : "Find your special someone today 💜";

      default:
        return "";
    }
  }

  @override
  List<Object> get props => [
    selectedIndex,
    likesYouProfiles,
    likedByYouProfiles,
    mutualProfiles,
  ];

  LikesState copyWith({
    int? selectedIndex,
    List<Map<String, dynamic>>? likesYouProfiles,
    List<Map<String, dynamic>>? likedByYouProfiles,
    List<Map<String, dynamic>>? mutualProfiles,
  }) {
    return LikesState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      likesYouProfiles: likesYouProfiles ?? this.likesYouProfiles,
      likedByYouProfiles: likedByYouProfiles ?? this.likedByYouProfiles,
      mutualProfiles: mutualProfiles ?? this.mutualProfiles,
    );
  }
}
