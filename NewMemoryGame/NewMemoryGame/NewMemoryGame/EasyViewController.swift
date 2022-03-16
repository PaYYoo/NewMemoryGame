//
//  EasyViewController.swift
//  Calculator3
//
//  Created by Andrej Janeski and Stefan Hristovski on 4/3/19.
//  Copyright © 2019 Andrej Janeski and Stefan Hristovski. All rights reserved.
//

import UIKit

class EasyViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    @IBOutlet weak var timerLabel: UILabel!
    var timer:Timer!
    var timeCount:Int = 0
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var model = CardModel()
    
    var gameDifficulty: Int?
    
    
    
    var lastFlippedCardIndex:IndexPath?
    var secondLastFlippedCardIndex:IndexPath?
    var isPaused = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(myObserverForBackgound(notification:)), name: Notification.Name.UIApplicationDidEnterBackground, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(myObserverForForeground(notification:)), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if (timer != nil){
            timer.invalidate()
        }
        timer = Timer(timeInterval: 1.00, target: self, selector: #selector(timerStart), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
    }
    
    @objc func myObserverForBackgound(notification: Notification){
        isPaused = true
    }
    @objc func myObserverForForeground(notification: Notification){
        isPaused = false
    }
    
    @objc func timerStart () {
        if !isPaused{
            timeCount += 1
            timerLabel.text = NSString(format: "%02d:%02d:%02d", timeCount/3600,(timeCount/60)%60, timeCount%60) as String
        }
        
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        
        
        if let gameDifficult = gameDifficulty{
            model.getCards(withDifficulty: gameDifficult)
        }
        model.shuffleCards()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return model.cards.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        let card = model.cards[indexPath.row]
        cell.setCard(card)
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        let card = model.cards[indexPath.row]
        
        
        if card.isFliped == false {
            cell.flip()
            card.isFliped = true
            
            if lastFlippedCardIndex == nil{
                lastFlippedCardIndex = indexPath
            }else{
                secondLastFlippedCardIndex = lastFlippedCardIndex
                lastFlippedCardIndex = indexPath
                if checkForMatches(withLastCard: lastFlippedCardIndex!, withSecondCard: secondLastFlippedCardIndex!){
                    lastFlippedCardIndex = nil
                    secondLastFlippedCardIndex = nil
                }else{
                    collectionView.isUserInteractionEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Change `2.0` to the desired number of seconds.
                        let card1 = self.model.cards[self.secondLastFlippedCardIndex!.row]
                        let card2 = self.model.cards[self.lastFlippedCardIndex!.row]
                        if let cellForCard2 = self.collectionView.cellForItem(at: self.secondLastFlippedCardIndex!) as? CardCollectionViewCell{
                            cellForCard2.flip()
                        }
                        cell.flip()
                        card1.isFliped = false
                        card2.isFliped = false
                        self.lastFlippedCardIndex = nil
                        self.secondLastFlippedCardIndex = nil
                        collectionView.isUserInteractionEnabled = true
                    }
                }
            }
        }
    }
    // return true if matches, false otherwise
    func checkForMatches(withLastCard lastCard: IndexPath, withSecondCard seconCard: IndexPath) -> Bool{
        let card1 = model.cards[lastCard.row]
        let card2 = model.cards[seconCard.row]
        if card1.imageName == card2.imageName{
            if checkForWin(){
                timer.invalidate()
                //show alert // start new game
                showAlert()
                
            }
            
            return true
        }
        return false
    }
    
    func showAlert() {
        
        let alertController = UIAlertController(title: "Congratulations!", message: "Proceed to next level", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        { action -> Void in
            
            self.dismiss(animated: true, completion: nil)
        })
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func checkForWin() -> Bool{
        for i in model.cards{
            if !i.isFliped{
                return false
            }
        }
        return true
    }
}


