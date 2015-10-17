#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MiniNavView : UIView
    @property (retain, nonatomic) UIToolbar*          toolBarNav;
    @property (retain, nonatomic) UIBarButtonItem*    btnRefresh;
    @property (retain, nonatomic) UIBarButtonItem*    btnPrev;
    @property (retain, nonatomic) UIBarButtonItem*    btnNext;
    @property (retain, nonatomic) UIBarButtonItem*    btnUrl;
    @property (retain, nonatomic) UIWebView*          webView;

    -(void) setElementSize : (CGSize) frame;

@end

/*
 
 self.toolBarNav 
 self.btnRefresh
 self.btnPrev
 self.btnNext
 self.btnUrl
 self.webView
 
 */