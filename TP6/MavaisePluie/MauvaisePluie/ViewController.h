//
//  ViewController.h
//  MauvaisePluie
//
//  Created by ilyas TOUMLILT on 26/10/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ScoreViewController.h"
#import "GameViewController.h"
#import "PrefViewController.h"

@interface ViewController : UIViewController

@property (retain, nonatomic) ScoreViewController* myScoreVC;
@property (retain, nonatomic) GameViewController*  myGameVC;
@property (retain, nonatomic) PrefViewController*  myPrefView;

@end

