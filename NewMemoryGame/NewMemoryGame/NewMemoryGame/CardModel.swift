//
//  CardModel.swift
//  Calculator3
//
//  Created by CodewellAcademy on 4/23/19.
//  Copyright © 2019 Andrej Janeski and Stefan Hristovski. All rights reserved.
//

import Foundation
class CardModel {
    
    var cards:[Card] = []
    
    
    func getCards(withDifficulty int: Int){
        // Declaring an array to store generated cards
        var generatedCardsArray = [Card]()
        
        // Randomly generate pair of cards
        
        for number in 1...int*6{
            
            // Creating the first card object
            let cardOne = Card()
            cardOne.imageName = "card\(number)"
            generatedCardsArray.append(cardOne)
            
            // Creating the second card object
            let cardTwo = Card()
            cardTwo.imageName = "card\(number)"
            generatedCardsArray.append(cardTwo)
            
        }
        
        self.cards = generatedCardsArray

    }
    
    func getCards (){
    
        // Declaring an array to store generated cards
        var generatedCardsArray = [Card]()

        // Randomly generate pair of cards

        for number in 1...6{

            // Creating the first card object
            let cardOne = Card()
            cardOne.imageName = "card\(number)"
            generatedCardsArray.append(cardOne)

            // Creating the second card object
            let cardTwo = Card()
            cardTwo.imageName = "card\(number)"
            generatedCardsArray.append(cardTwo)

        }


         self.cards = generatedCardsArray
    }
    
    func shuffleCards(){
        let i = 4 
        for _ in 0 ..< cards.count * i {
            let card = cards.remove(at: Int(arc4random_uniform(UInt32(cards.count))))
            cards.insert(card, at: Int(arc4random_uniform(UInt32(cards.count))))
        }
    }
}


