//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    let questionProvider = QuestionProvider()
  
    
    var gameSound: SystemSoundID = 0
    
 
    @IBOutlet weak var QuestionDisplay: UILabel!
    @IBOutlet weak var FirstAnswer: UIButton!
    @IBOutlet weak var SecondAnswer: UIButton!
    @IBOutlet weak var ThirdAnswer: UIButton!
    @IBOutlet weak var FourthAnswer: UIButton!
    @IBOutlet weak var NextQuestion: UIButton!
    @IBOutlet weak var CorrectIncorrect: UILabel!
    @IBOutlet weak var PlayAgain: UIButton!
    
    
    var answeredQuestionIndexesArray: [Int] = Array()
    var correctAnswer = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Start game
        displayQuestion()
        displayAnswer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion() {
        
        indexOfSelectedQuestion = questionProvider.randomIndexOfSelectedQuestion()
        let question = questionProvider.randomQuestion(indexOfSelectedQuestion: indexOfSelectedQuestion)
        answeredQuestionIndexesArray.append(indexOfSelectedQuestion)
        QuestionDisplay.text = question
        PlayAgain.isHidden = true
        PlayAgain.isEnabled = false
        NextQuestion.isHidden = true
        NextQuestion.isEnabled = false
        CorrectIncorrect.isHidden = true
        
       
        
    }
    
    func displayAnswer() {
        
        let answerArrays = questionProvider.randomAnswer(indexOfSelectedQuestion: indexOfSelectedQuestion)
        
        if answerArrays.count == 3 {
            FirstAnswer.setTitle(answerArrays[0], for: .normal);
            SecondAnswer.setTitle(answerArrays[1], for: .normal);
            ThirdAnswer.setTitle(answerArrays[2], for: .normal);
            FourthAnswer.isHidden = true  }
            
            // for 3 answer questions
            else {
                FourthAnswer.isHidden = false
                FirstAnswer.setTitle(answerArrays[0], for: .normal);
                SecondAnswer.setTitle(answerArrays[1], for: .normal);
                ThirdAnswer.setTitle(answerArrays[2], for: .normal);
                FourthAnswer.setTitle(answerArrays[3], for: .normal)
        }
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
     correctAnswer = questionProvider.getCorrectAnswerByQuestion(in: indexOfSelectedQuestion)
     
        if (sender === FirstAnswer && FirstAnswer.titleLabel?.text == correctAnswer) ||
        (sender === SecondAnswer && SecondAnswer.titleLabel?.text == correctAnswer) ||
        (sender === ThirdAnswer && ThirdAnswer.titleLabel?.text == correctAnswer) ||
        (sender === FourthAnswer && FourthAnswer.titleLabel?.text == correctAnswer)
        {
            let color = UIColor.green
            CorrectIncorrect.textColor = color
            CorrectIncorrect.text = "That's Correct!"
            // need sound to play
        }
        else {
            let color = UIColor.red
            CorrectIncorrect.textColor = color
            CorrectIncorrect.text = "Sorry, That's Incorrect!"
            // need sound to play
        }
        disableButtons()
        triviaSuper.remove(at: indexOfSelectedQuestion)
        CorrectIncorrect.isHidden = false
    
    }
    
    @IBAction func NextQuestion(_ sender: UIButton) {
        enableButtons()
        displayQuestion()
        displayAnswer()
        
    }
    
    
    func disableButtons() {
        
        FirstAnswer.isEnabled = false
        SecondAnswer.isEnabled = false
        ThirdAnswer.isEnabled = false
        FourthAnswer.isEnabled = false
        FirstAnswer.isHighlighted = false
        SecondAnswer.isHighlighted = false
        ThirdAnswer.isHighlighted = false
        FourthAnswer.isHighlighted = false
        
        NextQuestion.isHidden = false
        NextQuestion.isEnabled = true
    }
    
    func displayScore() {
        // Hide the answer buttons
        FirstAnswer.isHidden = true
        SecondAnswer.isHidden = true
        ThirdAnswer.isHidden = true
        FourthAnswer.isHidden = true
        
        // Display play again button
        PlayAgain.isHidden = false
        
        
        
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        FirstAnswer.isHidden = false
        SecondAnswer.isHidden = false
        ThirdAnswer.isHidden = false
        FourthAnswer.isHidden = false
        
        questionsAsked = 0
        correctQuestions = 0
 
    }
    
    func enableButtons() {
        // The style constraints are setted for enabled buttons
        let backgroundColorEnabledButton = UIColor(red:0.09, green:0.47, blue:0.58, alpha:1.0)
        let textColorEnabledButton = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        
        FirstAnswer.backgroundColor = backgroundColorEnabledButton
        FirstAnswer.setTitleColor(textColorEnabledButton, for: .normal)
        
        SecondAnswer.backgroundColor = backgroundColorEnabledButton
        SecondAnswer.setTitleColor(textColorEnabledButton, for: .normal)
        
        ThirdAnswer.backgroundColor = backgroundColorEnabledButton
        ThirdAnswer.setTitleColor(textColorEnabledButton, for: .normal)
        
        FourthAnswer.backgroundColor = backgroundColorEnabledButton
        FourthAnswer.setTitleColor(textColorEnabledButton, for: .normal)
        
        // The buttons are enabled.
        FirstAnswer.isEnabled = true
        SecondAnswer.isEnabled = true
        ThirdAnswer.isEnabled = true
        FourthAnswer.isEnabled = true
    }}
