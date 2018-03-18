//
//  Constant.swift
//  TapaTV
//
//  Created by SimpuMind on 3/18/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import Foundation
import UIKit

public class Constant {
    public static func isCompact(view: UIView, yes: CGFloat, no: CGFloat) -> CGFloat{
        return (!AppDelegate.isiPad()) ? yes : no
    }
}
