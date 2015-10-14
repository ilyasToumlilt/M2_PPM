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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.pav.myImageView;
    }
}

