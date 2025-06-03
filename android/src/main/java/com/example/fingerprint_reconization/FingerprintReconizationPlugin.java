package com.example.fingerprint_reconization;

import android.app.Activity;
import android.content.Context;
import androidx.annotation.NonNull;
import androidx.biometric.BiometricManager;
import androidx.biometric.BiometricPrompt;
import androidx.core.content.ContextCompat;
import androidx.fragment.app.FragmentActivity;


import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import java.util.concurrent.Executor;

public class FingerprintReconizationPlugin implements FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {
  private MethodChannel channel;
  private Context context;
  private Activity activity;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "fingerprint_reconization");
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
    if (call.method.equals("authenticate")) {
      authenticateUser(result);
    } else {
      result.notImplemented();
    }
  }

  private void authenticateUser(MethodChannel.Result result) {
    BiometricManager biometricManager = BiometricManager.from(context);
    if (biometricManager.canAuthenticate() != BiometricManager.BIOMETRIC_SUCCESS) {
      result.error("NOT_SUPPORTED", "Biometric authentication not available", null);
      return;
    }

    Executor executor = ContextCompat.getMainExecutor(context);
    BiometricPrompt.AuthenticationCallback callback = new BiometricPrompt.AuthenticationCallback() {
      @Override
      public void onAuthenticationSucceeded(@NonNull BiometricPrompt.AuthenticationResult authResult) {
        super.onAuthenticationSucceeded(authResult);
        result.success("AUTH_SUCCESS");
      }

      @Override
      public void onAuthenticationFailed() {
        super.onAuthenticationFailed();
        result.error("AUTH_FAILED", "Authentication failed", null);
      }

      @Override
      public void onAuthenticationError(int errorCode, @NonNull CharSequence errString) {
        super.onAuthenticationError(errorCode, errString);
        result.error("AUTH_ERROR", errString.toString(), null);
      }
    };

    BiometricPrompt biometricPrompt = new BiometricPrompt((FragmentActivity) activity, executor, callback);

    BiometricPrompt.PromptInfo promptInfo = new BiometricPrompt.PromptInfo.Builder()
            .setTitle("Authentification biométrique")
            .setSubtitle("Scannez votre empreinte digitale")
            .setNegativeButtonText("Annuler")
            .build();

    biometricPrompt.authenticate(promptInfo);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    this.activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {}

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    this.activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivity() {
    this.activity = null;
  }
}
