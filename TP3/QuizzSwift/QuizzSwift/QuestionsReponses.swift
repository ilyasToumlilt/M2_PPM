//
//  QuestionsReponses.swift
//  QuizzSwift
//
//  Created by m2sar on 01/10/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

import Foundation

let EASY_LEVEL = 0;
let HARD_LEVEL = 1;

class QuestionsReponses {
    
    var QuizzStack:[(difficulty: Int, question: String, answer: String, shownAnswer: Bool)] =
    [(EASY_LEVEL, "Q.1.1", "R.1.1", false),
        (EASY_LEVEL, "Q.1.2", "R.1.2", false),
        (HARD_LEVEL, "Q.2.1", "R.2.1", false),
        (EASY_LEVEL, "Q.1.3", "R.1.3", false),
        (EASY_LEVEL, "Q.1.4", "R.1.4", false),
        (HARD_LEVEL, "Q.2.2", "R.2.2", false)];
    
    var RspCounter   = 0;
    var stackCounter = 0;
    
    func getNextQuestion(Difficulty: Int) -> (Int, String!, String!) {
        for (var i=1; i <= self.QuizzStack.count; i++) {
            if( QuizzStack[(self.stackCounter+i)%self.QuizzStack.count].difficulty == Difficulty
                || Difficulty == HARD_LEVEL) {
                    self.stackCounter = (self.stackCounter+i)%self.QuizzStack.count;
                    return (self.QuizzStack[self.stackCounter].difficulty,
                        self.QuizzStack[self.stackCounter].question,
                        (self.QuizzStack[self.stackCounter].shownAnswer) ? self.QuizzStack[self.stackCounter].answer : "");
            }
        }
        return (HARD_LEVEL, "Erreur: pile de questions vide pour ce niveau !", "");
    }
    
    func getPreviousQuestion(Difficulty: Int) -> (Int, String!, String!) {
        for(var i=1; i <= self.QuizzStack.count; i++) {
            if( QuizzStack[(self.stackCounter-i+self.QuizzStack.count)%self.QuizzStack.count].difficulty == Difficulty || Difficulty == HARD_LEVEL) {
                self.stackCounter = (self.stackCounter-i+self.QuizzStack.count)%self.QuizzStack.count;
                return (self.QuizzStack[self.stackCounter].difficulty,
                    self.QuizzStack[self.stackCounter].question,
                    (self.QuizzStack[self.stackCounter].shownAnswer) ? self.QuizzStack[self.stackCounter].answer : "");
            }
        }
        return (HARD_LEVEL, "Erreur: pile de questions vide pour ce niveau !", "");
    }
    
    func getAnswer() -> String {
        if( !self.QuizzStack[self.stackCounter].shownAnswer ) {
            RspCounter++;
            self.QuizzStack[self.stackCounter].shownAnswer = true;
        }
        return self.QuizzStack[self.stackCounter].answer;
    }
    
    func getRspCounter() -> Int {
        return self.RspCounter;
    }
}
