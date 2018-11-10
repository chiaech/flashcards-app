//
//  ViewController.swift
//  flashcards
//
//  Created by Chia E on 10/19/18.
//  Copyright © 2018 Chia E. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    var answer2: String
    var answer3: String
}

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    //array to hold flashcards
    var flashcards = [Flashcard]()
    
    //current flashcard index
    var currentIndex = 0
    
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //read saved flashcards
        readSavedFlashcards()
        
        viewSetup()
        
        if flashcards.count == 0 {
            updateFlashcard(question: "Who was the first man on the moon?", answer: "Niel Armstrong", answer2: "Barack Obama", answer3: "Frida Kahlo", isExisting: false)
            updateFlashcard(question: "Who is the best person ever?", answer: "Steven", answer2: "Steven", answer3: "Steven", isExisting: false)
            updateFlashcard(question: "Who is Steven?", answer: "The Best", answer2: "The Best", answer3: "The Best", isExisting: false)
        } else {
            updateLabels()
            updateNextPreviousButtons()
        }
        
    }
    
    func viewSetup() {
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
    
    @IBAction func didTapOnPrevious(_ sender: Any) {
        //decrease current index
        currentIndex = currentIndex - 1
        
        //update labels
        updateLabels()
        
        //update buttons
        updateNextPreviousButtons()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        //increase current index
        currentIndex = currentIndex + 1
        
        //update labels
        updateLabels()
        
        //update buttons
        updateNextPreviousButtons()
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {

        //show confirmation
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete this flashcard?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func deleteCurrentFlashcard(){
        flashcards.remove(at: currentIndex)
        
        //check if last card was deleted
        if currentIndex > flashcards.count - 1{
            currentIndex = flashcards.count - 1
        }
        
        updateNextPreviousButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
    
    func updateFlashcard(question: String, answer: String, answer2: String, answer3: String, isExisting: Bool){
        
        let flashcard = Flashcard(question: question, answer: answer, answer2: answer2, answer3: answer3)
        
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        option1.setTitle(answer2, for: .normal)
        option2.setTitle(answer, for: .normal)
        option3.setTitle(answer3, for: .normal)
        
        if isExisting {
            //replace exisiting flashcard
            flashcards[currentIndex] = flashcard
            
        } else {
            //add flashcard in array
            flashcards.append(flashcard)
                
        //logging to the consol
        print("we have \(flashcards.count) flashcards")
        
        //update current index
        currentIndex = flashcards.count - 1
        print("our current index is \(currentIndex)")
            
        }
    
        updateNextPreviousButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
        
    }
    
    func updateNextPreviousButtons(){
        //disable next button if at the end
        if currentIndex == flashcards.count - 1{
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        //disable previous button if at the beginning
        if currentIndex == 0{
            previousButton.isEnabled = false
        } else {
            previousButton.isEnabled = true
        }
    }
    
    func updateLabels(){
        //get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        //update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        //we know the destination of the segue is the Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        //we know the Navigation Controller only contains a Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        //we set the flashcardsController property to self
        creationController.flashcardsController = self
        
        if segue.identifier == "EditSegue"{
        creationController.initialQuestion = frontLabel.text
        creationController.initialAnswer = backLabel.text
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
    
    //function to store the array
    func saveAllFlashcardsToDisk(){
        
        //from flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String : String] in
            return ["question": card.question, "answer1": card.answer, "answer2": card.answer2, "answer3": card.answer3]
        }
        
        //save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        //log it
        print("flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards(){
        
        //read dictionary array from disk (if any)
        if let dicitonaryArray = UserDefaults.standard.array(forKey: "flashcards") as?  [[String: String]] {
            
            //in here we know for sure we have a dictionary array
            let savedCards = dicitonaryArray.map {dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer1"]!, answer2: dictionary["answer2"]!, answer3: dictionary["answer3"]!)
            }
            
            //put all our flashcards into our array
            flashcards.append(contentsOf: savedCards)
        }
    }
}
