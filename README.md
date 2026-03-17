# 📚 StudyTrack — Student Performance Tracker

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" />
  <img src="https://img.shields.io/badge/Riverpod-0099CC?style=for-the-badge&logo=flutter&logoColor=white" />
</p>

<p align="center">
  A beautifully designed cross-platform mobile application built with Flutter, helping Nigerian secondary school students track their academic performance, take quizzes, and stay motivated on their learning journey.
</p>

---

## 🎯 Problem Statement

Most Nigerian secondary school students (SS1 - SS3) struggle with:
- No structured way to test and track their knowledge
- Lack of visibility into which subjects need more attention
- No motivation system to keep them consistent
- Poor preparation for WAEC, NECO, and JAMB exams

**StudyTrack solves all of this in one beautifully designed app.**

---

## ✨ Features

| Feature | Description |
|---|---|
| 🔐 **Authentication** | Secure email/password login & signup via Firebase Auth |
| 🏠 **Home Dashboard** | Personalized greeting, subject grid, popular videos & progress stats |
| 📚 **Subject Library** | Browse all subjects with chapters, videos and e-books |
| 📝 **Quiz System** | Timed MCQ quizzes with real-time score tracking and results |
| 📊 **Performance Reports** | Donut charts, bar charts, difficulty breakdown & subject progress |
| 👤 **User Profile** | Edit profile, view stats, class info and study activity |
| 🎬 **Video Player** | Watch educational videos with playback controls |
| 🔍 **Search** | Search subjects and topics instantly |
| 🌟 **Splash Screen** | Animated launch screen with smooth transitions |
| 🔄 **Real-time Updates** | All data syncs in real-time via Firestore streams |

---

## 🛠 Tech Stack

| Technology | Purpose |
|---|---|
| **Flutter** | Cross-platform UI framework |
| **Dart** | Programming language |
| **Firebase Auth** | User authentication |
| **Cloud Firestore** | Real-time NoSQL database |
| **Firebase Storage** | Media storage |
| **Riverpod** | State management |
| **GoRouter** | Navigation & routing |
| **fl_chart** | Beautiful charts & data visualization |
| **cached_network_image** | Optimized image loading |

---

## 📱 Screenshots

> Coming soon — demo video and screenshots will be added here

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0+)
- Dart SDK
- Android Studio / VS Code
- Firebase account

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/YOUR_USERNAME/student-performance-tracker.git
cd student-performance-tracker
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Firebase Setup**
   - Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
   - Enable **Email/Password** Authentication
   - Create a **Firestore** database
   - Download and add `google-services.json` to `android/app/`
   - Run `flutterfire configure` to generate `firebase_options.dart`

4. **Run the app**
```bash
flutter run
```

---

## 🏗 Project Structure

```
lib/
├── main.dart
├── firebase_options.dart
├── app/
│   ├── routes.dart          # GoRouter navigation
│   └── theme.dart           # App colors & styling
├── features/
│   ├── auth/                # Login & Signup screens
│   ├── home/                # Home dashboard
│   ├── subjects/            # Subjects list & detail
│   ├── quiz/                # Quiz with timer & scoring
│   ├── reports/             # Performance charts
│   ├── video/               # Video player
│   ├── profile/             # User profile & edit
│   └── splash/              # Animated splash screen
├── services/
│   ├── auth_service.dart    # Firebase Auth logic
│   └── firestore_service.dart # Firestore CRUD operations
└── shared/
    ├── widgets/             # Reusable widgets
    ├── models/              # Data models
    └── utils/               # Helper functions
```

---

## 🎨 Design Philosophy

StudyTrack was designed with a strong focus on user experience and visual appeal. As a developer with 4+ years of graphic design experience, every screen was carefully crafted to be:

- **Intuitive** — Students can navigate without any learning curve
- **Motivating** — Warm orange/red color palette energizes and encourages
- **Accessible** — Clean typography and sufficient contrast for readability
- **Consistent** — Unified design language across all screens

---

## 🗺 Roadmap

- [ ] AI-powered quiz question generation
- [ ] Push notifications for study reminders
- [ ] Offline mode support
- [ ] Leaderboard & social features
- [ ] Parent/Teacher dashboard
- [ ] Play Store release
- [ ] iOS App Store release

---

## 👨‍💻 About the Developer

**Emmanuel** — Graphic Designer & Flutter Mobile Developer

With 4+ years of professional graphic design experience working with diverse brands, I bring a unique combination of design thinking and technical development skills to every project I build.

- 🎨 Brand identity & graphic design
- 📱 Cross-platform Flutter development
- 🔥 Firebase backend integration
- 💡 EdTech & product thinking

> *"I don't just build apps — I design experiences."*

---

## 📬 Connect

- **LinkedIn:** [Your LinkedIn URL]
- **GitHub:** [Your GitHub URL]
- **Email:** [Your Email]

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  Built with ❤️ by Emmanuel | Powered by Flutter & Firebase
</p>
