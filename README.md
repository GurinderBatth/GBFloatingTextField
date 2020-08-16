# GBFloatingTextField

[![CI Status](https://img.shields.io/travis/mr.gsbatth@gmail.com/GBFloatingTextField.svg?style=flat)](https://travis-ci.org/mr.gsbatth@gmail.com/GBFloatingTextField)
[![Version](https://img.shields.io/cocoapods/v/GBFloatingTextField.svg?style=flat)](https://cocoapods.org/pods/GBFloatingTextField)
[![License](https://img.shields.io/cocoapods/l/GBFloatingTextField.svg?style=flat)](https://cocoapods.org/pods/GBFloatingTextField)
[![Platform](https://img.shields.io/cocoapods/p/GBFloatingTextField.svg?style=flat)](https://cocoapods.org/pods/GBFloatingTextField)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- iOS 9.0+
- Xcode 9.3+
- Swift 4+

## Installation

GBFloatingTextField is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'GBFloatingTextField'
```

## New in GBFloatingTextField

Add same functionality for TextView. Please check Usage of GBFloatingTextView for more info. 

## Usage Of GBFloatingTextField
To create an instance of the class, use Interface builder, or do it from code. This example will create the following textField with the placeholder, title , Line and error message:

```swift
let textField = GBTextField(frame: CGRect(x:10, y: 100, width: UIScreen.main.bounds.width - 20, height: 40))
textField.lineColor = .black
textField.titleLabelColor = .black
textField.lineHeight = 1
textField.showErrorMessage("This is Text Error")
self.view.addSubview(textField)
```

There are list of Properties you can change . Please check those your customization.

## Usage Of GBFloatingTextView

To create an instance of the class, use Interface builder, or do it from code. This example will create the following textView with the placeholder and title:

You don't need to add this view to Superview just pass the superview when create instance of GBFloatingTextView. Like in Example.

```swift
let textView = GBFloatingTextView(frame: CGRect(x: 10, y: 200, width: 355, height: 150), superView: self.view)
textView.isFloatingLabel = true
textView.placeholder = "GBFloating TextView"
```
To change Placeholder Color, Top Placeholder Color or Selected Placeholer Color. Please check these properties

```swift
textView.placeholderColor = .gray
textView.topPlaceholderColor = .black
textView.selectedColor = .red
```

To enable Floating Text in GBFlaotingTextView. Please enable "isFloatingLabel" , expect this will hide the Floating text like placeholder text in UITextField.

`isFloatingLabel` is `false` by default. Please make it `true` for Floating Placeholder.

You can change these all Properties in Interface builder for both GBFloatingTextField and GBFloatingTextView.

## Contributing

We welcome all contributions.


## Author

Gurinder Batth, mr.gsbatth@gmail.com

## Credits

Credits for the Secure Entry bug , and improving it with the help of [SkyFloatingLabelTextField](https://github.com/Skyscanner/SkyFloatingLabelTextField).

## Special Thanks

Special thanks to [Mixel]( https://stackoverflow.com/users/746347/mixel) for animate the floating text in UITextView. 

## License

GBFloatingTextField is available under the MIT license. See the LICENSE file for more info.

## Known Issue

It wil not work if the clipsToBounds or masksToBounds property is true.

## About Future Versions

1. Working on make this Class for UITextView.
2. Solve known issues
3. We will try to make custom everything so everyone can use according to there needs.
4. Will add RTL language support.
