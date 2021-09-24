# survey
[![codecov](https://codecov.io/gh/sleepylee/flutter-survey/branch/develop/graph/badge.svg?token=S5YUK2U2IY)](https://codecov.io/gh/sleepylee/flutter-survey)

A survey conducting platform built with Flutter

## Getting Started

- Checkout the repository
- Run the app with the desire app flavor:

  - Staging: `$ flutter run --flavor staging -t lib/main-staging.dart`

  - Production: `$ flutter run --flavor production -t lib/main-production.dart`

- When adding a new model, generating the serializer by running:

  - `$ flutter pub run build_runner build --delete-conflicting-outputs`

- Running unit testing:

  - `$ flutter test .`

- Running integration test with emulator:

  - `flutter drive --driver=test_driver/integration_test_driver.dart --target=integration_test/{test_file}.dart`

- To generate Assets/Font/Image:

  - `$ flutter pub run build_runner build --delete-conflicting-outputs`

## License

This project is Copyright (c) 2014 and onwards. It is free software,
and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: /LICENSE

## About

![Nimble](https://assets.nimblehq.co/logo/dark/logo-dark-text-160.png)

This project is maintained and funded by Nimble.

We love open source and do our part in sharing our work with the community!
See [our other projects][community] or [hire our team][hire] to help build your product.

[community]: https://github.com/nimblehq
[hire]: https://nimblehq.co/
