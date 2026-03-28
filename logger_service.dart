name: Build & Test

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    name: Test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.13.0'
          channel: stable
      
      - name: Get dependencies
        run: flutter pub get
      
      - name: Run tests
        run: flutter test
      
      - name: Analyze
        run: flutter analyze

  build-android:
    name: Build Android APK
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.13.0'
          channel: stable
      
      - name: Setup Java
        uses: actions/setup-java@v3
        with:
          distribution: 'temurin'
          java-version: '11'
      
      - name: Get dependencies
        run: flutter pub get
      
      - name: Build APK
        run: flutter build apk --release
      
      - name: Upload APK
        uses: actions/upload-artifact@v3
        with:
          name: app-release.apk
          path: build/app/outputs/flutter-app-release.apk

  build-web:
    name: Build Web
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.13.0'
          channel: stable
      
      - name: Get dependencies
        run: flutter pub get
      
      - name: Build Web
        run: flutter build web --release
      
      - name: Upload Web
        uses: actions/upload-artifact@v3
        with:
          name: web-build
          path: build/web/
