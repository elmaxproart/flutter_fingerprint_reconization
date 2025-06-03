
````markdown
# fingerprint_reconization

A simple Flutter plugin to handle fingerprint (biometric) authentication using Android's `BiometricPrompt` API.

## Features

✅ Authenticate users using fingerprint  
✅ Fully native Android implementation  
✅ Easy to use from Dart  
✅ BiometricPrompt-based, supports modern devices  

---

## 🔧 Installation

Add the plugin to your `pubspec.yaml`:

```yaml
dependencies:
  fingerprint_reconization:
    path: ../fingerprint_reconization # or from pub.dev when published
````

---

## ✍️ Android Configuration

### 1. Update your `example/android/app/src/main/java/.../MainActivity.java`

Replace:

```java
import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {}
```

With:

```java
import io.flutter.embedding.android.FlutterFragmentActivity;

public class MainActivity extends FlutterFragmentActivity {}
```

> This change is necessary because `BiometricPrompt` requires a `FragmentActivity`.

---

### 2. Update your plugin’s Java class (if you're writing a plugin)

In `android/src/main/java/com/example/fingerprint_reconization/FingerprintReconizationPlugin.java`:

Ensure the imports and casting are correct:

```java
import androidx.fragment.app.FragmentActivity;

// ...

BiometricPrompt biometricPrompt = new BiometricPrompt((FragmentActivity) activity, executor, callback);
```

---

### 3. Add permissions in `AndroidManifest.xml` (usually not required, but good practice)

In `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.USE_BIOMETRIC" />
<uses-permission android:name="android.permission.USE_FINGERPRINT" />
```

---

### 4. Use Java 11+

In `android/build.gradle`:

```gradle
android {
  compileSdkVersion 33

  defaultConfig {
    minSdkVersion 23
    targetSdkVersion 33
  }

  compileOptions {
    sourceCompatibility JavaVersion.VERSION_11
    targetCompatibility JavaVersion.VERSION_11
  }
}
```

---
### 5. insuer to use minNdkVersion =`27.xxxxxxxxxx`
## 📱 Usage

### Dart code (example):

```dart
import 'package:flutter/material.dart';
import 'package:fingerprint_reconization/fingerprint_reconization.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _plugin = FingerprintReconization();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Fingerprint Auth')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              try {
                final result = await _plugin.authenticate();
                if (result == 'AUTH_SUCCESS') {
                  print("Authentication succeeded!");
                } else {
                  print("Authentication failed: $result");
                }
              } catch (e) {
                print("Error: $e");
              }
            },
            child: Text("Authenticate"),
          ),
        ),
      ),
    );
  }
}
```

---

## 🧪 Methods

| Method           | Description                   |
| ---------------- | ----------------------------- |
| `authenticate()` | Prompts user for fingerprint. |

---

## ❗ Important Notes

* Only works on **Android API 23+** (Android 6.0+).
* You must use `FlutterFragmentActivity` instead of `FlutterActivity`.
* If you see errors related to `FragmentActivity`, check your imports and class inheritance in `MainActivity`.

---

## 📄 License

MIT License.

```


