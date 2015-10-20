//
//  MiniNavView.h
//  
//
//  Created by ilyas TOUMLILT on 20/10/2015.
//
//

#import <UIKit/UIKit.h>

@protocol MiniNavViewDelegate;

@interface MiniNavView : UIView <UIWebViewDelegate, UIAlertViewDelegate, UIActionSheetDelegate>

@property (assign, nonatomic) id<MiniNavViewDelegate> delegate;

/* TODO: Tout ça en public ?? */
@property (retain, nonatomic) UIToolbar*                toolBarNav;
@property (retain, nonatomic) UIBarButtonItem*          loadHomeButton;
@property (retain, nonatomic) UIBarButtonItem*          prevPageButton;
@property (retain, nonatomic) UIBarButtonItem*          changeHomePageButton;
@property (retain, nonatomic) UIBarButtonItem*          nextPageButton;
@property (retain, nonatomic) UIBarButtonItem*          changeUrlButton;

@property (retain, nonatomic) UIWebView*                myWebView;
@property (retain, nonatomic) UIActivityIndicatorView*  indicaView;

- (void)drawSubviews:(CGSize)frame;

@end

@protocol MiniNavViewDelegate <NSObject>

- (void)loadHomeAction;
- (void)prevPageAction;
- (void)changeHomePageAction:(NSString*)newUrl;
- (void)nextPageAction;
- (void)goToUrlAction:(NSString*)targetUrl;

@end
