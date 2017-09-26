//
//  QuestionPicker.swift
//  TrueFalseStarter
//
//  Created by Aaron Revalee on 9/26/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit
import GameKit

struct Questions {
    var questionActual: String
    var answerOptions: [String]
    var correctAnswer: String
}

struct QuestionProvider {
    let trivia: [Questions] = [
    Questions(questionActual: "How many million lightyears away is the nearest galaxy to ours?", answerOptions: ["2.2", "4.4", "6.1", "1.5"], correctAnswer: "2.2"),
    Questions(questionActual: "How many moons does Jupiter have?", answerOptions: ["1", "42", "66", "23"], correctAnswer: "66"),
    Questions(questionActual: "Which planet in our solar system has the highest gravity?", answerOptions: ["Mars", "Jupiter", "Saturn"], correctAnswer: "Jupiter"),
    Questions(questionActual: "Which planet does the moon Titan belong to?", answerOptions: ["Uranus", "Saturn", "Neptune", "Earth"], correctAnswer: "Saturn")
    ]
    
    func randomIndexOfSelectedQuestion() -> Int {
        let indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
        
        return indexOfSelectedQuestion
    }
    
    func randomQuestion(indexOfSelectedQuestion: Int) -> String {
        
        let questionArray = trivia[indexOfSelectedQuestion]
        
        return questionArray.questionActual
        
    }
    
    func randomAnswer(indexOfSelectedQuestion: Int) -> [String] {
        
        let questionArray = trivia[indexOfSelectedQuestion]
        
        return questionArray.answerOptions
        
    }
    
    func getCorrectAnswerByQuestion(in index: Int) -> String {
        let questionArray = trivia[index]
        
        return questionArray.correctAnswer
    }
}

