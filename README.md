# :dizzy: :alien: :rocket: space_time :dizzy: :alien: :rocket:

SpaceX rocket launch times viewer by Ben Butterworth. Done in 2 days: 14th and 15th March, 2021.

### To install
- I did not commit build files to the git repo. You can download the repo which contains **pre-built files (APK for Android/ .app for iOS)** from [here](https://drive.google.com/file/d/1x15vq25Dxg9EmJ_MVcZR34RdHKh4GJM1/view?usp=sharing).
- Android: `cd space_time`, Plug in a device with debug mode or run emulator, followed by `adb install public/SpaceTime.apk`
- iOS: Drag `public/SpaceTime.app` onto an iOS simulator
- Or, just **build and run it**.

### My solution
- I found that the SpaceX Upcoming Launches API gave launch dates to varying precision (accurate to 1 month, accurate to 1 year, etc), so I handled date precision: some dates are "relative" (e.g. in a day) when they are more precise, but others are months/ years (e.g. May) when they are less precise. 
- I initially implemented the header (`Launch`, `date/ UTC`), but realized the content speaks for itself once the dates are provided in a human friendly format.
- I don't use `const Widget` because I have not found a performance benchmark for it, have you? It will likely increase memory usage but improve speed for AOT builds. (though most likely these effects are negligible).

### I discovered an inconsistency between iOS and Android:
Notice there is a gap between `06` and `DAYS` on iOS, but not Android. This is because the text baselines are inconsistent. See [16257](https://github.com/flutter/flutter/issues/16257) for more information.

<img src="images/baseline_error.png" alt="Baseline error" width="400"/>

### More images

See `/images/ios` and `images/android` for more images.

<img src="images/android/skeleton.png" alt="Skeleton" width="200"/>

<img src="images/ios/countdown-landscape.png" alt="Landscape coutdown" width="400"/>

<img src="images/android/sharing.png" alt="Sharing" width="200"/>

<img src="images/ios/countdown.png" alt="Landscape" width="200"/>

<img src="images/ios/launches.png" alt="launches" width="200"/>

### Resources & licenses
- Digital-7 font used for countdown was taken from https://www.dafont.com/digital-7.font - free for personal use
