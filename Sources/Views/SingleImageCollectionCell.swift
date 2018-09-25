//
//  SingleImageCollectionCell.swift
//  PetSpotCoreUI
//
//  Created by Mario Chinchilla on 6/6/18.
//  Copyright © 2018 Machipla. All rights reserved.
//

import UIKit

public class SingleImageCollectionCell: MultiImageTableCellSlotCell{
    @IBOutlet public private(set) weak var imagesContentView:UIView!
    @IBOutlet public private(set) weak var placeholderImageView:UIImageView!
    @IBOutlet public private(set) weak var imageView:UIImageView!
    
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        imagesContentView.layer.cornerRadius = 20
        imagesContentView.layer.borderWidth = 2
        imagesContentView.layer.borderColor = tintColor.cgColor
    }
    
    public override func tintColorDidChange() {
        super.tintColorDidChange()
        setNeedsDisplay()
    }
}
