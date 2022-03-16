//
//  ViewController.swift
//  Calculator3
//
//  Created by Andrej Janeski and Stefan Hristovski on 3/28/19.
//  Copyright © 2019 Andrej Janeski and Stefan Hristovski. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
    
   
    

    @IBOutlet var FirstView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initTaoGestureRecognizer()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func initTaoGestureRecognizer(){
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tapRecognizer)
        
    }
    @objc func handleTap(){
        self.performSegue(withIdentifier: "showNextScreen", sender: nil)
    }


}

