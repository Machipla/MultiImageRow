//
//  MultiImageTableCellSlot.swift
//  PetSpotCoreUI
//
//  Created by Mario Chinchilla on 6/6/18.
//  Copyright © 2018 Machipla. All rights reserved.
//

import Foundation
import UIKit

public enum MultiImageTableCellSlot: Equatable{
    case image(UIImage)
    case url(URL)
    case empty
    
    public var isAnEmptyOne:Bool{
        guard case .empty = self else { return false }
        return true
    }
    
    public static func == (lhs:MultiImageTableCellSlot,rhs:MultiImageTableCellSlot) -> Bool{
        if case .empty = lhs, case .empty = rhs{
            return true
        }else if case .image(let lhsImage) = lhs, case .image(let rhsImage) = rhs{
            let lhsImageData = UIImagePNGRepresentation(lhsImage)
            let rhsImageData = UIImagePNGRepresentation(rhsImage)
            return lhsImageData == rhsImageData
        }else if case .url(let lhsURL) = lhs, case .url(let rhsURL) = rhs{
            return lhsURL == rhsURL
        }else{
            return false
        }
    }
}
