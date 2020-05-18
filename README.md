This plugin is not maintained anymore. I am not answering any more questions. I will gladly point to your fork if you are going to continue to work on this.

Regards,

[@19hours](https://github.com/19hours)

# Microsoft Azure Notification Hubs wrapper for Flutter

[![Pub Version](https://img.shields.io/pub/v/azure_notificationhubs_flutter?label=swiftoffice%40pub)](https://pub.dev/packages/azure_notificationhubs_flutter)

This is a **work in progress**. View todos in our [issues page](https://github.com/rswiftoffice/azure-notificationhubs-flutter/issues/1) for more information. Please submit PR!

Microsoft Azure Notification Hubs provide a multiplatform, scaled-out push infrastructure that enables you to send mobile push notifications from any backend (in the cloud or on-premises) to any mobile platform. To learn more, visit the [Developer Center](https://azure.microsoft.com/en-us/documentation/services/notification-hubs).

## Getting Started

If you are new to Notification Hubs, you can get started by following the tutorials to push notifications to your [apps](https://docs.microsoft.com/en-us/azure/notification-hubs/).

### Configuration

#### Android Integration

To integrate your plugin into the Android part of your app, follow these steps:

1. Using the Firebase Console add an Android app to your project: Follow the assistant, download the generated google-services.json file and place it inside android/app.

2. Add your notification hub name and connection string to `android/app/src/main/AndroidManifest.xml`.

```
<meta-data 
    android:name="NotificationHubName"
    android:value="" />
<meta-data 
    android:name="NotificationHubConnectionString"
    android:value="Endpoint=..." />
```

2. Add permissions to `android/app/src/main/AndroidManifest.xml`.

```
  <uses-permission android:name="android.permission.INTERNET"/>
  <uses-permission android:name="android.permission.GET_ACCOUNTS"/>
  <uses-permission android:name="com.google.android.c2dm.permission.RECEIVE" />
```

#### iOS Integration

To integrate your plugin into the iOS part of your app, follow these steps:

1. Generate the certificates required by Apple for receiving push notifications following this guide in the [Azure docs](https://docs.microsoft.com/en-us/azure/notification-hubs/notification-hubs-ios-apple-push-notification-apns-get-started#generate-the-certificate-signing-request-file). 

2. Register your app for push notifications with Apple following this guide in the [Azure docs](https://docs.microsoft.com/en-us/azure/notification-hubs/notification-hubs-ios-apple-push-notification-apns-get-started#register-your-app-for-push-notifications).

3. In Xcode, select Runner in the Project Navigator. In the Capabilities Tab turn on Push Notifications and Background Modes, and enable Background fetch and Remote notifications under Background Modes.

4. Add your notification hub name and connection string to `Info.plist`.

```
NotificationHubName
NotificationHubConnectionString
```

#### Dart/Flutter Integration

From your Dart code, you need to import the plugin and instantiate it:

```
import 'package:azure_notificationhubs_flutter/azure_notificationhubs_flutter.dart';

final AzureNotificationhubsFlutter _anh = AzureNotificationhubsFlutter();
```

Requesting permissions on iOS is managed by the plugin and the request will bring up a permissions dialog for the user to confirm on iOS on app launch.

Afterwards, you can listen to the notifications and write your own logic to handle extra data payloads.

```
  _anh.configure(
    onLaunch: (Map<String, dynamic> notification) async {
      print('onLaunch: $notification');
    },
    onResume: (Map<String, dynamic> notification) async {
      print('onResume: $notification');
    },
    onMessage: (Map<String, dynamic> notification) async {
      print('onMessage: $notification');
    },
    onToken: (String token) async {
      print('onToken: $token');
    },
  );
```

## Payloads

iOS and Android have different payloads. The entire payload will be sent to dart onResume, onLaunch, onMessage depending on the situation. 

### iOS Payload

```
{
    aps: {
      alert: {
        title: "Hello world",
        body: "by chu"
      },
      badge: 1
    },
    <!-- extra data payload -->
    ...
  }
```

### Android Payload

Send the title as an empty string if it is not required.

```
{
  "data": {
    "title": "Hello world",
    "body": "to you",
    <!-- extra data payload -->
    ...
  }
}
```

## Subscribing to tags

Every device is automatically subscribed to `device:deviceID`. For Android, deviceId is a SHA1 hash of FirebaseCloudMessaging token because it exceeds the length limits of a tag.

Manual subscribing to tags is not supported as it is not my priority right now. Feel free to create a PR.

## Why am I receiving silent notifications on android?

It's a feature, not a bug. In android, sometimes the user does not receive any heads up notifications and the notifications appear silently in the notification drawer. This is because heads up notifications have a built in rate limiting - if the user swipes your heads up notification up (putting it back into the notification tray) or to the side (dismissing it), then the system prevents further heads up notifications for some period of time.

## Download Source Code

To get the source code of our wrapper via **git** just type:

    git clone https://github.com/rswiftoffice/azure-notificationhubs-flutter.git

## Contributing

If you're unsure about anything, just ask -- or submit the issue or pull request anyway. The worst that can happen is you'll be politely asked to change something. We love all friendly contributions.
