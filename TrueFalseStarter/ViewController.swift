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
    var questionProvider = QuestionProvider()
  
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
// Displays a Random Question from the trivia Array
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

// Displays the corresponding answer choices from the trivia Array
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

/// Checks whether the button that was pressed is the right answer by accessing the functions in the QuestionPicker file. Disables all buttons except the next question button and dims all answers but the correct one. Also calls the question struct to provide correct answer if answer is incorrect.
    @IBAction func checkAnswer(_ sender: UIButton) {
     correctAnswer = questionProvider.getCorrectAnswerByQuestion(in: indexOfSelectedQuestion)
     disableButtons()
     dimAlpha()
        
        if (sender === FirstAnswer && FirstAnswer.titleLabel?.text == correctAnswer) ||
        (sender === SecondAnswer && SecondAnswer.titleLabel?.text == correctAnswer) ||
        (sender === ThirdAnswer && ThirdAnswer.titleLabel?.text == correctAnswer) ||
        (sender === FourthAnswer && FourthAnswer.titleLabel?.text == correctAnswer) {
            let color = UIColor.green
            CorrectIncorrect.textColor = color
            CorrectIncorrect.text = "That's Correct!"
            sender.isHighlighted = true
            sender.alpha = 1.0
            correctQuestions += 1
            // need sound to play
        }
        else {
            let color = UIColor.red
            CorrectIncorrect.textColor = color
            CorrectIncorrect.text = "Sorry, That's Incorrect! The Correct Answer is \(questionProvider.getCorrectAnswerByQuestion(in: indexOfSelectedQuestion)) "
            // need sound to play
        }
        questionsAsked += 1
        questionProvider.trivia.remove(at: indexOfSelectedQuestion)
        CorrectIncorrect.isHidden = false
    
    }
    
// Checks whether the game is over or if it should proceed to the next question
    @IBAction func NextQuestion(_ sender: UIButton) {
        
        if questionsAsked == questionsPerRound {
            FirstAnswer.isHidden = true
            SecondAnswer.isHidden = true
            ThirdAnswer.isHidden = true
            FourthAnswer.isHidden = true
            QuestionDisplay.isHidden = true
            NextQuestion.isHidden = true
            PlayAgain.isEnabled = true
            PlayAgain.isHidden = false
            
            CorrectIncorrect.textColor = UIColor.green
            CorrectIncorrect.text = "You Answered \(correctQuestions) out of 4 Correctly!"
        }
        
        else {
        enableButtons()
        displayQuestion()
        displayAnswer()
        resetAlpha()
        }
    }

    func dimAlpha() {
        FirstAnswer.alpha = 0.3
        SecondAnswer.alpha = 0.3
        ThirdAnswer.alpha = 0.3
        FourthAnswer.alpha = 0.3
    }
    func newGame() {
        resetAlpha()
        displayAnswer()
        displayQuestion()
    }
    func resetAlpha() {
        FirstAnswer.alpha = 1.0
        SecondAnswer.alpha = 1.0
        ThirdAnswer.alpha = 1.0
        FourthAnswer.alpha = 1.0
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
        FirstAnswer.isHidden = true
        SecondAnswer.isHidden = true
        ThirdAnswer.isHidden = true
        FourthAnswer.isHidden = true
        PlayAgain.isHidden = false
    }
    

    @IBAction func playAgain(_ sender: UIButton) {
        FirstAnswer.isHidden = false
        SecondAnswer.isHidden = false
        ThirdAnswer.isHidden = false
        FourthAnswer.isHidden = false
        
        answeredQuestionIndexesArray = []
        questionsAsked = 0
        correctQuestions = 0
        
        newGame()
    }
        
    
    func enableButtons() {
        FirstAnswer.isEnabled = true
        SecondAnswer.isEnabled = true
        ThirdAnswer.isEnabled = true
        FourthAnswer.isEnabled = true
    }}
