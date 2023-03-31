<!-- ![](https://i.ibb.co/fdzqFyR/shopping-cart-flutter-package.jpg) -->

- [Material Design 3 modal side sheet](#material-design-3-modal-side-sheet)
  - [Features](#features)
  - [Usage](#usage)
  - [Example](#example)

# Material Design 3 modal side sheet
A Flutter package that provides a Material Design 3 side sheet as a general dialog.

Please check out the [official documentation](https://m3.material.io/components/side-sheets/overview) for more information on Material Design side sheet

## Features
- Custom header and body widgets.
- Option to add a back button and close button.
- Option to add confirm and cancel action buttons.
- Option to show/hide a divider between the body and action buttons.
- Customizable button text and tooltips.
- Option to dismiss the dialog by tapping outside of it.
  
## Usage
To use this package, add `side_sheet_material3` as a dependency in your pubspec.yaml file.

```dart
dependencies:
  side_sheet_material3: ^0.0.1
```

## Example
```dart
await showModalSideSheet(
  context: context,
  header: 'Edit Profile',
  body: ProfileEditForm(), // Put your content widget here
  addBackIconButton: true,
  addActions: true,
  addDivider: true,
  confirmActionTitle: 'Save',
  cancelActionTitle: 'Cancel',
  confirmActionOnPressed: () {
    // Do something
  },

  // If null, Navigator.pop(context) will used
  cancelActionOnPressed: () {
    // Do something
  },
);
```
Please check out the [full example](https://pub.dev/documentation/side_sheet_material3/example) for more information on how to use this package.

[![Buy me a coffe](https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png "Buy me a coffe")](https://www.buymeacoffee.com/egortabula "Buy me a coffe")