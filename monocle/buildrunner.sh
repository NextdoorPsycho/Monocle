#!/bin/bash

cd "$(dirname "$0")"
flutter pub get
# flutter pub run flutter_oss_licenses:generate.dart --output lib/util/generated/oss_licenses.gen.dart
# flutter pub run flutter_launcher_icons:main
flutter pub run build_runner build --delete-conflicting-outputs
# flutter pub run flutter_native_splash:create
dart format .
# dart pub global activate auto_const
# dart pub global run auto_const
