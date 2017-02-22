//
//  MessageViewController.swift
//  Hannah
//
//  Created by Evandro Harrison Hoffmann on 2/21/17.
//  Copyright © 2017 Evandro Harrison Hoffmann. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet weak var messageView: DesignableView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    var message: Message?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        message?.read = 1
//        Message.save()
        
        messageLabel.text = message?.message
        authorLabel.text = message?.author
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareForAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateIn()
    }
    
    // MARK: - Animations
    
    func prepareForAnimation(){
        self.messageLabel.alpha = 0
        self.authorLabel.alpha = 0
        self.closeButton.alpha = 0
    }
    
    func animateIn(){
        self.messageLabel.animateFadeIn()
        self.authorLabel.animateFadeIn()
        self.closeButton.animateFadeIn()
    }
    
    // MARK: - Events
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        closeButton.animateTouchDown(halfWay: {
            self.dismiss(animated: false, completion: nil)
        })
    }
    
}
