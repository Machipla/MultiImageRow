//
//  ViewController.swift
//  MultiImageRowExample
//
//  Created by Mario Plaza on 25/9/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import Eureka
import MultiImageRow

class ViewController: FormViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        loadForm()
    }

    func loadForm(){
        let pickerRow = MultiImagePickerRow(fromController: .specific(self)) { row in
            row.placeholderImage = UIImage(named: "ic_placeholder")
            row.descriptionTitle = "Editable images"
            row.value = [.url(URL(string: "https://i.imgflip.com/1cl03l.jpg?a427056")!),.empty,.empty]
        }
        
        let imagesRow = MultiImageRow(initializer: { row in
            row.descriptionTitle = "Static images"
            row.value = [.image(UIImage(named: "nicolas_sample")!)]
        }).onImageSelected { row, image, index in
            let alertController = UIAlertController(title: "Isn't he pretty?", message: "You know it is", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Yes, I love him", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        
        form +++ Section("Nicolas album :)") <<< pickerRow <<< imagesRow
    }

}

