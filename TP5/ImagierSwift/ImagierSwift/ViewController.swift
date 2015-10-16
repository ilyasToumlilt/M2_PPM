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
        self.pav = PhotoAlbumView(frame: self.view.frame);
        self.pav.myScrollView.delegate = self;
        self.view.addSubview(pav);
        
        self.pav.btnPrev.addTarget(self, action: "imgPrevAction", forControlEvents: .TouchDown);
        self.pav.btnNext.addTarget(self, action: "imgNextAction", forControlEvents: .TouchDown);
    }
    
    func imgPrevAction(){
        self.pav.prevImg();
        print("dfkjdfjkdfjk");
    }
    
    func imgNextAction(){
        self.pav.nextImg();
        print("dfkjdfjkdfjk");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.pav.myImageView;
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        self.pav.setElementsSize(CGRectMake(0, 0, size.width, size.height));
    }
    
}

