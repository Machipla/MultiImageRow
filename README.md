# MultiImageRow
[![License](https://img.shields.io/packagist/l/doctrine/orm.svg?style=flat-square)](https://cocoapods.org/pods/ImagePickerCoordinator)
[![Version](https://img.shields.io/badge/pod-v1.0.0-blue.svg?style=flat-square)](https://cocoapods.org/pods/ImagePickerCoordinator)

A multi-image picker row for Eureka in a single UITableViewCell!
<p align="center">
<img src="Example/Screenshots/MultiImageRow.gif" height = "680" width = "320"/>
</p>

### Multi image row
Multi image row is a row that displays multiple images at once, it is simple as this:

```
let imagesRow = MultiImageRow(initializer: { row in
    row.descriptionTitle = "My images"
    row.value = [.image(UIImage(named: "my_image")!)] // Here goes the slots for the row 
}).onImageSelected { row, image, index in
    // Do something with the selection
}
```

It can load multiple images in a collection view at one, loading them from URL or UIImage or leaving them empty.
There's a default slot cell made for you, but if you want you can customize it to show your own slot cell like this:

```
row.cellType = .customNib(UINib(nibName: "MyAwesomeCell", bundle: nil))
```

You can user new cells via Nib or Class, just like if you were loading a UICollectionViewCell!

### Multi image picker row
Multi image picker row is similar to the previous row and has almost all his functionality, but it also lets the user take a picture from the album or camera using [ImagePickerCoordinator](https://github.com/Machipla/ImagePickerCoordinator)
You can also set a placeholderImage for the row in order to show a placeholder for every slot in the row.

```
let pickerRow = MultiImagePickerRow(fromController: .specific(myController)) { row in
    row.placeholderImage = UIImage(named: "my_placeholder")
    row.descriptionTitle = "My editable images"
    row.value = [.url(URL(string: "https://i.imgflip.com/1cl03l.jpg?a427056")!),.empty,.empty]
}
```

### More
Suggestions? Features? Threats? Let me know!
