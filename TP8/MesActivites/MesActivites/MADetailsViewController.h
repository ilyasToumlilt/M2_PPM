//
//  MADetailsViewController.h
//  MesActivites
//
//  Created by m2sar on 23/11/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef __MA_DETAILS_VC_H__
#define __MA_DETAILS_VC_H__

@class MASplitViewController;
@class MaTask;

@protocol MADetailsViewControllerDelegate;

@interface MADetailsViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (nonatomic, assign) id<MADetailsViewControllerDelegate> delegate;

@property (readwrite, nonatomic, retain) MASplitViewController *splitVC;

@property (nonatomic, retain) UILabel* titleLabel;
@property (nonatomic, retain) UITextField* titleTextField;
@property (nonatomic, retain) UILabel* priorityLabel;
@property (nonatomic, retain) UISegmentedControl* prioritySC;
@property (nonatomic, retain) UIImageView* pictureImageView;
@property (nonatomic, retain) UIBarButtonItem* pictureBarButtonItem;

@property (nonatomic, retain) MaTask* currentTask;

- (void)updateDetailsViewWithTask:(MaTask*)task;
- (void)drawSubviews:(CGSize)frame;

@end

@protocol MADetailsViewControllerDelegate <NSObject>

- (void)didUpdateDetails;
- (MaTask*)getInitialTask;

@end

#endif