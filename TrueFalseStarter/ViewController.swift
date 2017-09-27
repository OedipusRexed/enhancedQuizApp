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
        loadGameStartSound()
        // Start game
        playGameStartSound()
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
        QuestionDisplay.text = question
        PlayAgain.isHidden = true
        PlayAgain.isEnabled = false
        NextQuestion.isHidden = true
        NextQuestion.isEnabled = false
        CorrectIncorrect.isHidden = true
    }
    
    func displayAnswer() {
        
        let answerArrays = questionProvider.randomAnswer(indexOfSelectedQuestion: indexOfSelectedQuestion)
        
        if answerArrays.count == 4 {
        FirstAnswer.setTitle(answerArrays[0], for: .normal);
        SecondAnswer.setTitle(answerArrays[1], for: .normal);
        ThirdAnswer.setTitle(answerArrays[2], for: .normal);
        FourthAnswer.setTitle(answerArrays[3], for: .normal)
    }
            // for 3 answer questions
        else {
            FirstAnswer.setTitle(answerArrays[0], for: .normal);
            SecondAnswer.setTitle(answerArrays[1], for: .normal);
            ThirdAnswer.setTitle(answerArrays[2], for: .normal);
            FourthAnswer.isHidden = true
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

        CorrectIncorrect.isHidden = false
    
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
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        FirstAnswer.isHidden = false
        SecondAnswer.isHidden = false
        ThirdAnswer.isHidden = false
        FourthAnswer.isHidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}

