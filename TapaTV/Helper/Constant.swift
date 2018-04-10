//
//  Constant.swift
//  TapaTV
//
//  Created by SimpuMind on 3/18/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import Foundation
import UIKit
import KeychainAccess

public class Constant {
    static let BASE_URL = "https://tapa-api.herokuapp.com/api/v1/"
    static let LOGIN = "users/login"
    static let SIGNUP = "users"
    
    public static let keychain = Keychain(service: "com.simpumind.tapatv")
    public static func isCompact(view: UIView, yes: CGFloat, no: CGFloat) -> CGFloat{
        return (!AppDelegate.isiPad()) ? yes : no
    }
    
    public static func isIphoneX() -> Bool {
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height == 2436 {
                return true
            }
        }
        return false
    }
}

struct AppUtility {
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
    }
    
}
