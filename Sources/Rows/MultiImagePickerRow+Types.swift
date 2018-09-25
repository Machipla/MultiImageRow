//
//  MultiImagePickerRow+Types.swift
//  MultiImageRow
//
//  Created by Mario Plaza on 24/9/18.
//

import Foundation

public extension MultiImagePickerRow{
    public enum FromControllerProvider{
        case topMost
        case specific(UIViewController)
        case byHandler(() -> UIViewController)
        
        var providedController:UIViewController{
            switch self {
            case .topMost:                  return UIApplication.shared.topMostViewController!
            case .specific(let controller): return controller
            case .byHandler(let handler):   return handler()
            }
        }
    }
}
