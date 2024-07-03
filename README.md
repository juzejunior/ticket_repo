# Top-up Ticket 🪐

A Flutter project that aims to enable user to top-up it's beneficiaries.

The app has a recharge acreen listing the user beneficiaries with an option to recharge it's phone.

It's configured with [BLoC](https://pub.dev/packages/flutter_bloc) for state management, [Go Router](https://pub.dev/packages/go_router) for routes, [Bloc Provider](https://pub.dev/packages/flutter_bloc) as DI. Using CLEAN arch with feature-based folders.


<br />
<div>
  &emsp;&emsp;&emsp;
  <img src="https://github.com/juzejunior/top_up_ticket/assets/17789097/35301c24-834d-4ed4-9721-ab4dff12608c" alt="Recharge Screen" width="330">
</div>
<br />



# Features supported

* Swipe left and right in the control to navigate through all beneficiaries ✅
* Add a maximum of 5 active top-up beneficiaries ✅
* Add a recharge to it's beneficiaries ✅
* Resume Top-Up screen ✅

# First Run 🚀

Installing the package dependencies with 

```
flutter pub get
```

This project uses  code generation, execute the following command to generate files:

```
dart run build_runner build --delete-conflicting-outputs
```

or watch command in order to keep the source code synced automatically:

```
flutter packages pub run build_runner watch
```
