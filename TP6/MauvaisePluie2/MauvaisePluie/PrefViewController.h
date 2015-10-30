//
//  PrefViewController.h
//  
//
//  Created by ilyas TOUMLILT on 26/10/2015.
//
//

#import <UIKit/UIKit.h>

@protocol PrefViewControllerDelegate;

@interface PrefViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (assign, nonatomic) id<PrefViewControllerDelegate> delegate;

@property (assign, nonatomic) int level;

- (instancetype)init;

- (void)showView;
- (void)hideView;

@end

@protocol PrefViewControllerDelegate <NSObject>

- (void)endedPrefAction;

@end
