//
//  ViewController.swift
//  QuizzSwift
//
//  Created by m2sar on 01/10/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var QR = QuestionsReponses();
    
    @IBOutlet weak var myQuestionTV: UITextView!
    @IBOutlet weak var myAnswerTV: UITextView!
    @IBOutlet weak var myRspCounterLabel: UILabel!
    @IBOutlet weak var myBalaiseSwitch: UISwitch!
    @IBOutlet weak var myNextButton: UIButton!
    @IBOutlet weak var myPreviousButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.myAnswerTV.textColor = UIColor.greenColor();
        self.onChangeBalaiseSwitch(self.myBalaiseSwitch);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickReponse(sender: UIButton) {
        self.myAnswerTV.text = self.QR.getAnswer();
        self.myRspCounterLabel.text = "Réponses vues : \(self.QR.getRspCounter())";
    }

    @IBAction func onClickNext(sender: UIButton) {
        self.myNextButton.setImage(UIImage(named: "flecheDroite"), forState: .Normal);
        var lvl: Int;
        (lvl, self.myQuestionTV.text, self.myAnswerTV.text) = self.QR.getNextQuestion((self.myBalaiseSwitch.on ? HARD_LEVEL : EASY_LEVEL));
        self.myQuestionTV.textColor = ( lvl == HARD_LEVEL ) ? UIColor.redColor() : UIColor.purpleColor();
    }
    
    
    @IBAction func onTouchDownNextOrPrevious(sender: UIButton) {
        sender.setImage(UIImage(named: "fleche-en-action"), forState: .Normal);
    }
    
    @IBAction func onClickPrevious(sender: UIButton) {
        self.myPreviousButton.setImage(UIImage(named: "flecheGauche"), forState: .Normal);
        var lvl: Int;
        (lvl, self.myQuestionTV.text, self.myAnswerTV.text) = self.QR.getPreviousQuestion((self.myBalaiseSwitch.on ? HARD_LEVEL : EASY_LEVEL));
        self.myQuestionTV.textColor = ( lvl == HARD_LEVEL ) ? UIColor.redColor() : UIColor.purpleColor();
    }
    
    @IBAction func onChangeBalaiseSwitch(sender: UISwitch) {
        if( self.myBalaiseSwitch.on ) {
            self.onClickNext(self.myNextButton);
        } else {
            self.onClickPrevious(self.myPreviousButton);
        }
    }
}
