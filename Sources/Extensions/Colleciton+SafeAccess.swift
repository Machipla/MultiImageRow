//
//  MultiImagePickerRow.swift
//  PetSpotCoreUI
//
//  Created by Mario Chinchilla on 6/6/18.
//  Copyright © 2018 Machipla. All rights reserved.
//

import Foundation

internal extension Collection{
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Iterator.Element? {
        get{ return indices.contains(index) ? self[index] : nil }
    }
    
    subscript(safe bounds:Range<Self.Index>) -> Self.SubSequence?{
        return self[safe:bounds.lowerBound...bounds.upperBound]
    }
    
    subscript(safe bounds:ClosedRange<Self.Index>) -> Self.SubSequence?{
        guard !isEmpty else { return nil }
        
        let safeLowerBound = bounds.lowerBound >= startIndex ? bounds.lowerBound : startIndex
        let safeUpperBound = bounds.upperBound < endIndex ? bounds.upperBound : endIndex
        return self[safeLowerBound..<safeUpperBound]
    }
}
