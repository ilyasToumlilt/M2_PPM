//
//  MiniNavView.m
//  
//
//  Created by ilyas TOUMLILT on 20/10/2015.
//
//

#import "MiniNavView.h"

@implementation MiniNavView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        /* toolBarNav */
        _toolBarNav = [[UIToolbar alloc] init];
        
        /* loadHomeButton */
        _loadHomeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(loadHomeButtonActionHandler)];
        _loadHomeButton.style = UIBarButtonItemStyleDone;
        
        /* prevPageButton */
        _prevPageButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(prevPageButtonActionHandler)];
        _prevPageButton.enabled = NO;
        _prevPageButton.style = UIBarButtonItemStyleDone;
        
        /* changeHomeAdressButton */
        _changeHomePageButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(changeHomePageButtonActionHandler)];
        
        /* nextPageButton */
        _nextPageButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(nextPageButtonActionHandler)];
        _nextPageButton.enabled = NO;
        _nextPageButton.style = UIBarButtonItemStyleDone;
        
        /* newUrlButton */
        _changeUrlButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(goToUrlButtonActionHandler)];
        _changeUrlButton.style = UIBarButtonItemStyleDone;
        
        /* Adding this cool items to the toolBar */
        NSMutableArray* navButtons = [[NSMutableArray alloc] initWithCapacity:7];
        [navButtons addObject:_loadHomeButton]; [_loadHomeButton release];
        [navButtons addObject:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace  target:nil action:nil] autorelease]];
        [navButtons addObject:_prevPageButton]; [_prevPageButton release];
        [navButtons addObject:_changeUrlButton]; [_changeUrlButton release];
        [navButtons addObject:_nextPageButton]; [_nextPageButton release];
        [navButtons addObject:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace  target:nil action:nil] autorelease]];
        [navButtons addObject:_changeHomePageButton]; [_changeHomePageButton release];
        [_toolBarNav setItems:navButtons];
        
        /* myWebView */
        _myWebView = [[UIWebView alloc] init];
        _myWebView.delegate = self;
        
        /* indicaView */
        _indicaView = [[UIActivityIndicatorView alloc]init];
        _indicaView.backgroundColor = [UIColor blackColor];
        _indicaView.hidesWhenStopped = YES;
        
        /* drawing my cool stuff */
        [self drawSubviews:frame.size];
        
        /* Adding and releasing subviews */
        [self addSubview:_toolBarNav]; [_toolBarNav release];
        [self addSubview:_myWebView];  [_myWebView  release];
        [self addSubview:_indicaView]; [_indicaView release];
    }
    
    return self;
}

- (void)drawSubviews:(CGSize)frame
{
    const CGFloat STDR_DIM = 50;
    const CGFloat V_BORDERLINE = 5;
    const CGFloat H_BORDERLINE = 30;
    
    self.frame = CGRectMake(0, 0, frame.width, frame.height);
    
    /* toolBarNav */
    _toolBarNav.frame = CGRectMake(V_BORDERLINE,
                                   H_BORDERLINE,
                                   frame.width - (2*V_BORDERLINE),
                                   STDR_DIM);
    
    /* myWebView */
    _myWebView.frame = CGRectMake(V_BORDERLINE,
                                  H_BORDERLINE + _toolBarNav.frame.size.height,
                                  frame.width - (2*V_BORDERLINE),
                                  frame.height - _toolBarNav.frame.size.height - (2*H_BORDERLINE));
    
    /* indicaView */
    _indicaView.frame = CGRectMake(_myWebView.frame.origin.x + (_myWebView.frame.size.width/2) -
                                    (STDR_DIM/2),
                                   _myWebView.frame.origin.y + (_myWebView.frame.size.height/2) - (STDR_DIM/2),
                                   STDR_DIM,
                                   STDR_DIM);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/* -----> Action Handlers:
 * they will all be delegated to parent ViewController.
 */

- (void)loadHomeButtonActionHandler
{
    [_delegate retain];
    if([_delegate respondsToSelector:@selector(loadHomeAction)]){
        [_delegate loadHomeAction];
    }
    [_delegate release];
}

- (void)prevPageButtonActionHandler
{
    [_delegate retain];
    if([_delegate respondsToSelector:@selector(prevPageAction)]){
        [_delegate prevPageAction];
    }
    [_delegate release];
}

- (void)changeHomePageButtonActionHandler
{
    UIActionSheet *popup = [[UIActionSheet alloc]initWithTitle:@"Confirmez le changement"
                                                      delegate:self
                                             cancelButtonTitle:@"Annuler"
                                        destructiveButtonTitle:@"Oui"
                                             otherButtonTitles:nil];
    
    popup.tag = 0;
    
    [popup showFromBarButtonItem:_changeHomePageButton animated:YES];
}

- (void)nextPageButtonActionHandler
{
    [_delegate retain];
    if([_delegate respondsToSelector:@selector(nextPageAction)]){
        [_delegate nextPageAction];
    }
    [_delegate release];
}

- (void)goToUrlButtonActionHandler
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Votre URL"
                                                    message:@"Saisissez-la ici"
                                                   delegate:self
                                          cancelButtonTitle:@"Aller à"
                                          otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = 1;
    [alert textFieldAtIndex:0].text = @"http://";
    [alert show];
    [alert release];
}

/*** I am a delegate :-) ***/
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 0 && buttonIndex == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Changer accueil"
                                                        message:@"Saisissez-la ici"
                                                       delegate:self
                                              cancelButtonTitle:@"Aller à"
                                              otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        alert.tag = 0;
        [alert textFieldAtIndex:0].text = @"http://";
        [alert show];
        [alert autorelease];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    /* changing home URL */
    if( alertView.tag == 0 ){
        [_delegate retain];
        if([_delegate respondsToSelector:@selector(changeHomePageAction:)]){
            [_delegate changeHomePageAction:[[alertView textFieldAtIndex:0].text retain]];
        }
        [_delegate release];
    }
    
    /* load page from url */
    if( alertView.tag == 1 ){
        [_delegate retain];
        if([_delegate respondsToSelector:@selector(goToUrlAction:)]){
            [_delegate goToUrlAction:[alertView textFieldAtIndex:0].text];
        }
        [_delegate release];
    }
}

-(void)webView:(UIWebView *)myWebView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:error.localizedDescription
                                                    message:error.localizedFailureReason
                                                   delegate:self
                                          cancelButtonTitle:@"Fermer"
                                          otherButtonTitles:nil];
    alert.tag = 2;
    [alert show];
    [alert autorelease];
    
    [_indicaView stopAnimating];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [_indicaView startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_indicaView stopAnimating];
    
    _prevPageButton.enabled = [_myWebView canGoBack];
    _nextPageButton.enabled = [_myWebView canGoForward];
}

@end
