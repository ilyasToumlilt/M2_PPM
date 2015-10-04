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
    
    let QuizzStack:[(difficulty: Int, question: String, answer: String)] =
        [(EASY_LEVEL, "Q.1.1", "R.1.1"),
         (EASY_LEVEL, "Q.1.2", "R.1.2"),
         (HARD_LEVEL, "Q.2.1", "R.2.1"),
         (EASY_LEVEL, "Q.1.3", "R.1.3"),
            (EASY_LEVEL, "Q.1.4", "R.1.4"),
         (HARD_LEVEL, "Q.2.2", "R.2.2")];
    
    var RspCounter   = 0;
    var stackCounter = 0;
    
    func getNextQuestion(Difficulty: Int) -> String {
        for (var i=1; i <= self.QuizzStack.count; i++) {
            if( QuizzStack[(self.stackCounter+i)%self.QuizzStack.count].difficulty == Difficulty ) {
                self.stackCounter = (self.stackCounter+i)%self.QuizzStack.count;
                return self.QuizzStack[self.stackCounter].question;
            }
        }
        return "Erreur: pile de questions vide pour ce niveau !";
    }
    
    func getPreviousQuestion(Difficulty: Int) -> String {
        for(var i=1; i <= self.QuizzStack.count; i++) {
                if( QuizzStack[(self.stackCounter-i+self.QuizzStack.count)%self.QuizzStack.count].difficulty == Difficulty) {
                    self.stackCounter = (self.stackCounter-i+self.QuizzStack.count)%self.QuizzStack.count;
                    return self.QuizzStack[self.stackCounter].question;
                }
        }
        return "Erreur: pile de questions vide pour ce niveau !";
    }
    
    func getAnswer() -> String {
        RspCounter++;
        return self.QuizzStack[self.stackCounter].answer;
    }
    
    func getRspCounter() -> Int {
        return self.RspCounter;
    }
}
