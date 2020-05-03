# Flutter-CI

[![Build Status](https://travis-ci.com/aslamanver/flutter-ci.svg?branch=master)](https://travis-ci.com/aslamanver/flutter-ci)

#### .travis.yml

```yaml
language: android
jdk: oraclejdk8
env:
  global:
    - ANDROID_TARGET=android-29
    - ANDROID_ABI=armeabi-v7a
android:
  components:
  - tools
  - platform-tools
  - build-tools-29.0.0
  - build-tools-23.0.3
  - android-23
  - extra-android-m2repository
  - $ANDROID_TARGET
  # - sys-img-${ANDROID_ABI}-${ANDROID_TARGET}
  - android-22
  - sys-img-armeabi-v7a-android-22
before_script:
  - yes | sdkmanager "platforms;android-29"
  - yes | sdkmanager "platforms;android-28"
  - yes | sdkmanager "platforms;android-23"
  - yes | sdkmanager "platforms;android-22"
  - git clone https://github.com/flutter/flutter.git -b stable --depth 1
  - export PATH="$(pwd)/flutter/bin":$PATH
  - flutter doctor
  - flutter packages get
script:
  - flutter doctor
  - flutter build apk
  - cd android
  # - ./gradlew build jacocoTestReport assembleAndroidTest
  - echo no | android create avd --force -n test -t android-22 --abi $ANDROID_ABI
  - emulator -avd test -no-skin -no-audio -no-window &
  - android-wait-for-emulator
  - adb shell setprop dalvik.vm.dexopt-flags v=n,o=v
  - ./gradlew connectedCheck
after_success:
  - bash <(curl -s https://codecov.io/bash)
before_cache:
- rm -f  $HOME/.gradle/caches/modules-2/modules-2.lock
- rm -fr $HOME/.gradle/caches/*/plugin-resolution/
cache:
  directories:
    - $HOME/.pub-cache
    - $HOME/.gradle/caches/
    - $HOME/.gradle/wrapper/
    - $HOME/.android/build-cache
```
