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
    
    let MIN_CMPT_IMG = 1;
    let MAX_CMPT_IMG = 20;
 
    let HORIZONTAL_GUIDELINE:CGFloat = 30;
    let VERTICAL_GUIDELINE :CGFloat = 5;
    
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
        
        self.addSubview(self.myToolBar);
        self.addSubview(self.btnPrev)
        self.addSubview(self.btnNext)
        self.addSubview(self.imgText)
        self.addSubview(self.myScrollView);
        self.addSubview(self.zoomScaleView);
        self.addSubview(self.imgZoomScaleLabel)
        self.addSubview(self.sliderSize);
    }

    func setElementsSize(frame:CGRect)
    {
        self.myToolBar.frame = CGRect(
            x: self.VERTICAL_GUIDELINE,
            y: self.HORIZONTAL_GUIDELINE,
            width: frame.width-(2*self.VERTICAL_GUIDELINE),
            height: 50
        );
        
        self.btnPrev.frame = CGRect(
            x: self.VERTICAL_GUIDELINE,
            y: self.HORIZONTAL_GUIDELINE,
            width: 30,
            height: self.myToolBar.frame.height
        );
        
        self.btnNext.frame = CGRect(
            x: frame.width - (30 + self.VERTICAL_GUIDELINE),
            y: self.HORIZONTAL_GUIDELINE,
            width: 30,
            height: self.myToolBar.frame.height
        );
        
        self.imgText.frame = CGRect(
            x: self.VERTICAL_GUIDELINE+self.btnPrev.frame.width,
            y: self.HORIZONTAL_GUIDELINE,
            width: self.myToolBar.frame.width-(self.btnPrev.frame.width+self.btnNext.frame.width),
            height: self.myToolBar.frame.height
        );
        
        self.zoomScaleView.frame = CGRect(
            x: self.VERTICAL_GUIDELINE ,
            y: self.HORIZONTAL_GUIDELINE + self.myToolBar.frame.height,
            width: self.myToolBar.frame.width,
            height: 20
        );
        
        self.imgZoomScaleLabel.frame = CGRect(
            x: self.VERTICAL_GUIDELINE,
            y: self.myToolBar.frame.height+self.HORIZONTAL_GUIDELINE,
            width: frame.width,
            height: self.zoomScaleView.frame.height
        );
        
        self.myScrollView.frame = CGRect(
            x: self.VERTICAL_GUIDELINE,
            y: self.HORIZONTAL_GUIDELINE + self.myToolBar.frame.height,
            width: self.myToolBar.frame.width,
            height: frame.height-self.myToolBar.frame.height-(2*self.HORIZONTAL_GUIDELINE)
        );
        
        self.sliderSize.frame = CGRect(
            x: self.VERTICAL_GUIDELINE,
            y: frame.height - self.HORIZONTAL_GUIDELINE - 40,
            width: self.myToolBar.frame.width,
            height: 40
        );
        
        self.updateImg()
    }
    
    func setImgSize(frame:CGRect){
        /*
        var dims = self.getImgSize(frame)
        self.myImageView.frame = CGRectMake(0, 0, dims.0, dims.1);
        self.myScrollView.contentSize = CGSizeMake(dims.0, dims.1);*/
    }
    
    func getImgSize(frame:CGRect) -> (CGFloat, CGFloat)
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
        
        return (newWidth, newHeight);
    }
    
    func getImgName(cmpt : Int)->String{
        return self.IMAGE_NAME_PREFIX + (cmpt < 10 ? "0" : "") + String(cmpt) + self.IMAGE_NAME_SUFIX;
    }

    func onTouchNextImg()
    {
        println(self.curImageCmpt)
        self.cmptImg = (self.cmptImg + 1 >= self.MAX_CMPT_IMG ? self.MIN_CMPT_IMG : self.cmptImg + 1);
        self.updateImg();
        self.resetSliderZoomScale()
    }
    
    func onTouchPrevImg()
    {
        self.cmptImg = (self.cmptImg-1 < self.MIN_CMPT_IMG ? self.MAX_CMPT_IMG: self.cmptImg-1);
        self.updateImg();
        self.resetSliderZoomScale()
    }
    
    func updateImg(){
        self.resetSliderZoomScale()
        self.curImage = UIImage(named: self.getImgName(self.cmptImg));
        self.myImageView.image = self.curImage;
        self.imgText.text = self.IMGS_TXTS[self.cmptImg-1];
        //self.setImgSize(self.myScrollView.frame)
    
        self.myImageView.frame = CGRectMake(0, 0, self.curImage.size.width, self.curImage.size.height);
        self.myScrollView.contentSize = self.curImage.size;
    }
    
    func onSliderSizeChange()
    {
        var dims : (CGFloat,CGFloat) ;
        var newWidth:CGFloat;
        var newHeight:CGFloat;
        
        dims = self.getImgSize(self.myScrollView.frame);
        newWidth = dims.0 * CGFloat((1 + (self.sliderSize.value/100)));
        newHeight = dims.1 * CGFloat((1 + (self.sliderSize.value/100)));
        
        self.myImageView.frame.size = CGSize(width: newWidth, height: newHeight)
        self.updateZoomScaleLabel()
    }
    
    func resetSliderZoomScale(){
        self.sliderSize.value = 0;
        self.updateZoomScaleLabel();
    }
    
    func updateZoomScaleLabel(){
        self.imgZoomScaleLabel.text = String(Int(self.sliderSize.value)) + " %";
    }
    
    func onPinch(){
        
        if(self.myImageView.frame.width < self.myScrollView.frame.width){
            self.resetSliderZoomScale()
        }
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







