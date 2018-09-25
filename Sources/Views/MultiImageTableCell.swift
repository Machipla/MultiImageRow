//
//  MultiImageTableCell.swift
//  PetSpotCoreUI
//
//  Created by Mario Chinchilla on 6/6/18.
//  Copyright © 2018 Machipla. All rights reserved.
//

import UIKit
import AlamofireImage
import Eureka

public final class MultiImageTableCell: Cell<[MultiImageTableCellSlot]>, CellType, UICollectionViewDelegate, UICollectionViewDataSource{
    @IBOutlet public private(set) weak var collectionView:UICollectionView!
    @IBOutlet public private(set) weak var titleLabel:UILabel!

    weak var delegate:MultiImageTableCellDelegate?
    public var slotCellType:MultiImageTableCell.SlotCellType = .default{
        didSet{ updateSlotCellType() }
    }
    public var placeholderImage:UIImage?
    public var slots = [MultiImageTableCellSlot](){
        didSet{ collectionView.reloadData() }
    }
    
    private static let SlotCellReuseIdentifier = "SlotCellReuseIdentifier"

    public override func awakeFromNib() {
        super.awakeFromNib()
        updateSlotCellType()
    }
    
    // MARK: UICollectionViewDelegate & UICollectionViewDataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return slots.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        guard let imageCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: MultiImageTableCell.SlotCellReuseIdentifier, for: indexPath) as? MultiImageTableCellSlotCell else{
            fatalError("MultiImageTableCell SlotCell is not conforming protocol MultiImageTableCellSlotCell!")
        }
        
        draw(imageCollectionCell, at: indexPath.item)
        return imageCollectionCell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let slot = slots[safe: indexPath.row] else { return }
        delegate?.multiImageTableCell(self, hasSelected: slot, at: indexPath.item)
    }
}

private extension MultiImageTableCell{
    func draw(_ cell:MultiImageTableCellSlotCell, at index:Int){
        cell.placeholderImageView.image = placeholderImage
        
        if let slot = slots[safe: index] {
            switch slot {
            case .image(let image):
                cell.imageView.image = image
                self.delegate?.multiImageTableCell(self, hasLoaded: image, at: index)
            case .url(let URL):
                cell.imageView.af_setImage(withURL: URL, placeholderImage: nil) { [weak self] imageDownload in
                    guard let strongSelf = self, let downloadedImage = cell.imageView.image else { return }
                    strongSelf.delegate?.multiImageTableCell(strongSelf, hasLoaded: downloadedImage, at: index)
                }
            case .empty:
                cell.imageView.image = nil
                self.delegate?.multiImageTableCell(self, hasClearedImageAt: index)
            }
        }
    }
    
    func updateSlotCellType(reloadingData:Bool = true){
        switch slotCellType{
        case .default:
            let nib = UINib(nibName: SingleImageCollectionCell.nibName, bundle: ModuleBundles.resourcesBundle)
            collectionView.register(nib, forCellWithReuseIdentifier: MultiImageTableCell.SlotCellReuseIdentifier)
        case .customNib(let nib):
            collectionView.register(nib, forCellWithReuseIdentifier: MultiImageTableCell.SlotCellReuseIdentifier)
        case .customClass(let cellClass):
            collectionView.register(cellClass, forCellWithReuseIdentifier: MultiImageTableCell.SlotCellReuseIdentifier)
        }
        
        if reloadingData{ collectionView.reloadData() }
    }
}

public extension MultiImageTableCell{
    subscript (image index:Int) -> UIImage?{
        guard let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? SingleImageCollectionCell else { return nil }
        return cell.imageView.image
    }
}
