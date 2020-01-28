//
//  GlobalTheme.swift
//  OkCupid
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

import ThemeManager
import UIKit

private extension ThemeColorPalette {
    var color: UIColor {
        switch self {
        case .white: return .white
        case .grey100: return .color(fromHex: "#ebecf2")    
        case .grey300: return .color(fromHex: "#9c9b9e")
        case .black: return .color(fromHex: "#50555d")
        case .primary: return .color(fromHex: "#4b7bd9")
        case .error: return .color(fromHex: "#EF0A00")
        case .success: return .color(fromHex: "#45e588")
        }
    }
}

private extension ThemeFontAttribute {
    func serif(withSize size: CGFloat = UIFont.labelFontSize) -> UIFont {
        switch self {
        case .regular: return .helvetica(size)
        case .bold: return .helveticaBold(size)
        }
    }
    
    func sans(withSize size: CGFloat = UIFont.labelFontSize) -> UIFont {
        switch self {
        case .regular: return .helvetica(size)
        case .bold: return .helveticaBold(size)
        }
    }
}

private extension ThemeFontStyle {
    var fontSize: CGFloat {
        switch self {
        case .small: return 11
        case .title: return 16
        case .subtitle: return 15
        case .navigationTitle: return 20
        }
    }
    
    var font: UIFont {
        switch self {
        case .small, .subtitle, .title, .navigationTitle:
            return attribute.sans(withSize: fontSize)
        }
    }
    
    var kern: CGFloat {
        switch self {
        case .title, .navigationTitle: return 1.18
        case .small, .subtitle:
            return 0
        }
    }
}

class GlobalTheme: ThemeProtocol {
    lazy var appearanceRules: AppearanceRuleSet = {
        let isRegularRegular = UIScreen.main.traitCollection.verticalSizeClass == .regular &&
            UIScreen.main.traitCollection.horizontalSizeClass == .regular
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [
            NSAttributedString.Key.foregroundColor: color(forColorPalette: .black),
            NSAttributedString.Key.font: font(forStyle: .subtitle(attribute: .regular))
        ]
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = color(forColorPalette: .black)
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: color(forColorPalette: .black),
            NSAttributedString.Key.font: font(forStyle: .subtitle(attribute: .regular))
        ], for: .normal)
        
        return AppearanceRuleSet {
                PropertyAppearanceRule<UINavigationBar, UIColor?>(keypath: \.tintColor, value: color(forColorPalette: .primary))
                UINavigationBar[\.barTintColor, color(forColorPalette: .primary)]
                UINavigationBar[\.titleTextAttributes, [
                    NSAttributedString.Key.foregroundColor: color(forColorPalette: .white),
                    NSAttributedString.Key.font: font(forStyle: .navigationTitle(attribute: .bold))
                ]]
        }
    }()
    
    func color(forColorPalette colorPalette: ThemeColorPalette) -> UIColor {
        return colorPalette.color
    }
    
    func font(forStyle style: ThemeFontStyle) -> UIFont {
        return style.font
    }
    
    func fontSize(forStyle style: ThemeFontStyle) -> CGFloat {
        return style.fontSize
    }
    
    func kern(forStyle style: ThemeFontStyle) -> CGFloat {
        return style.kern
    }
    
    @discardableResult
    func configure(label: UILabel,
                   withStyle style: ThemeFontStyle,
                   customizing: ((UILabel, ThemeProtocol) -> Void)?) -> UILabel {
        label.font = style.font
        label.textColor = color(forColorPalette: .black)
        
        customizing?(label, self)
        
        return label
    }
}
