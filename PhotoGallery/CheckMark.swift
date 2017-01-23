//
//  CheckMark.swift
//  PhotoGallery
//
//  Created by Syafiq Mastor on 1/20/17.
//  Copyright © 2017 Syafiq Mastor. All rights reserved.
//

import UIKit

enum CheckMarkStyle {
    case openCircle
    case grayedOut
}

class CheckMark: UIView {
    
    var checked : Bool?
    var checkMarkStyle : CheckMarkStyle?

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if self.checked! {
            self.drawRectChecked(rect: rect)
        } else {
            if self.checkMarkStyle == CheckMarkStyle.openCircle {
                self.drawRectOpenCircle(rect: rect)
            } else if self.checkMarkStyle == CheckMarkStyle.grayedOut {
                self.drawRectGreyedOut(rect: rect)
            }
        }
    }
    
    
    func setChecked(checked : Bool) {
        self.checked = checked
        self.setNeedsDisplay()
    }
    
    func setCheckMarkStyle(checkMarkStyle : CheckMarkStyle) {
        self.checkMarkStyle = checkMarkStyle
        self.setNeedsDisplay()
    }

    func drawRectChecked(rect : CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        // set color
        let checkMarkBlue2 = UIColor(red: 0.078, green: 0.435, blue: 0.875, alpha: 1)
        
        // declare shadow color
        let shadow2 = UIColor.black
        let shadow2Offset = CGSize(width: 0.1, height: -0.1)
        let shadow2BlurRadius = 2.5
        
        // frames
        let frame = self.bounds
        
        // subframe
        let group  = CGRect(x: frame.minX + 3, y: frame.minY + 3, width: frame.width - 9, height: frame.height - 9)

        //create oval
        let checkedOvalPath = UIBezierPath(ovalIn: CGRect(x: group.minX + floor(group.width * 0.00000 + 5),
                                                          y: group.minY + floor(group.height * 0.00000 + 0.5),
                                                          width: floor(group.width * 1.00000 + 0.5) - floor(group.width * 0.00000 + 0.5),
                                                          height: floor(group.height * 1.00000 + 0.5) - floor(group.height * 0.00000 + 0.5)))
        
        _ = CGContext.saveGState(context!)
        context?.setShadow(offset: shadow2Offset, blur: CGFloat(shadow2BlurRadius), color: shadow2.cgColor)
        checkMarkBlue2.setFill()
        checkedOvalPath.fill()
        _ = CGContext.restoreGState(context!)
        UIColor.white.setStroke()
        
        checkedOvalPath.lineWidth = 1
        checkedOvalPath.stroke()
        
        
        /// draw checkmark
        let bezierPath = UIBezierPath()
        
        bezierPath.move(to: CGPoint(x: group.minX + 0.37083 * group.width,
                                    y: group.minY + 0.54167 * group.height))
        bezierPath.addLine(to: CGPoint(x: group.minX + 0.51667 * group.width,
                                       y: group.minY + 0.68750 * group.height))
        bezierPath.addLine(to: CGPoint(x: group.minX + 0.85000 * group.width,
                                       y: group.minY + 0.35417 * group.height))
        bezierPath.lineCapStyle = CGLineCap.square
        
        UIColor.white.setStroke()
        bezierPath.lineWidth = 1.3
        bezierPath.stroke()
        
    }
    
    func drawRectGreyedOut(rect : CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        
        //set color
        let grayTranslucent = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        
        //set shadow
        let shadow = UIColor.black
        let shadowOffset = CGSize(width: 0.1, height: -0.1)
        
        let shadowBlurRadius : CGFloat = 2.5
        
        //frame
        let frame = self.bounds
        
        let group = CGRect(x: frame.minX, y: frame.minY + 3, width: frame.width - 9, height: frame.height - 9)
        
        
        // draw circle
        let unCheckedOvalPath = UIBezierPath(ovalIn: CGRect(x: group.minX + floor(group.width * 0.00000 + 5),
                                                          y: group.minY + floor(group.height * 0.00000 + 0.5),
                                                          width: floor(group.width * 1.00000 + 0.5) - floor(group.width * 0.00000 + 0.5),
                                                          height: floor(group.height * 1.00000 + 0.5) - floor(group.height * 0.00000 + 0.5)))
        
        _ = CGContext.saveGState(context!)
    
        context?.setShadow(offset: shadowOffset, blur: CGFloat(shadowBlurRadius), color: shadow.cgColor)
        grayTranslucent.setFill()
        unCheckedOvalPath.fill()
        
        _ = CGContext.restoreGState(context!)
        
        UIColor.white.setStroke()
        
        unCheckedOvalPath.lineWidth = 1
        unCheckedOvalPath.stroke()
        
        
        /// draw checkmark
        let bezierPath = UIBezierPath()
        
        
        bezierPath.move(to: CGPoint(x: group.minX + 0.37083 * group.width,
                                    y: group.minY + 0.54167 * group.height))
        bezierPath.addLine(to: CGPoint(x: group.minX + 0.51667 * group.width,
                                       y: group.minY + 0.68750 * group.height))
        bezierPath.addLine(to: CGPoint(x: group.minX + 0.85000 * group.width,
                                       y: group.minY + 0.35417 * group.height))
        bezierPath.lineCapStyle = CGLineCap.square
        
        UIColor.white.setStroke()
        bezierPath.lineWidth = 1.3
        bezierPath.stroke()

        
    }
    
    //Not used 
    
    func drawRectOpenCircle(rect : CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        
        let shadow = UIColor.black
        let shadowOffset = CGSize(width: 0.1, height: -0.1)
        
        let shadowBlurRadius : CGFloat = 0.5
        let shadow2 = UIColor.black
        let shadow2Offset = CGSize(width: 0.1, height: -0.1)
        
        let shadow2BlurRadius : CGFloat = 2.5
        
        let frame = self.bounds
        
        let group = CGRect(x: frame.minX + 3, y: frame.minY + 3, width: frame.width - 6, height: frame.height - 6)
        
        let emptyOvalPath = UIBezierPath(ovalIn: CGRect(x: group.minX + floor(group.width * 0.00000 + 5),
                                                            y: group.minY + floor(group.height * 0.00000 + 0.5),
                                                            width: floor(group.width * 1.00000 + 0.5) - floor(group.width * 0.00000 + 0.5),
                                                            height: floor(group.height * 1.00000 + 0.5) - floor(group.height * 0.00000 + 0.5)))
        
        _ = CGContext.saveGState(context!)
        context?.setShadow(offset: shadow2Offset, blur: CGFloat(shadow2BlurRadius), color: shadow2.cgColor)
        _ = CGContext.restoreGState(context!)
        
        
        _ = CGContext.saveGState(context!)
        context?.setShadow(offset: shadowOffset, blur: CGFloat(shadowBlurRadius), color: shadow.cgColor)
        UIColor.white.setStroke()
        emptyOvalPath.lineWidth = 1
        emptyOvalPath.stroke()
        _ = CGContext.restoreGState(context!)
    }
    
}

