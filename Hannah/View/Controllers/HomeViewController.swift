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
            MVLocalNotificationsHelper.setupNotifications()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateView()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? MessageViewController {
            viewController.message = Message.todaysMessage
        }
    }
    
    @IBAction func unwindToHome(_ segue: UIStoryboardSegue){
        self.updateView()
    }
    
    // MARK: - Has Message
    
    func updateView(){
        animationView?.alpha = 1
        animationView?.removeFromSuperview()
        
        if let message = Message.todaysMessage, message.read == 0{
            animationView = LOTAnimationView.animationNamed("moveEnv")
            animationView?.loopAnimation = true
            animationView?.frame = UIScreen.main.bounds
            animationView?.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
            self.view.addSubview(animationView!)
            self.view.sendSubview(toBack: animationView!)
            
            animationView?.play(completion: { (finished) in
            })
            
            messageLabel.isHidden = true
            letterImageView.isHidden = true
            
            historyButton.isHidden = true
        }else{
            messageLabel.isHidden = false
            letterImageView.isHidden = false
            
            historyButton.alpha = 1
            historyButton.isHidden = Message.pastMessages().count == 0
        }
    }

    // MARK: - Events
    
    @IBAction func letterButtonPressed(_ sender: Any) {
        if let message = Message.todaysMessage, message.read == 0 {
            historyButton.animateFadeOut()
            animationView?.removeFromSuperview()
            
            animationView = LOTAnimationView.animationNamed("openEnv")
            animationView?.frame = UIScreen.main.bounds
            animationView?.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
            self.view.addSubview(animationView!)
            
            animationView?.play(completion: { (finished) in
                //self.animationView?.alpha = 0
                self.performSegue(withIdentifier: "messageSegue", sender: self)
            })
        }
    }
    
    @IBAction func historyButtonPressed(_ sender: Any) {
        historyButton.animateTouchDown(halfWay: {
            
        })
    }
}
