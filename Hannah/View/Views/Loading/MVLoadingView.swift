//
//  LoadingView.swift
//  Quests
//
//  Created by Evandro Harrison Hoffmann on 13/01/2017.
//  Copyright © 2017 Mindvalley. All rights reserved.
//

import UIKit

class MVLoadingView: UIView {

    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    fileprivate var animating = false
    fileprivate var maxScale: CGFloat = 1.0
    fileprivate var pulseTimer: Timer?
    
    static func newInstance() -> MVLoadingView{
        return Bundle(for: self).loadNibNamed("MVLoadingView", owner: self, options: nil)![0] as! MVLoadingView
    }
    
    override func awakeFromNib() {
        self.isHidden = true
    }
}

//MARK: - Animations

extension MVLoadingView {
    
    func show(){
        animating = true
        
        if self.frame.size.width < self.activityIndicatorView.frame.size.width*1.2 {
            maxScale = self.frame.size.width/(self.activityIndicatorView.frame.size.width*1.2)
        }
        
        self.isHidden = false
        self.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
        }, completion: { (Bool) in
            
        })
        
        self.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.1, options: .curveEaseOut, animations: {
            self.alpha = 1
        })
        
        pulse()
        pulseTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(MVLoadingView.pulse), userInfo: nil, repeats: true)
    }
    
    func pulse(){
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseIn, animations: {
            self.activityIndicatorView.transform = CGAffineTransform(scaleX: self.maxScale*1.1, y: self.maxScale*1.1)
            self.activityIndicatorView.alpha = 0.8
        }) { (Bool) in
            UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseOut, animations: {
                self.activityIndicatorView.transform = CGAffineTransform(scaleX: self.maxScale*1, y: self.maxScale*1)
                self.activityIndicatorView.alpha = 1
            })
        }
    }
    
    func hide(){
        animating = false
        
        pulseTimer?.invalidate()
        pulseTimer = nil
        
        UIView.animate(withDuration: 0.1, animations: {
            self.activityIndicatorView.transform = CGAffineTransform(scaleX: self.maxScale*0.9, y: self.maxScale*0.9)
        }, completion: { (Bool) in
            UIView.animate(withDuration: 0.3, animations: {
                self.activityIndicatorView.transform = CGAffineTransform(scaleX: self.maxScale*1.4, y: self.maxScale*1.4)
                self.alpha = 0
            }, completion: { (Bool) in
                self.removeFromSuperview()
            })
        })
    }
}

extension UIView {
    
    func startLoadingAnimationDelayed(_ delay: Double){
        let delayTime = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.startLoadingAnimation()
        }
    }
    
    func startLoadingAnimation(){
        stopLoadingAnimation()
        
        let loadingView = MVLoadingView.newInstance()
        loadingView.frame = self.bounds
        self.addSubview(loadingView)
        loadingView.show()
    }
    
    func stopLoadingAnimation(){
        for subview in subviews{
            if let subview = subview as? MVLoadingView {
                subview.hide()
            }
        }
    }
}
