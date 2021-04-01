enum Flavor {
  PRODUCTION,
  STAGING,
}

// TODO: rework on this, keeping all detail in the binary isn't nice
class F {
  static Flavor appFlavor;

  static String get title {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return 'Survey';
      case Flavor.STAGING:
        return 'Survey-Staging';
      default:
        return 'Survey-Staging';
    }
  }

  static String get restApiEndpoint {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return 'https://survey-api.nimblehq.co/';
      case Flavor.STAGING:
        return 'https://nimble-survey-web-staging.herokuapp.com/';
      default:
        return 'https://nimble-survey-web-staging.herokuapp.com/';
    }
  }

  static String get basicAuthClientId {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return '4gg3bokkvPnMxWz7HHTdM_wf1RNg9k8iA6sZ2ZrA7EA';
      case Flavor.STAGING:
        return 'z9iUamZLvRgtVVtRJ8UqItg2vmncGyEi30p1eWEddnA';
      default:
        return 'z9iUamZLvRgtVVtRJ8UqItg2vmncGyEi30p1eWEddnA';
    }
  }

  static String get basicAuthClientSecret {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return 'y_GgV-GEjWd3VTzbZBS6tqEco0E68QuqHQv0QND2vKo';
      case Flavor.STAGING:
        return '1vqRNMxq-Yx83A61GNjLb17qxCGKxHDb8EmB3MKdxqA';
      default:
        return '1vqRNMxq-Yx83A61GNjLb17qxCGKxHDb8EmB3MKdxqA';
    }
  }
}
