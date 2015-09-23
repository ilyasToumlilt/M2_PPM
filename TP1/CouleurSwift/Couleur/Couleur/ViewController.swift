//
//  ViewController.swift
//  Couleur
//
//  Created by m2sar on 21/09/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var myView: UIView!
    
    var colorIndex:Int = 0
    
    var couleurs :[UIColor] = [
        UIColor( red:0.00, green:1.0, blue:0.18, alpha:1.0),
        UIColor( red:0.00, green:0.00, blue:1.00, alpha:1.0 ),
        UIColor( red:1.00, green:0.00, blue:0.00, alpha:1.0 )]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myView!.backgroundColor = couleurs[0];
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func myStepper(sender: UIStepper) {
        colorIndex = Int(sender.value);
        myView!.backgroundColor = couleurs[colorIndex];
        
    }
    
}

