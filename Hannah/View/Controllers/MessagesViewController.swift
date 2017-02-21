//
//  MessagesViewController.swift
//  Hannah
//
//  Created by Evandro Harrison Hoffmann on 2/21/17.
//  Copyright © 2017 Evandro Harrison Hoffmann. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var closeButton: UIButton!
    
    let messagesViewModel = MessagesViewModel()
    
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

// MARK: - UICollectionViewDataSource and Delegate

extension MessagesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return messagesViewModel.sectionCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messagesViewModel.itemsCount(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return messagesViewModel.cell(collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        messagesViewModel.willDisplay(collectionView, cell: cell, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return messagesViewModel.sizeForItemAtIndexPath(collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return messagesViewModel.insetForSection(collectionView, section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return messagesViewModel.minimumLineSpacingForSection(collectionView, section: section)
    }
    
}
