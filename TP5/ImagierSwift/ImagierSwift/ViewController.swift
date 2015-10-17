//
//  ViewController.swift
//  ImagierQuizz
//
//  Created by m2sar on 13/10/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    var pav:PhotoAlbumView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var pinRec = UIPinchGestureRecognizer();
        
        self.pav = PhotoAlbumView(frame: self.view.frame);
        self.pav.myScrollView.delegate = self;
        self.view.addSubview(self.pav);
        
        self.pav.btnPrev.addTarget(self, action: "imgPrevAction", forControlEvents: .TouchDown);
        self.pav.btnNext.addTarget(self, action: "imgNextAction", forControlEvents: .TouchDown);
        
        pinRec.addTarget(self, action: "pinchAction")
        self.pav.sliderSize.addTarget(self, action: "sliderSetSizeAction", forControlEvents: .ValueChanged)
        //self.pav.myScrollView.addGestureRecognizer(self.);
        //self.pav.myScrollView.userInteractionEnabled = true
        //self.pav.myScrollView.multipleTouchEnabled = true
        
    }
    
    func imgPrevAction(){
        self.pav.onTouchPrevImg();
    }
    
    func imgNextAction(){
        println("fgfg")
        self.pav.onTouchNextImg();
    }
    
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.pav.myImageView;
    }
    
    func sliderSetSizeAction(){
        self.pav.onSliderSizeChange()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        self.pav.setElementsSize(CGRectMake(0, 0, size.width, size.height));
    }
    
    func pinchAction(){
        println("ffg")
        self.pav.onPinch()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

