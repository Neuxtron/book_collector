# Book Collector

A Flutter mobile app for managing your personal book collection — browse, search,
favourite, and keep track of books with full create/edit/delete support, backed by
a hosted REST API.

## Features

- **Authentication** — register, login, logout, and auto-login with a saved token
- **Browse books** — fetch and display all books from the backend
- **Manage books** — add, edit, and delete books
- **Favourites** — mark books as favourites, persisted locally on device
- **History** — recently opened books, persisted locally on device
- **Search** — search books by title or author
- **Profile** — view the logged-in user's profile

## Tech Stack

| Concern | Package / Tool |
|---|---|
| Framework | Flutter (Dart SDK `>=3.0.5 <4.0.0`) |
| State management, routing & DI | [GetX](https://pub.dev/packages/get) |
| HTTP client | [Dio](https://pub.dev/packages/dio) |
| Local persistence | [shared_preferences](https://pub.dev/packages/shared_preferences) |
| Date formatting | [intl](https://pub.dev/packages/intl) |
| Splash screen & launcher icons | flutter_native_splash, icons_launcher |

## Project Structure

```
lib/
├── main.dart          # App entry point, routes, dependency injection
├── controllers/       # GetX controllers (BookController, UserController)
├── models/
│   ├── repositories/  # Repository layer: business logic & error handling
│   ├── services/      # Service layer: raw API calls via Dio
│   ├── utils/         # Dio client config & API exception helpers
│   └── *_model.dart   # BookModel, UserModel
├── utils/             # App colors, shared-preferences keys, DI bindings
└── views/             # UI, organized per feature
    ├── layouts/       # Main layout with bottom navigation
    ├── home_page/     # Home: search, favourites & recents rows, all books
    ├── add_book/      # Add book form
    ├── detail_book_page/  # Book detail / edit / delete
    ├── auth_pages/    # Login & signup
    └── widgets/       # Shared reusable widgets
```

## Backend API

The app consumes a hosted book CRUD service:

- **Base URL:** `https://book-crud-service-6dmqxfovfq-et.a.run.app/api`
- **Auth:** Bearer token, stored locally after login
- **Endpoints used:**
  - `POST /login`, `POST /register`, `DELETE /user/logout`, `GET /user`
  - `GET /books`, `POST /books/add`, `PUT /books/{id}/edit`, `DELETE /books/{id}`

## Getting Started

1. Make sure you have the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed (Dart `>=3.0.5 <4.0.0`).
2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app:

   ```bash
   flutter run
   ```

### Optional: regenerate splash screen & launcher icons

```bash
dart run flutter_native_splash:create
dart run icons_launcher:create
```

## Status / Roadmap

All core features are complete (see `TODO`). Planned improvements:

- Pull-to-refresh on book lists
- Pagination for the book list
