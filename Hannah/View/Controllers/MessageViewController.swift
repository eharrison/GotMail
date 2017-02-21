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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Animations
    
    

    // MARK: - Events
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        closeButton.animateTouchDown(halfWay: {
            self.dismiss(animated: false, completion: nil)
        })
    }
    
}
