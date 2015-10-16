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
    let GUIDELINE_VERT:CGFloat = 20;
    let GUIDELINE_HORI:CGFloat = 20;
    
    let MIN_CMPT_IMG = 1;
    let MAX_CMPT_IMG = 20;
 
    let HORIZONTAL_GUIDELINE:CGFloat = 20;
    let VERTICAL_GUIDELINE :CGFloat = 20;
    
    let IMAGE_NAME_PREFIX = "photo-";
    let IMAGE_NAME_SUFIX = ".jpg";
    
    let IMGS_TXTS:[String] = [
        "Lorem ipsum dolor",
        "sit amet consectetur",
        "adipiscing elit sed",
        "do eiusmod tempor ",
        "ut labore et dolore ",
        "Ut enim ad minim ",
        "exercitation ullamco ",
        "ex ea commodo consequa",
        "Duis aute irure dolor ",
        "in reprehenderit in",
        "voluptate velit esse",
        "cillum dolore eu fugiat",
        "nulla pariatur Excepteur",
        "sint occaecat cupidatat",
        "proident sunt in culpa",
        "officia deserunt mollit",
        "anim id est laborum",
        "Sed ut perspiciatis unde",
        "omnis iste natus error",
        "voluptatem accusantium",
    ];
    
    var cmptImg : Int!;
    
    var curImageCmpt:Int=1;
    var curImage : UIImage!;
    
    var myToolBar : UIVisualEffectView!;
    var sliderSize: UISlider!;
    var zoomScaleView:UIVisualEffectView!;
    var myImageView:UIImageView!;
    var myScrollView:UIScrollView!;
    var btnPrev : UIButton!;
    var btnNext :UIButton!;
    var imgText :UILabel!;
    var imgZoomScaleLabel:UILabel!;
    
    override init(frame: CGRect)
    {
        super.init(frame: frame);
        
        self.cmptImg = self.MIN_CMPT_IMG;
        
        self.imgZoomScaleLabel = UILabel();
        self.imgZoomScaleLabel.textAlignment = .Center;
        
        self.myToolBar = UIVisualEffectView(effect: UIBlurEffect(style: .Dark));
        self.zoomScaleView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight));
        
        self.btnPrev = UIButton();
        self.btnNext = UIButton();
        self.imgText = UILabel();
        
        self.btnPrev.setTitle("<<", forState: .Normal);
        self.btnNext.setTitle(">>", forState: .Normal);
        
        self.imgText.textAlignment = .Center;
        self.imgText.textColor = UIColor.whiteColor()
        
        self.myImageView=UIImageView();
        self.myScrollView = UIScrollView();
        self.myScrollView.addSubview(self.myImageView);

        self.myScrollView.minimumZoomScale=0.0;
        self.myScrollView.maximumZoomScale=1;
        self.myScrollView.zoomScale = 0.0;

        self.sliderSize = UISlider();
        self.sliderSize.maximumValue = 100;
        self.sliderSize.minimumValue = 0;
        
        self.setElementsSize(frame);
        
        self.addSubview(self.myScrollView);
        self.addSubview(self.zoomScaleView);
        self.addSubview(self.imgZoomScaleLabel)
        self.addSubview(self.myToolBar);
        self.addSubview(self.btnNext)
        self.addSubview(self.btnPrev)
        self.addSubview(self.imgText)
        self.addSubview(self.sliderSize);
    }

    func setElementsSize(frame:CGRect)
    {
        self.myToolBar.frame = CGRect(x: 0, y: 0, width: frame.width, height: 50);
        
        self.btnPrev.frame = CGRect(x: self.GUIDELINE_HORI, y: 5, width: 30, height: self.myToolBar.frame.height)
        self.btnNext.frame = CGRect(x: self.myToolBar.frame.width - self.btnNext.frame.width - (self.GUIDELINE_HORI), y: 5, width: 30, height: self.myToolBar.frame.height)
        
        self.imgText.frame = CGRect(
            x: self.GUIDELINE_HORI+self.btnPrev.frame.width,
            y: 5,
            width: frame.width-(self.btnPrev.frame.width+self.btnNext.frame.width+(2*self.GUIDELINE_VERT)),
            height: self.myToolBar.frame.height
        );
        
        self.zoomScaleView.frame = CGRect(x: 0, y: self.myToolBar.frame.height, width: frame.width, height: 20);
        self.imgZoomScaleLabel.frame = CGRectMake(0, self.myToolBar.frame.height, frame.width, self.zoomScaleView.frame.height)
        self.sliderSize.frame = CGRectMake(self.VERTICAL_GUIDELINE, frame.height - 40, frame.width-(2*self.VERTICAL_GUIDELINE), 40);
        self.myScrollView.frame = CGRectMake(0, 0, frame.width, frame.height-self.myToolBar.frame.height-self.zoomScaleView.frame.height);
        self.updateImg()
    }
    
    func setImgSize(frame:CGRect)
    {
        var imgHeight:CGFloat ;
        var imgWidth:CGFloat;
        var newHeight:CGFloat;
        var newWidth : CGFloat;
        
        imgWidth = self.curImage.size.width;
        imgHeight = self.curImage.size.height;
        newWidth = self.curImage.size.width;
        newHeight = self.curImage.size.height;
        
        if(imgWidth > frame.width)
        {
            if(imgWidth > imgHeight)
            {
                newWidth = frame.width;
                newHeight = (newWidth * frame.width) / frame.height;
            }
            else{
                newWidth = frame.width;
                newHeight = (imgHeight * frame.width) / imgWidth;
            }
        }
        
        self.myImageView.frame = CGRectMake(0, self.myToolBar.frame.height, newWidth, newHeight);
        self.myScrollView.contentSize = CGSizeMake(newWidth, newHeight);
    }
    
    func getImgName(cmpt : Int)->String{
        return self.IMAGE_NAME_PREFIX + (cmpt < 10 ? "0" : "") + String(cmpt) + self.IMAGE_NAME_SUFIX;
    }

    func nextImg()
    {
        self.cmptImg = (self.cmptImg + 1 >= self.MAX_CMPT_IMG ? self.MIN_CMPT_IMG : self.cmptImg + 1);
        self.updateImg();
    }
    
    func prevImg()
    {
        self.cmptImg = (self.cmptImg-1 < self.MIN_CMPT_IMG ? self.MAX_CMPT_IMG: self.cmptImg-1);
        self.updateImg();
    }
    
    func updateImg(){
        self.imgZoomScaleLabel.text = "0 % "
        self.curImage = UIImage(named: self.getImgName(self.cmptImg));
        self.myImageView.image = self.curImage;
        self.imgText.text = self.IMGS_TXTS[self.cmptImg-1];
        self.setImgSize(self.myScrollView.frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



/*


var ubbiPrev : UIBarButtonItem!;
var ubbiNext :UIBarButtonItem!;
var ubbiImgText :UIBarButtonItem!;


self.myToolBar.setItems([
self.ubbiPrev ,
self.ubbiImgText,
self.ubbiNext
],
animated: false
);
self.ubbiPrev.style = .Done;
self.ubbiPrev.title = "<<";
self.ubbiNext.style = .Done;
self.ubbiNext.title = ">>";

*/







