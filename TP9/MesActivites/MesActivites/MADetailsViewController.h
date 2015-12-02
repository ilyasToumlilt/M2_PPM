//
//  MADetailsViewController.h
//  MesActivites
//
//  Created by m2sar on 23/11/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MediaPlayer;

#ifndef __MA_DETAILS_VC_H__
#define __MA_DETAILS_VC_H__

@class MASplitViewController;
@class MaTask;

@protocol MADetailsViewControllerDelegate;

@interface MADetailsViewController : UIViewController< UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, assign) id<MADetailsViewControllerDelegate> delegate;

@property (readwrite, nonatomic, retain) MASplitViewController *splitVC;

@property (nonatomic, retain) UILabel* actionLabel;
@property (nonatomic, retain) UILabel* songName;
@property (nonatomic, retain) UIProgressView* songPV;
@property (nonatomic, retain) UILabel* progressLabel;

//- (void)updateDetailsViewWithTask:(MaTask*)task;
- (void)drawSubviews:(CGSize)frame;
-(void) playHistoryEntry:(MPMediaItem*)curSong;
@end

@protocol MADetailsViewControllerDelegate <NSObject>

- (void)addSongToHistory:(MPMediaItem*)curSong;

@end

#endif