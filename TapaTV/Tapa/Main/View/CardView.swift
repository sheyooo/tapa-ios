//
//  CardView.swift
//  TapaTV
//
//  Created by SimpuMind on 6/17/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit

@IBDesignable
class CardView: UIView {
    
    @IBInspectable var corneradius: CGFloat = 5
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 2
    @IBInspectable var shadowcolor: UIColor? = .black
    @IBInspectable var shadowopacity: Float = 0.3
    
    override func layoutSubviews() {
        layer.cornerRadius = corneradius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: corneradius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowcolor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowopacity
        layer.shadowPath = shadowPath.cgPath
    }
    
}
