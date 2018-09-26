//
//  MultiImageRow.swift
//  PetSpotCoreUI
//
//  Created by Mario Chinchilla on 6/6/18.
//  Copyright © 2018 Machipla. All rights reserved.
//

import Foundation
import Eureka
import ImagePickerCoordinator

public final class MultiImageRow: Row<MultiImageTableCell>, RowType{
    public typealias SelectHandler = ((MultiImageRow,UIImage,Int) -> Void)
    public typealias URLSelectHandler = ((MultiImageRow,URL,UIImage?,Int) -> Void)

    private var imageSelectedHandler:SelectHandler?
    private var imageURLSelectedHandler:URLSelectHandler?
    
    public override var value: [MultiImageTableCellSlot]?{
        get{ return cell.slots }
        set{ cell.slots = newValue?.filter{ return !$0.isAnEmptyOne } ?? [] }
    }
    
    public var descriptionTitle:String?{
        get{ return cell.titleLabel.text }
        set{ cell.titleLabel.text = newValue }
    }
    
    public var slotCellType:MultiImageTableCell.SlotCellType{
        get{ return cell.slotCellType }
        set{ cell.slotCellType = newValue }
    }
    
    public required init(tag: String?) {
        super.init(tag: tag)
        
        cellProvider = CellProvider<MultiImageTableCell>(nibName: MultiImageTableCell.nibName, bundle: ModuleBundles.resourcesBundle)
        cell.delegate = self
    }
    
    public convenience init(tag: String? = nil, initializer: ((MultiImageRow) -> Void) = { _ in }){
        self.init(tag, initializer)
    }
    
    public func onImageSelected(_ handler:@escaping SelectHandler) -> Self{
        imageSelectedHandler = handler
        return self
    }
    
    public func onURLImageSelected(_ handler:@escaping URLSelectHandler) -> Self{
        imageURLSelectedHandler = handler
        return self
    }
}

extension MultiImageRow: MultiImageTableCellDelegate{
    public func multiImageTableCell(_ cell: MultiImageTableCell, hasSelected slot:MultiImageTableCellSlot, at index: Int) {
        guard !slot.isAnEmptyOne else { return }
        
        if case .image(let image) = slot{
            imageSelectedHandler?(self,image,index)
        }else if case .url(let URL) = slot{
            imageURLSelectedHandler?(self,URL,cell[image: index],index)
        }
    }
}
