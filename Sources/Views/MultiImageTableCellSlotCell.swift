//
//  MultiImageTableCellSlotCell.swift
//  Alamofire
//
//  Created by Mario Plaza on 25/9/18.
//

import UIKit

public typealias MultiImageTableCellSlotCell = UICollectionViewCell & MultiImageTableCellSlotCellProtocol

public protocol MultiImageTableCellSlotCellProtocol where Self: UICollectionViewCell{
    // ImageView that shows the placeholder if no current image is selected
    var placeholderImageView:UIImageView! {get}
    // ImageView that shows the current image
    var imageView:UIImageView!            {get}
}
