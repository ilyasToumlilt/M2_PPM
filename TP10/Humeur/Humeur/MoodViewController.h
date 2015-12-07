//
//  MoodViewController.h
//  Humeur
//
//  Created by m2sar on 07/12/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constants.h"

@class MoodSplitViewController;

@protocol MoodViewControllerDelegate;

@interface MoodViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate,UISplitViewControllerDelegate>
    @property (retain)UIPickerView*upv;
    @property (retain) MoodSplitViewController *splitVC;
    @property (nonatomic,assign) id<MoodViewControllerDelegate> delegate;
@end

@protocol MoodViewControllerDelegate <NSObject>
-(void)sendNewMood:(NSUInteger)indMood;
@end