//
//  UIFont+.swift
//  Behance-iOS
//
//  Created by 김혜수 on 2022/05/16.
//

import UIKit

// 타입, 크기 직접 지정
extension UIFont {
    public enum NotoSansType: String {
        case bold = "Bold"
        case regular = "Regular"
        case medium = "Medium"
    }
    
    static func NotoSans(_ type: NotoSansType, size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSans-\(type.rawValue)", size: size)!
    }
}

// 스타일가이드
extension UIFont {
    
    class var behanceH1: UIFont {
        return UIFont.NotoSans(.bold, size: 16)
    }
    
    class var behanceH2: UIFont {
        return UIFont.NotoSans(.regular, size: 14)
    }
    
    class var behanceH3: UIFont {
        return UIFont.NotoSans(.medium, size: 13)
    }
    
    class var behanceH4: UIFont {
        return UIFont.NotoSans(.regular, size: 11)
    }
}
