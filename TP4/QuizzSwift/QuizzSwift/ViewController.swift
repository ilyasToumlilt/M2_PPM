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
    
    var myNextButton:UIButton!
    var myPreviousButton:UIButton!
    
    var myQuestionTV:UITextView!
    var myAnswerTV: UITextView!
    var myAnswerButton : UIButton!
    var myQuestionLabel:UILabel!
    var myAnswerLabel:UILabel!
    var myRspCounterLabel: UILabel!
    var myBalaiseSwitch: UISwitch!
    
    var imgLeft : UIImage?;
    var imgRight : UIImage?;
    
    let GUIDELINES_VERT:CGFloat = 20.0;
    let GUIDELINES_HOR:CGFloat = 20.0;
    let PADDING_BETW_ELT:CGFloat=10.0;
    
    let QUESTION_TEXT = "La Question"
    let ANSWER_TEXT = "La Réponse"
    let RSP_COUNTER_TEXT = "Réponses vues : 0"
    
    let LEFT_IMG_PATH = "flecheGauche.png"
    let RIGHT_IMG_PATH = "flecheDroite.png"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.imgLeft = UIImage(named: self.LEFT_IMG_PATH)
        self.imgRight = UIImage(named: self.RIGHT_IMG_PATH);
        
        //Réponse Button
        self.myAnswerButton = UIButton()
        self.myAnswerButton.setTitle("Réponse", forState: .Normal);
        self.myAnswerButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        self.myAnswerButton.addTarget(self, action: "onClickReponse:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.myPreviousButton = UIButton()
        self.myPreviousButton.setBackgroundImage(imgLeft, forState: .Normal);
        self.myPreviousButton.addTarget(self, action: "onClickPrevious:", forControlEvents: UIControlEvents.TouchUpInside)
        self.myPreviousButton.addTarget(self, action: "onTouchDownNextOrPrevious:", forControlEvents: UIControlEvents.TouchDown)
        
        self.myNextButton = UIButton()
        self.myNextButton.setBackgroundImage(imgRight, forState: .Normal);
        self.myNextButton.addTarget(self, action: "onClickNext:", forControlEvents: UIControlEvents.TouchUpInside)
        self.myNextButton.addTarget(self, action: "onTouchDownNextOrPrevious:", forControlEvents: UIControlEvents.TouchDown)
        
        //Question Label
        self.myQuestionLabel = UILabel()
        self.myQuestionLabel.text = self.QUESTION_TEXT
        self.myQuestionLabel.textAlignment = .Center;
        
        //Question TextView
        self.myQuestionTV = UITextView()
        self.myQuestionTV.editable = false;
        self.myQuestionTV.textAlignment = .Center
        
        //Question Label
        self.myAnswerLabel = UILabel()
        self.myAnswerLabel.text = self.ANSWER_TEXT
        self.myAnswerLabel.textAlignment = .Center;
        
        //Answer TextView
        self.myAnswerTV = UITextView()
        self.myAnswerTV.editable = false;
        self.myAnswerTV.textAlignment = .Center
        
        self.myRspCounterLabel = UILabel()
        self.myRspCounterLabel.text = self.RSP_COUNTER_TEXT
        
        self.myBalaiseSwitch = UISwitch()
        self.myBalaiseSwitch.addTarget(self, action: "onChangeBalaiseSwitch:", forControlEvents: UIControlEvents.ValueChanged)
        
        
        self.view.addSubview(self.myPreviousButton)
        self.view.addSubview(self.myNextButton)
        self.view.addSubview(self.myAnswerButton)
        self.view.addSubview(self.myQuestionLabel)
        self.view.addSubview(self.myQuestionTV);
        self.view.addSubview(self.myAnswerLabel)
        self.view.addSubview(self.myAnswerButton);
        self.view.addSubview(self.myAnswerTV);
        self.view.addSubview(self.myRspCounterLabel);
        self.view.addSubview(self.myBalaiseSwitch);
        
        
        self.setSizeElements(CGSize(width: self.view.bounds.width, height: self.view.bounds.height))
        
        self.myAnswerTV.textColor = UIColor.greenColor();
        self.onChangeBalaiseSwitch(self.myBalaiseSwitch);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onClickReponse(sender: UIButton) {
        self.myAnswerTV.text = self.QR.getAnswer();
        self.myRspCounterLabel.text = "Réponses vues : \(self.QR.getRspCounter())";
    }
    
    func onClickNext(sender: UIButton) {
        
        self.myNextButton.setBackgroundImage(UIImage(named: "flecheDroite"), forState: .Normal);
        var lvl: Int;
        (lvl, self.myQuestionTV.text, self.myAnswerTV.text) = self.QR.getNextQuestion((self.myBalaiseSwitch.on ? HARD_LEVEL : EASY_LEVEL));
        self.myQuestionTV.textColor = ( lvl == HARD_LEVEL ) ? UIColor.redColor() : UIColor.purpleColor();
    }
    
    func onTouchDownNextOrPrevious(sender: UIButton) {
        sender.setBackgroundImage(UIImage(named: "fleche-en-action"), forState: .Normal);
    }
    
    func onClickPrevious(sender: UIButton) {
        self.myPreviousButton.setBackgroundImage(UIImage(named: "flecheGauche"), forState: .Normal);
        var lvl: Int;
        (lvl, self.myQuestionTV.text, self.myAnswerTV.text) = self.QR.getPreviousQuestion((self.myBalaiseSwitch.on ? HARD_LEVEL : EASY_LEVEL));
        self.myQuestionTV.textColor = ( lvl == HARD_LEVEL ) ? UIColor.redColor() : UIColor.purpleColor();
    }
    
    func onChangeBalaiseSwitch(sender: UISwitch) {
        if( self.myBalaiseSwitch.on ) {
            self.onClickNext(self.myNextButton);
        } else {
            self.onClickPrevious(self.myPreviousButton);
        }
    }
    
    func setSizeElements(s:CGSize)
    {
        var curY:CGFloat=0;
        
        self.myAnswerButton.frame=CGRect(x: self.GUIDELINES_VERT+self.PADDING_BETW_ELT+imgLeft!.size.width, y: self.GUIDELINES_HOR, width: s.width-((2*self.GUIDELINES_VERT)+imgLeft!.size.width+imgRight!.size.width+(2*self.PADDING_BETW_ELT)), height: 50)
        
        self.myNextButton.frame = CGRect(x: s.width-imgRight!.size.width-self.GUIDELINES_VERT, y: self.GUIDELINES_HOR, width: imgRight!.size.width, height: imgRight!.size.height);
        
        self.myPreviousButton.frame = CGRect(x: self.GUIDELINES_VERT, y: self.GUIDELINES_HOR, width: imgLeft!.size.width, height: imgLeft!.size.height);
        
        curY+=(2 * self.GUIDELINES_HOR) + self.myAnswerButton.bounds.height;
        self.myQuestionLabel.frame = CGRect(x: self.GUIDELINES_VERT+self.PADDING_BETW_ELT+imgLeft!.size.width, y: curY, width: s.width-((2*self.GUIDELINES_VERT)+imgLeft!.size.width+imgRight!.size.width+(2*self.PADDING_BETW_ELT)), height: 20)
        
        curY+=self.PADDING_BETW_ELT+self.myQuestionLabel.bounds.height;
        self.myQuestionTV.frame = CGRect(x: self.GUIDELINES_VERT, y: curY, width: s.width-(2*self.GUIDELINES_VERT), height: 50)
        
        curY+=self.GUIDELINES_HOR + self.myQuestionTV.bounds.height;
        self.myAnswerLabel.frame = CGRect(x: self.GUIDELINES_VERT, y: curY, width: s.width-(2*self.GUIDELINES_VERT), height: 20)
        
        curY+=self.PADDING_BETW_ELT+self.myAnswerLabel.bounds.height;
        self.myAnswerTV.frame = CGRect(x: self.GUIDELINES_VERT, y: curY, width: s.width-(2*self.GUIDELINES_VERT), height: 50)
        self.myRspCounterLabel.frame = CGRect(x: self.GUIDELINES_VERT, y: s.height-self.GUIDELINES_HOR-20, width: s.width/2, height: 20)
        self.myBalaiseSwitch.frame = CGRect(x: s.width - 70, y: s.height-self.GUIDELINES_HOR-30, width:s.height/2, height: 20);
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        self.setSizeElements(size)
    }
    
}
