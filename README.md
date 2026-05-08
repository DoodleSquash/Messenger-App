# 💬 Messenger App

[![Flutter Version](https://img.shields.io/badge/Flutter-3.6.1-blue.svg)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-3.x-blue.svg)](https://dart.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-green.svg)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
[![State Management](https://img.shields.io/badge/State%20Management-BLoC-orange.svg)](https://bloclibrary.dev)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A high-performance, real-time messaging solution built with the power of **Flutter** and **Socket.io**. This project demonstrates a production-grade implementation of real-time communication, featuring a robust clean architecture and seamless state management.

---

## 🌟 Key Features

- **⚡ Real-time Synchronization**: Instant messaging powered by Socket.io for low-latency communication.
- **🛡️ Secure Authentication**: Full JWT-based authentication flow including secure login and user registration.
- **📱 Responsive Design**: A fluid UI that scales perfectly across Android, iOS, Web, and Desktop.
- **📇 Contact Discovery**: Effortlessly find and connect with users via email-based search.
- **💬 Conversation Management**: Persistent chat history with real-time status updates and message previews.
- **🔒 Encrypted Storage**: Sensitive data and authentication tokens are secured using industry-standard encryption via `flutter_secure_storage`.

## 🏗️ Architecture & Design Patterns

This project follows **Domain-Driven Design (DDD)** and **Clean Architecture** principles to ensure the codebase remains scalable, testable, and maintainable.

### Layered Structure
- **Data Layer**: Responsible for external data sources (API, Sockets) and repository implementations.
- **Domain Layer**: Contains the core business logic, entities, and abstract repository interfaces (the "heart" of the app).
- **Presentation Layer**: Handles the UI logic using the **BLoC pattern**, ensuring a clean separation between business logic and UI components.

### Folder Structure
```text
lib/
├── core/                  # Global themes, constants, and singleton services
└── features/              # Modular feature-driven components
    ├── auth/              # Identity and access management
    ├── chat/              # Real-time messaging engine
    ├── contacts/          # Peer-to-peer discovery logic
    └── conversation/      # Global chat orchestration
```

## 🛠️ Technology Stack

| Component | Technology |
| :--- | :--- |
| **Framework** | Flutter |
| **Language** | Dart |
| **State Management** | Flutter BLoC |
| **Real-time Engine** | Socket.io |
| **Storage** | Flutter Secure Storage |
| **UI Components** | Custom Design System (Dark Theme) |
| **Typography** | Alegreya Sans (Google Fonts) |

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK**: `^3.6.1`
- **Dart SDK**: `^3.x`
- **Backend**: A compatible Socket.io server (Default: `http://192.168.0.109:6000`)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/messenger-app.git
   cd messenger-app
   ```

2. **Fetch dependencies**
   ```bash
   flutter pub get
   ```

3. **Environment Configuration**
   Update the server connection strings in:
   - `lib/core/socket_service.dart`
   - `lib/features/auth/data/datasources/auth_remote_data_source.dart`

4. **Launch the application**
   ```bash
   flutter run
   ```

## 🗺️ Roadmap

- [ ] Implementation of Push Notifications.
- [ ] End-to-End Encryption (E2EE) for messages.
- [ ] Group Chat functionality.
- [ ] Multimedia support (Images, Videos, Voice messages).
- [ ] Video & Voice calling via WebRTC.

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

---

Developed with 💙 by **Aditya**
