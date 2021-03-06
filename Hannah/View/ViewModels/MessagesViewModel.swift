//
//  MessagesViewModel.swift
//  Hannah
//
//  Created by Evandro Harrison Hoffmann on 2/21/17.
//  Copyright © 2017 Evandro Harrison Hoffmann. All rights reserved.
//

import UIKit

enum MessagesCellType: String {
    case message = "message"
}

struct MessagesViewModel {
    
    let messages: [Message] = {
       return Message.pastMessages()
    }()
}

// MARK: - Collection view data source and delegate

extension MessagesViewModel {
    
    func sectionCount() -> Int {
        return 1
    }
    
    func itemsCount(_ section: Int) -> Int {
        return messages.count
    }
    
    func sizeForItemAtIndexPath(_ collectionView:UICollectionView , indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width-40, height: 170)
    }
    
    func cell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessagesCellType.message.rawValue, for: indexPath) as! MessageCollectionViewCell
        
        cell.messageLabel.text = messages[indexPath.row].message
        cell.authorLabel.text = messages[indexPath.row].author
        
        return cell
    }
    
    func willDisplay(_ collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath) {
        
    }
    
    func insetForSection(_ collectionView: UICollectionView, section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 23, left: 0, bottom: 23, right: 0)
    }
    
    func minimumLineSpacingForSection(_ collectionView: UICollectionView, section: Int) -> CGFloat {
        return 23
    }
}
