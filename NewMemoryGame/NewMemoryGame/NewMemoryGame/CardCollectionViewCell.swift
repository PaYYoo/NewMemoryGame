//
//  CardCollectionViewCell.swift
//  Calculator3
//
//  Created by CodewellAcademy on 4/23/19.
//  Copyright © 2019 Andrej Janeski and Stefan Hristovski . All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card:Card?
    
    func setCard(_ card:Card) {
        // Keep track of the card that gets passed in
        self.card = card
        frontImageView.image = UIImage(named: card.imageName)
        
        if card.isFliped == true {
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
            
        }
        else{
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
        }
        
    }
    
    func flip() {
        if let card = card, card.isFliped{
            UIView.transition(from: frontImageView, to: backImageView, duration: 0.3, options: [.transitionFlipFromRight,.showHideTransitionViews], completion: nil)
        }else{
            UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
        }
    }
    

    
    
}
