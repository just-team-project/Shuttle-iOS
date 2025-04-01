//
//  UIFont+Extension.swift
//  Shuttle_iOS
//
//  Created by 강대훈 on 3/30/25.
//

import UIKit

// TODO: - 추후에 에러처리로 바꿔야할지 고민중.
extension UIFont {
    static func pretendardBlack(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Black", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func pretendardBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func pretendardExtraBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-ExtraBold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func pretendardExtraLight(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-ExtraLight", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func pretendardLight(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func pretendardMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func pretendardRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func pretendardSemiBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func pretendardThin(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Thin", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
