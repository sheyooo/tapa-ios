//
//  GradientView.swift
//  TapaTV
//
//  Created by SimpuMind on 3/16/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit

@IBDesignable
open class GradientView: UIView {
    @IBInspectable
    public var startColor: UIColor = .white {
        didSet {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            setNeedsDisplay()
        }
    }
    @IBInspectable
    public var endColor: UIColor = .white {
        didSet {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    public var multipleEndColor: [UIColor] = [.white, .white] {
        didSet {
            gradientLayer.colors = multipleEndColor.flatMap {return $0.cgColor}
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    public var startPoint: CGPoint = CGPoint(x: 0.0, y: 1.0) {
        didSet{
            gradientLayer.startPoint = startPoint
        }
    }
    
    @IBInspectable
    public var endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0) {
        didSet{
            gradientLayer.endPoint = endPoint
        }
    }
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [self.startColor.cgColor, self.endColor.cgColor]
        return gradientLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}

