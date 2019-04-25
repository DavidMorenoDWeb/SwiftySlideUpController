# SwiftySlideUpController

<p align="center">
    <a href="https://cocoapods.org/pods/SwiftySlideUpController">
        <img src="https://img.shields.io/cocoapods/v/SwiftySlideUpController.svg?style=flat" alt="CocoaPods" />
    </a>
    <img src="https://img.shields.io/cocoapods/p/SwiftySlideUpController.svg?style=flat" alt="Platform" />
    <img src="https://img.shields.io/badge/Swift-5.0-orange.svg" alt="Swift 5.0" />
    <img src="https://badges.frapsoft.com/os/mit/mit.svg?style=flat&v=102" alt="License" />
</p>

SwiftySlideUpController is a Swift lightweight library to add a slide up controller with interactive animations easily

<p align="center">
    <img src ="Resources/SlideUpControllerDemo.gif" />
</p>

## <a name="installation"></a>Installation

### <a name="cocoapods"></a>CocoaPods

To install SwiftySlideUpController with [CocoaPods](https://cocoapods.org), add this to your `Podfile`:

```ruby
pod 'SwiftySlideUpController'
```

### <a name="manual-installation"></a>Manual installation

To add `SwiftySlideUpController` to your app manually, clone this repo
and place it somewhere on disk, then add `SwiftySlideUpController.xcodeproj` to the project
and add `SwiftySlideUpController.framework` as an embedded app binary and target dependency.

## <a name="basic-example"></a>Basic example

You can add a SlideUpController to your UIViewController and add your items to it easily.

```swift
// Creates the SlideUpController
var slideUpController: SlideUpControllerDefault = SlideUpControllerModule().buildDefault()
        
// Presents it in your current UIViewController        
slideUpController.present(in: self)

// Sets the header title
slideUpController.set(headerTitle: "Comments")

// Adds a couple of items
slideUpController.addItem(SlideUpControllerItem(data: SlideUpControllerItemData(title: "Your cool title", text: "The description text", image: nil), value: index, handler: { item in
                // Item click handler
                print("Item tapped with name: \(String(describing: item.data.title))")
            }))
            
slideUpController.addItem(SlideUpControllerItem(data: SlideUpControllerItemData(title: "Your second item title", text: "The description text", image: nil), value: index, handler: { item in
                // Item click handler
                print("Item tapped with name: \(String(describing: item.data.title))")
            }))
```
