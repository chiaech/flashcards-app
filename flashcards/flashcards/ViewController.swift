//
//  ViewController.swift
//  flashcards
//
//  Created by Chia E on 10/19/18.
//  Copyright © 2018 Chia E. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        card.layer.cornerRadius = 20.0
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        option1.layer.cornerRadius = 20.0
        option2.layer.cornerRadius = 20.0
        option3.layer.cornerRadius = 20.0
        
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2

        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        option1.clipsToBounds = true
        option2.clipsToBounds = true
        option3.clipsToBounds = true
        
        option1.layer.borderWidth = 3.0
        option2.layer.borderWidth = 3.0
        option3.layer.borderWidth = 3.0
        
        option1.layer.borderColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        option2.layer.borderColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        option3.layer.borderColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
       if frontLabel.isHidden {
        frontLabel.isHidden = false
        }
       else {
        frontLabel.isHidden = true
        }
    }
    
    @IBAction func didTapOption1(_ sender: Any) {
        option1.isHidden = true
    }
    
    @IBAction func didTapOption2(_ sender: Any) {
    }
    
    @IBAction func didTapOption3(_ sender: Any) {
        option3.isHidden = true
    }
    
}
