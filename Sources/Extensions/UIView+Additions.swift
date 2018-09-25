//
//  UIView+Additions.swift
//  MultiImageRow
//
//  Created by Mario Plaza on 24/9/18.
//

import Foundation

internal extension UIView {
    static var reuseIdentifier:String{ return "\(self)Id" }
    static var nibName:String{ return "\(self)".components(separatedBy: ".").first ?? "" }
}
