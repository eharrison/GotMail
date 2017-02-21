//
//  HomeViewController.swift
//  Hannah
//
//  Created by Evandro Harrison Hoffmann on 2/21/17.
//  Copyright © 2017 Evandro Harrison Hoffmann. All rights reserved.
//

import UIKit
import Lottie

class HomeViewController: UIViewController {

    @IBOutlet weak var letterImageView: UIImageView!
    @IBOutlet weak var letterButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var historyButton: UIButton!
    
    var animationView: LOTAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MessageHelper.fetchMessages(loadView: self.view) { (messages) in
            self.updateView()
        }
    }
    
    // MARK: - Has Message
    
    func updateView(){
        animationView?.removeFromSuperview()
        
        if Message.messages().count > 0 {
            animationView = LOTAnimationView.animationNamed("moveEnv")
            animationView?.loopAnimation = true
            animationView?.frame = UIScreen.main.bounds
            animationView?.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
            self.view.addSubview(animationView!)
            self.view.sendSubview(toBack: animationView!)
            
            animationView?.play(completion: { (finished) in
                print("did complete \(finished)")
            })
            
            messageLabel.isHidden = true
            letterImageView.isHidden = true
        }else{
            messageLabel.isHidden = false
            letterImageView.isHidden = false
        }
    }

    // MARK: - Events
    
    @IBAction func letterButtonPressed(_ sender: Any) {
    }
    
    @IBAction func historyButtonPressed(_ sender: Any) {
        historyButton.animateTouchDown(halfWay: {
            
        })
    }
}
