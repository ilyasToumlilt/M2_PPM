//
//  LMDetailsViewController.h
//  Localise-Moi
//
//  Created by m2sar on 07/12/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LMMapView.h"
#import "LMLocation.h"

@class LMSplitViewController;

@protocol LMDetailsViewControllerDelegate;

@interface LMDetailsViewController : UIViewController<NSXMLParserDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate, LMMapViewDelegate>

//@property (readwrite, nonatomic, retain) LMSplitViewController* splitVC;
@property (nonatomic, retain) LMMapView* myLMMapView;

@property (nonatomic, assign) id<LMDetailsViewControllerDelegate> delegate;

@end

@protocol LMDetailsViewControllerDelegate <NSObject>

- (void)addLocation:(CLLocationCoordinate2D)location withRequest:(NSString*)request;

@end
