//
//  MaTask.h
//  
//
//  Created by ilyas TOUMLILT on 23/11/2015.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MaTask : NSObject

@property (nonatomic, retain) NSMutableString *title;
@property (nonatomic, retain) NSMutableString *subtitle;
@property (nonatomic, assign) int prio;
@property (nonatomic, retain) UIImage *picture;

@end
