//
//  UIFontExtension.swift
//  OkCupid
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

import UIKit

public extension UIFont {
    // MARK: - Font Registration
    
    static func helvetica(_ size: CGFloat) -> UIFont {
        UIFont(name: "HelveticaNeue",
               size: size)!
    }
    
    static func helveticaBold(_ size: CGFloat) -> UIFont {
        UIFont(name: "HelveticaNeue-Bold",
               size: size)!
    }
}
