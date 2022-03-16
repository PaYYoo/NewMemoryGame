//
//  EasyMediumHardViewController.swift
//  NewMemoryGame
//
//  Created by CodewellAcademy on 4/24/19.
//  Copyright © 2019 CodewellAcademy. All rights reserved.
//

import UIKit

class EasyMediumHardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    var gameDifficult = 0

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func easyTapped(_ sender: Any) {
        gameDifficult = 1
    }
    
    @IBAction func mediumTapped(_ sender: Any) {
        gameDifficult = 2
    }
    
    @IBAction func hardTapped(_ sender: Any) {
        gameDifficult = 3
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? EasyViewController {
            controller.gameDifficulty = self.gameDifficult
        }
    }
}
