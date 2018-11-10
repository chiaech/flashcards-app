//
//  CreationViewController.swift
//  flashcards
//
//  Created by Chia E on 10/25/18.
//  Copyright © 2018 Chia E. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    var flashcardsController: ViewController!
    var initialQuestion: String?
    var initialAnswer: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
    }
    
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var answerTextField2: UITextField!
    @IBOutlet weak var answerTextField3: UITextField!
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        //get the text in the question text field
        let questionText = questionTextField.text
        
        //get the text in the answer text field
        let answerText = answerTextField.text
        let answerText2 = answerTextField.text
        let answerText3 = answerTextField.text
        
        //check if empty
        if questionText == nil || answerText == nil || answerText2 == nil || answerText3 == nil || questionText!.isEmpty || answerText!.isEmpty || answerText2!.isEmpty || answerText3!.isEmpty{
            //show error
            let alert = UIAlertController(title: "Missing text", message: "Please enter a question and an answer.", preferredStyle: .alert)
            present(alert, animated: true)
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
        }
        else {

            var isExisting = false
            //see if its existing
            if initialQuestion != nil {
                isExisting = true
            }
            
            //call the function to update the flashcard
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, answer2: answerText2!, answer3: answerText3!, isExisting: false)
            
            dismiss(animated: true)
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
