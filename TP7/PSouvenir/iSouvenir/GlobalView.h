//
//  GlobalView.h
//  
//
//  Created by ilyas TOUMLILT on 16/11/2015.
//
//

#import <UIKit/UIKit.h>
#import "PToolbarView.h"
#import "PMapView.h"

@interface GlobalView : UIView

@property (retain, nonatomic) PToolbarView *myPToolbar;
@property (retain, nonatomic) PMapView     *myPMap;

- (void)drawSubviews:(CGSize)size;

@end
