//
//  ViewController.swift
//  DizainierSwift
//
//  Created by m2sar on 01/10/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myStepper: UIStepper!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var mySCDizaines: UISegmentedControl!
    @IBOutlet weak var mySCUnites: UISegmentedControl!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var mySlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.updateAll(0);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateAll(newValue: Int) {
        self.myStepper.value = Double(newValue);
        self.mySlider.value  = Float(newValue);
        self.mySCDizaines.selectedSegmentIndex = newValue / 10;
        self.mySCUnites.selectedSegmentIndex   = newValue % 10;
        self.updateLabel(newValue);
    }
    
    func updateLabel(newValue: Int) {
        self.myLabel.text = (self.mySwitch.on) ? String(format:"%X", newValue) : String(format:"%d", newValue);
        self.myLabel.textColor = (newValue != 42 ) ? UIColor.blackColor() : UIColor.redColor();
    }
    
    @IBAction func onChangeStepper(sender: AnyObject) {
        self.updateAll(Int(self.myStepper.value));
    }

    @IBAction func onChangeSwitch(sender: AnyObject) {
        self.updateLabel(Int(self.myStepper.value));
    }
    
    @IBAction func onChangeSC(sender: AnyObject) {
        self.updateAll(Int(self.mySCDizaines.selectedSegmentIndex * 10 + self.mySCUnites.selectedSegmentIndex));
    }
    
    @IBAction func onChangeSlider(sender: UISlider) {
        self.updateAll(Int(self.mySlider.value));
    }
    
    @IBAction func onClickRaZ(sender: AnyObject) {
        self.updateAll(0);
    }
    
}

