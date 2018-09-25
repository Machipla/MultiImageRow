//
//  MultiImageRowConstants.swift
//  MultiImageRow
//
//  Created by Mario Plaza on 24/9/18.
//

import Foundation

internal enum ModuleBundles{
    static let general = Bundle(for: DummyBundleProvider.self)
    static let resourcesBundle = Bundle(url: ModuleBundles.general.url(forResource: "MultiImageRow", withExtension: "bundle")!)!
    
    private final class DummyBundleProvider{}
}
