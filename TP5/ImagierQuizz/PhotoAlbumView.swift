//
//  PhotoAlbumView.swift
//  ImagierQuizz
//
//  Created by m2sar on 13/10/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

import Foundation
import UIKit

class PhotoAlbumView: UIView
{
    let HORIZONTAL_GUIDELINE:CGFloat = 20;
    let VERTICAL_GUIDELINE :CGFloat = 20;
    
    let IMAGE_NAME_PREFIX = "photo-";
    let IMAGE_NAME_SUFIX = ".jpg";
 
    var curImageCmpt:Int=1;
    var curImage : UIImage!;
    
    var myToolBar : UIToolbar!;
    var sliderSize: UISlider!;
    var myImageView:UIImageView!;
    var myScrollView:UIScrollView!;
    
    override init(frame: CGRect)
    {
        super.init(frame: frame);
        
        self.myToolBar = UIToolbar();
        self.myToolBar.backgroundColor = UIColor.blackColor();
        
        self.myToolBar.setItems([
                UIBarButtonItem(title: "<<<", style: .Done, target: self, action: "sendAction:"),
                UIBarButtonItem(title: "Coucou", style: .Done, target: self, action: "sendAction:"),
                UIBarButtonItem(title: ">>>", style: .Done, target: self, action: "sendAction:")
            ],
            animated: false
        );
        
        self.myImageView=UIImageView();
        self.curImage = UIImage(named: self.IMAGE_NAME_PREFIX+String(0)+String(self.curImageCmpt)+".jpg")
        self.myImageView.image = self.curImage;
        
        self.myScrollView = UIScrollView();
        self.myScrollView.addSubview(self.myImageView);
        
        self.myScrollView.minimumZoomScale=0.5;
        self.myScrollView.maximumZoomScale=6.0;
        self.myScrollView.zoomScale = 3;
        
        self.sliderSize = UISlider();
        self.sliderSize.maximumValue = 100;
        self.sliderSize.minimumValue = 0;
        
        self.setElementsSize(frame);
        self.addSubview(self.myScrollView);
        self.addSubview(self.myToolBar);
        self.addSubview(self.sliderSize);
    }

    func setElementsSize(frame:CGRect)
    {
        self.myToolBar.frame = CGRect(x: 0, y: 0, width: frame.width, height: 50);
        self.myImageView.frame = CGRectMake(0, self.myToolBar.frame.height, self.curImage.size.width, self.curImage.size.height);
        self.sliderSize.frame = CGRectMake(self.VERTICAL_GUIDELINE, frame.height - 40, frame.width-(2*self.VERTICAL_GUIDELINE), 40);
        self.myScrollView.contentSize = CGSizeMake(self.curImage.size.height, self.curImage.size.width);
        self.myScrollView.frame = CGRectMake(0, 0, frame.width, frame.height-self.myToolBar.frame.height);
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}