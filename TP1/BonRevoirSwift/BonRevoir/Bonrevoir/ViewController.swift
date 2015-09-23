//
//  ViewController.swift
//  Bonrevoir
//
//  Created by m2sar on 21/09/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Label: UILabel!
    
    var boolean : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Label.sizeToFit()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Bouton(sender: AnyObject) {
        boolean = !boolean
        if(boolean){
            Label.text = "Au revoir"
            sender.setTitle("Dis Bonjour", forState: .Normal)
        }
        else{
            Label.text = "Bonjour"
            sender.setTitle("Dis Au Revoir", forState: .Normal)
        }
    }

}

