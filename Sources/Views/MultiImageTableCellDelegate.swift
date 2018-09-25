//
//  MultiImageTableCellDelegate.swift
//  PetSpotCoreUI
//
//  Created by Mario Chinchilla on 6/6/18.
//  Copyright © 2018 Machipla. All rights reserved.
//

import Foundation
import UIKit

public protocol MultiImageTableCellDelegate: class{
    func multiImageTableCell(_ cell:MultiImageTableCell, hasSelected slot:MultiImageTableCellSlot, at index:Int)
    func multiImageTableCell(_ cell:MultiImageTableCell, hasLoaded image:UIImage, at index:Int)
    func multiImageTableCell(_ cell:MultiImageTableCell, hasClearedImageAt index:Int)
}

public extension MultiImageTableCellDelegate{
    func multiImageTableCell(_ cell:MultiImageTableCell, hasSelected slot:MultiImageTableCellSlot, at index:Int){}
    func multiImageTableCell(_ cell:MultiImageTableCell, hasLoaded image:UIImage, at index:Int){}
    func multiImageTableCell(_ cell:MultiImageTableCell, hasClearedImageAt index:Int){}
}
