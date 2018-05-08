//
//  Extension.swift
//  TapaTV
//
//  Created by SimpuMind on 3/15/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import Foundation
import UIKit

let primaryColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2666666667, alpha: 1)

protocol MaterialView {
    func elevate(elevation: Double, shadowColor: UIColor, cornerRadius: CGFloat?)
}

extension UIView {
    func center(in view: UIView) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func fill(_ view: UIView, offset: CGFloat = 0.0) {
        leftAnchor.align(to: view.leftAnchor, offset: offset)
        rightAnchor.align(to: view.rightAnchor, offset: offset)
        topAnchor.align(to: view.topAnchor, offset: offset)
        bottomAnchor.align(to: view.bottomAnchor, offset: offset)
    }
    
    func fillLeftRightBottom(_ view: UIView, bottomView: UIView, bottomOffset: CGFloat, offset: CGFloat, height: CGFloat) {
        leftAnchor.align(to: view.leftAnchor, offset: offset)
        rightAnchor.align(to: view.rightAnchor, offset: offset)
        bottomAnchor.align(to: bottomView.bottomAnchor, offset: bottomOffset)
        heightAnchor.equal(to: height)
    }
    
    func fillLeftRightTop(_ view: UIView, topView: UIView, topOffset: CGFloat, offset: CGFloat, height: CGFloat) {
        leftAnchor.align(to: view.leftAnchor, offset: offset)
        rightAnchor.align(to: view.rightAnchor, offset: offset)
        topAnchor.align(to: topView.topAnchor, offset: topOffset)
        heightAnchor.equal(to: height)
    }
    func fillLeftTopWidthHeight(_ view: UIView, topView: UIView, topOffset: CGFloat, offset: CGFloat, height: CGFloat, width: CGFloat) {
        leftAnchor.align(to: view.leftAnchor, offset: offset)
        widthAnchor.equal(to: width)
        topAnchor.align(to: topView.bottomAnchor, offset: topOffset)
        heightAnchor.equal(to: height)
    }
    
    func fillRightTopWidthHeight(_ view: UIView, topView: UIView, topOffset: CGFloat, offset: CGFloat, height: CGFloat, width: CGFloat) {
        rightAnchor.align(to: view.rightAnchor, offset: -offset)
        widthAnchor.equal(to: width)
        topAnchor.align(to: topView.bottomAnchor, offset: topOffset)
        heightAnchor.equal(to: height)
    }
    
    func fillTopLeftRightHeightCenterX(_ view: UIView, topView: UIView, topOffset: CGFloat, offest: CGFloat, height: CGFloat) {
        topAnchor.align(to: topView.bottomAnchor, offset: topOffset)
        leftAnchor.align(to: view.leftAnchor, offset: offest)
        rightAnchor.align(to: view.rightAnchor, offset: -offest)
        heightAnchor.equal(to: height)
        centerXAnchor.align(to: view.centerXAnchor)
    }
    
    func fillTopWidthHeightCenterX(_ view: UIView, topView: UIView, topOffset: CGFloat, height: CGFloat,  width: CGFloat) {
        topAnchor.align(to: topView.bottomAnchor, offset: topOffset)
        heightAnchor.equal(to: height)
        widthAnchor.equal(to: width)
        centerXAnchor.align(to: view.centerXAnchor)
    }
    
    func fillTopWidthHeightCenterY(_ view: UIView,topView: UIView, topOffset: CGFloat, height: CGFloat,  width: CGFloat) {
        topAnchor.align(to: topView.bottomAnchor, offset: topOffset)
        heightAnchor.equal(to: height)
        widthAnchor.equal(to: width)
        centerYAnchor.align(to: view.centerYAnchor)
    }
    
    func fillParentLeftWidthHeightCenterX(_ view: UIView,leftView: UIView, topOffset: CGFloat, height: CGFloat,  width: CGFloat) {
        leftAnchor.align(to: leftView.leftAnchor, offset: topOffset)
        heightAnchor.equal(to: height)
        widthAnchor.equal(to: width)
        centerXAnchor.align(to: view.centerXAnchor)
    }
    
    func fillBottomWidthHeightCenterX(_ view: UIView, bottomView: UIView, bottomOffset: CGFloat, height: CGFloat,  width: CGFloat) {
        bottomAnchor.align(to: bottomView.bottomAnchor, offset: bottomOffset)
        heightAnchor.equal(to: height)
        widthAnchor.equal(to: width)
        centerXAnchor.align(to: view.centerXAnchor)
    }
    
    func fillBottomWidthHeightCenterY(_ view: UIView, bottomView: UIView, bottomOffset: CGFloat, height: CGFloat,  width: CGFloat) {
        bottomAnchor.align(to: bottomView.bottomAnchor, offset: bottomOffset)
        heightAnchor.equal(to: height)
        widthAnchor.equal(to: width)
        centerYAnchor.align(to: view.centerYAnchor)
    }
}
extension NSLayoutDimension {
    func align(to anchor: NSLayoutDimension, offset: CGFloat = 0.0) {
        constraint(equalTo: anchor, multiplier: 1.0, constant: offset).isActive = true
    }
    func equal(to value: CGFloat) {
        constraint(equalToConstant: value).isActive = true
    }
}
extension NSLayoutXAxisAnchor {
    func align(to anchor: NSLayoutXAxisAnchor, offset: CGFloat = 0.0) {
        constraint(equalTo: anchor, constant: offset).isActive = true
    }
}
extension NSLayoutYAxisAnchor {
    func align(to anchor: NSLayoutYAxisAnchor, offset: CGFloat = 0.0) {
        constraint(equalTo: anchor, constant: offset).isActive = true
    }
}

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UITextField {
    func setPadding(){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setUnderline(color: UIColor) {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}



extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
}

extension UIImage {
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
}

extension UIView: MaterialView {
    func elevate(elevation: Double, shadowColor: UIColor, cornerRadius: CGFloat?) {
        self.layer.masksToBounds = true
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: elevation)
        self.layer.shadowOpacity = 2.24
        self.layer.cornerRadius = cornerRadius ?? 0
        self.layer.shadowRadius = abs(CGFloat(elevation))
    }
}


extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension TimeInterval {
    private var milliseconds: Int {
        return Int((truncatingRemainder(dividingBy: 1)) * 1000)
    }
    
    public var seconds: Int {
        return Int(self) % 60
    }
    
    private var minutes: Int {
        return (Int(self) / 60 ) % 60
    }
    
    private var hours: Int {
        return Int(self) / 3600
    }
    
    var stringTime: String {
        if hours != 0 {
            return "\(hours)h \(minutes)m \(seconds)s"
        } else if minutes != 0 {
            return "\(minutes)m \(seconds)s"
        } else if milliseconds != 0 {
            return "\(seconds)s \(milliseconds)ms"
        } else {
            return "\(seconds)s"
        }
    }
}

extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String, font: UIFont, textColor: UIColor) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: font, .foregroundColor: textColor]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String, font: UIFont, textColor: UIColor) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: font, .foregroundColor: textColor]
        let normal = NSAttributedString(string: text, attributes: attrs)
        append(normal)
        
        return self
    }
}

class ButtonWithImage: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 65), bottom: 5, right: 5)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView?.frame.width)! + 40)
        }
    }
}

