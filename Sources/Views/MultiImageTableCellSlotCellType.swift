//
//  MultiImageTableCellSlotCellType.swift
//  Alamofire
//
//  Created by Mario Plaza on 25/9/18.
//

import Foundation

public extension MultiImageTableCell{
    public enum SlotCellType{
        case `default`
        case customNib(UINib)
        case customClass(AnyClass)
    }
}
