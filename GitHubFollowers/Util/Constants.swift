//
//  Constants.swift
//  GitHubFollowers
//
//  Created by SreySros on 27/8/22.
//

import UIKit

enum ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let hieght = UIScreen.main.bounds.size.height
    static let maxLength = max(ScreenSize.width, ScreenSize.hieght)
    static let minLenght = min(ScreenSize.width, ScreenSize.hieght)
}

enum DeviceType {
    static let idiom = UIDevice.current.userInterfaceIdiom
    static let nativeScale = UIScreen.main.nativeScale
    static let scale = UIScreen.main.scale
    
    static let isIphoneSE = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isIphone8Zoomed = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isIphone8PlusStandard = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isIphoneX = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isIphoneXsMaxAndXr = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isIpad = idiom == .pad && ScreenSize.maxLength >= 1024.0
    
    static func isiPhoneXAspectRatio() -> Bool {
        return isIphoneX || isIphoneXsMaxAndXr
    }
}
