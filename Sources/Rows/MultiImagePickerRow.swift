//
//  MultiImagePickerRow.swift
//  PetSpotCoreUI
//
//  Created by Mario Chinchilla on 6/6/18.
//  Copyright © 2018 Machipla. All rights reserved.
//

import Foundation
import Eureka
import ImagePickerCoordinator

public final class MultiImagePickerRow: Row<MultiImageTableCell>, RowType{
    public typealias SelectHandler = ((MultiImagePickerRow,UIImage,Int) -> Void)
    
    private var fromControllerProvider:MultiImagePickerRow.FromControllerProvider = .topMost
    private var imagePickerCoordinators = [ImagePickerCoordinator]()
    
    /// Returns the images displayed on the cell either if they were selected by the user or not. It is nil if there is no image displayed on the slot.
    public var images:[UIImage?]{
        return imagePickerCoordinators.map{ return $0.selectedImage }
    }
    
    // Returns only the images that has been explicitly picked by the user.
    /// They are ordered as they are in the cell managed by this row and if an index is nil means that no user selection has been made on it.
    public var userPickedImages:[UIImage?]{
        return imagePickerCoordinators.map{ return $0.userSelectedImage }
    }
    
    // Returns the last selection, index-ordered in the same way as the cells are.
    public var lastUserSelections:[ImagePickerCoordinator.UserSelection]{
        return imagePickerCoordinators.map{ return $0.lastUserSelection }
    }
    
    public override var value: [MultiImageTableCellSlot]?{
        get{ return cell.slots }
        set{
            cell.slots = newValue ?? []
            updateImagePickersForCurrentValue()
        }
    }
    
    public var placeholderImage:UIImage?{
        get{ return cell.placeholderImage }
        set{ cell.placeholderImage = newValue }
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
    
    public convenience init(tag: String? = nil, fromController:MultiImagePickerRow.FromControllerProvider = .topMost, initializer: ((MultiImagePickerRow) -> Void) = { _ in }){
        self.init(tag, initializer)
        self.fromControllerProvider = fromController
        updateImagePickersForCurrentValue()
    }
}

private extension MultiImagePickerRow{
    func updateImagePickersForCurrentValue(){
        guard let value = value else { return }
        
        if imagePickerCoordinators.count > value.count, let coordinatorsSubarray = imagePickerCoordinators[safe: 0...value.count]{
            imagePickerCoordinators = Array(coordinatorsSubarray)
        }else if imagePickerCoordinators.count < value.count{
            let coordinatorsToAddCount = value.count - imagePickerCoordinators.count
            let toAddCoordinators:[ImagePickerCoordinator] = (0...coordinatorsToAddCount).map{ _ in
                let imagePickerCoordinator = ImagePickerCoordinator(fromController: .specific(fromControllerProvider.providedController))
                imagePickerCoordinator.delegate = self
                return imagePickerCoordinator
            }
            
            imagePickerCoordinators += toAddCoordinators
        }
    }
    
    func updateImageOnPicker(_ image:UIImage?, at index:Int){
        imagePickerCoordinators[safe: index]?.selectedImage = image
    }
}

extension MultiImagePickerRow: MultiImageTableCellDelegate{
    public func multiImageTableCell(_ cell: MultiImageTableCell, hasSelected slot:MultiImageTableCellSlot, at index: Int) {
        imagePickerCoordinators[safe: index]?.start()
    }
    
    public func multiImageTableCell(_ cell:MultiImageTableCell, hasLoaded image:UIImage, at index:Int){
        updateImageOnPicker(image, at: index)
    }
    
    public func multiImageTableCell(_ cell:MultiImageTableCell, hasClearedImageAt index:Int){
        updateImageOnPicker(nil, at: index)
    }
}

extension MultiImagePickerRow: ImagePickerCoordinatorDelegate{
    public func imagePickerCoordinator(_ coordinator:ImagePickerCoordinator, hasSelected image:UIImage){
        guard let selectedIndex = imagePickerCoordinators.index(of: coordinator) else { return }
        value?[selectedIndex] = .image(image)
    }
    
    public func imagePickerCoordinator(_ coordinator:ImagePickerCoordinator, hasClearedSelectedImage image:UIImage){
        guard let selectedIndex = imagePickerCoordinators.index(of: coordinator) else { return }
        value?[selectedIndex] = .empty
    }
}
