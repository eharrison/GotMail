//
//  UIView+Layers.swift
//  MV UI Hacks
//
//  Created by Evandro Harrison Hoffmann on 07/07/2016.
//  Copyright © 2016 It's Day Off. All rights reserved.
//

import UIKit

extension UIView{
    
    // MARK: - Gradient
    
    public func addGradientLayer(_ topColor: UIColor, bottomColor: UIColor){
        //remove sublayers
        if let sublayers = layer.sublayers {
            for sublayer in sublayers {
                if let gradientLayer = sublayer as? CAGradientLayer {
                    gradientLayer.removeFromSuperlayer()
                }
            }
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: - Hexagonal
    
    public func addHexagonalMask(_ rotateAngle: CGFloat){
        let path = UIBezierPath(roundedPolygonPathWithRect:self.bounds, lineWidth: 10, sides: 6, cornerRadius: 30)
        if rotateAngle != 0 {
            let box = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            
            var translate = CGAffineTransform(translationX: -1 * (box.origin.x + (box.size.width / 2)), y: -1 * (box.origin.y + (box.size.height / 2)))
            path.apply(translate)
            
            let rotate = CGAffineTransform(rotationAngle: rotateAngle)
            path.apply(rotate)
            
            translate = CGAffineTransform(translationX: (box.origin.x + (box.size.width / 2)), y: (box.origin.y + (box.size.height / 2)));
            path.apply(translate)
        }
        
        let mask = CAShapeLayer()
        mask.path            = path.cgPath
        mask.lineWidth       = 0
        mask.strokeColor     = UIColor.clear.cgColor
        mask.fillColor       = UIColor.white.cgColor
        
        //shadow
        mask.shadowOffset = CGSize(width: 0, height: 1)
        mask.shadowColor = UIColor.black.cgColor
        mask.shadowRadius = 1
        mask.shadowOpacity = 0.25
        mask.shadowPath = path.cgPath
        
        self.layer.mask = mask
        self.layer.masksToBounds = true
    }
    
    // MARK: - Triangle 
    
    public func addTringleView(_ rect: CGRect, fillColor: UIColor) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.closePath()
        
        context.setFillColor(fillColor.cgColor)
        context.fillPath()
    }
    
    
}

// MARK: - Animations

extension UIView{
    
    public func animateShowPopingUp(duration: Double = 0.4, scaleIn: CGFloat = 0.1, scaleOut: CGFloat = 1.05, alphaIn: CGFloat = 0, _ completion:(() -> Void)? = nil){
        isHidden = false
        alpha = alphaIn
        transform = CGAffineTransform(scaleX: scaleIn, y: scaleIn)
        
        UIView.animate(withDuration: duration*0.7, animations: {
            self.transform = CGAffineTransform(scaleX: scaleOut, y: scaleOut)
            self.alpha = 1
        }, completion: { (didComplete) in
            //if didComplete {
            UIView.animate(withDuration: duration*0.3, animations: {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: { (didComplete) in
                //if didComplete {
                completion?()
                //}
            })
            //}
        })
    }
    
    public func animateFadeInUp(duration: Double = 0.3, alphaIn: CGFloat = 0, _ completion:(() -> Void)? = nil){
        self.alpha = alphaIn
        
        let center = self.center
        self.center = CGPoint(x: self.center.x, y: self.superview!.frame.size.height)
        
        UIView.animate(withDuration: duration, animations: {
            self.center = center
            self.alpha = 1
        }, completion: { (didComplete) in
            //if didComplete {
            completion?()
            //}
        })
    }
    
    public func animateFadeIn(duration: Double = 0.3, alphaIn: CGFloat = 0, _ completion:(() -> Void)? = nil){
        self.alpha = alphaIn
        
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        }, completion: { (didComplete) in
            //if didComplete {
            completion?()
            //}
        })
    }
    
    public func animateFadeOut(duration: Double = 0.3, _ completion:(() -> Void)? = nil){
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }, completion: { (didComplete) in
            //if didComplete {
            completion?()
            //}
        })
    }
    
    public func animateFadeAway(_ completion:(() -> Void)? = nil){
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { (didComplete) in
            //if didComplete {
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.alpha = 0
            }, completion: { (didComplete) in
                //if didComplete {
                self.isHidden = true
                completion?()
                //}
            })
            //}
        })
    }
    
    public func animateTouchDown(duration: Double = 0.1, durationOut: Double = 0.2, scaleIn: CGFloat = 0.9, alphaIn: CGFloat = 0.9, autoAnimateUp: Bool = true, halfWay:(() -> Void)? = nil, _ completed:(() -> Void)? = nil){
        UIView.animate(withDuration: duration, animations: {
            self.alpha = alphaIn
            self.transform = CGAffineTransform(scaleX: scaleIn, y: scaleIn)
        }, completion: { (didComplete) in
            //if didComplete {
            halfWay?()
            
            if autoAnimateUp{
                self.animateTouchUp(duration: durationOut, {
                    completed?()
                })
            }
            //}
        })
    }
    
    public func animateTouchUp(duration: Double = 0.2, _ completed:(() -> Void)? = nil){
        UIView .animate(withDuration: duration, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { (didComplete) in
            //if didComplete {
            completed?()
            //}
        })
    }
    
}
