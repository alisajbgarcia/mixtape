# mixtape

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# A NOTE FROM CHARLIE
- If you're testing using the android emulator, run the two following commands:
```bash
$ adb devices
```

Find the device name of your emulator

and then run

```bash
$ adb -s <device name> reverse tcp:8081 tcp:8081
```

This will forward localhost network requests on port 8081 to local host network requests on your
machine on 8081.

Basically, if you ever get an error saying "localhost" can't be connected to or whatever, then
try running that stuff.
