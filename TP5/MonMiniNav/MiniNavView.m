#import "MiniNavView.h"

@interface MiniNavView(){
    CGFloat HORIZ_GUIDELINE ;
    CGFloat VERTIC_GUIDELINE ;
    CGFloat PADDING ;
    NSString* DEFAULT_URL;
    NSString* savedHomeURL;
}
@end

@implementation MiniNavView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    NSMutableArray* navButtons ;

    if (self)
    {
        self->HORIZ_GUIDELINE = 30;
        self->VERTIC_GUIDELINE = 5;
        self->PADDING = 5;
        self->DEFAULT_URL = @"http://lip6.fr";
        self->savedHomeURL = @"";
        
        self.toolBarNav = [[UIToolbar alloc]init];
        
        self.btnLoadHome = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(doLoadHomeAction)];
        self.btnPrev     = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(doPrevAction)];
        self.btnNext     = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(doNextAction)];
        self.btnUrl      = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(doURLAction)];
        self.btnChgHome  = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(doChgHomeAction)];
        
        self.btnPrev.enabled = NO;
        self.btnNext.enabled = NO;
        
        self.btnLoadHome.style = UIBarButtonItemStyleDone;
        self.btnPrev.style     = UIBarButtonItemStyleDone;
        self.btnNext.style     = UIBarButtonItemStyleDone;
        self.btnUrl.style      = UIBarButtonItemStyleDone;

        navButtons = [[NSMutableArray alloc] initWithCapacity:7];
        [navButtons addObject:self.btnLoadHome];    [self.btnLoadHome   release];
        [navButtons addObject:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace  target:nil action:nil] autorelease] ];
        [navButtons addObject:self.btnPrev];        [self.btnPrev       release];
        [navButtons addObject:self.btnUrl];         [self.btnUrl        release];
        [navButtons addObject:self.btnNext];        [self.btnNext       release];
        [navButtons addObject:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace  target:nil action:nil] autorelease] ];
        [navButtons addObject:self.btnChgHome];     [self.btnChgHome    release];
        [self.toolBarNav setItems:navButtons];

        self.webView = [[UIWebView alloc]init];
        self.webView.delegate=self;
        
        self.indicaView = [[UIActivityIndicatorView alloc]init];
        self.indicaView.backgroundColor = [UIColor blackColor];
        self.indicaView.hidesWhenStopped = YES;
        
        [self addSubview:self.toolBarNav];  [self.toolBarNav    release];
        [self addSubview:self.webView];     [self.webView       release];
        [self addSubview:self.indicaView];  [self.indicaView    release];

        [self setElementSize:frame.size];
    }
    return self;
}

-(void) setElementSize : (CGSize) frame
{
    const CGFloat STDR_DIM = 50;
    
    self.frame = CGRectMake(0, 0, frame.width, frame.height);
    
    self.toolBarNav.frame = CGRectMake(
        self->VERTIC_GUIDELINE,
        self->HORIZ_GUIDELINE,
        frame.width - (2*self->VERTIC_GUIDELINE),
        STDR_DIM
    );

    self.webView.frame = CGRectMake(
       self->VERTIC_GUIDELINE,
       self->HORIZ_GUIDELINE + self.toolBarNav.frame.size.height,
       frame.width - (2*self->VERTIC_GUIDELINE),
       frame.height - self.toolBarNav.frame.size.height - (2 * self->HORIZ_GUIDELINE)
    );

    self.indicaView.frame = CGRectMake(
        self.webView.frame.origin.x + (self.webView.frame.size.width/2) - (STDR_DIM/2),
        self.webView.frame.origin.y + (self.webView.frame.size.height/2) - (STDR_DIM/2),
        STDR_DIM,
        STDR_DIM
    );
}

-(void)doLoadHomeAction{
    [self goToUrl:(([self->savedHomeURL length])?self->savedHomeURL:self->DEFAULT_URL)];
}

-(void)doChgHomeAction{

    UIActionSheet *popup = [[UIActionSheet alloc]initWithTitle:@"Confirmez le changement"
                                                      delegate:self
                                             cancelButtonTitle:@"Annuler"
                                        destructiveButtonTitle:@"Oui"
                                             otherButtonTitles:
                                                nil];
    
    popup.tag = 0;

    //[popup showInView:[UIApplication sharedApplication].keyWindow];
    [popup showFromBarButtonItem:self.btnChgHome animated:YES];
}

-(void)doURLAction{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Votre URL"
                                                    message:@"Saisissez-la ici"
                                                   delegate:self
                                          cancelButtonTitle:@"Aller à"
                                          otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = 1;
    [alert show];
    [alert release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(alertView.tag==0)
        self->savedHomeURL = [[alertView textFieldAtIndex:0].text retain];

    if(alertView.tag==1)
        [self goToUrl:[alertView textFieldAtIndex:0].text];
}

-(void) goToUrl:(NSString*) strUrl
{
    NSLog(@"%@", strUrl);
    NSString *fullURL =strUrl;
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
    
    
}

-(void)doNextAction
{
    if ([self.webView canGoForward]){
        [self.webView goForward];
    }
}

-(void)doPrevAction
{
    if ([self.webView canGoBack]){
        [self.webView goBack];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.indicaView startAnimating];
    
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.indicaView stopAnimating];
    
    self.btnPrev.enabled = [self.webView canGoBack];
    self.btnNext.enabled = [self.webView canGoForward];
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
    [alert release];
    
    [self.indicaView stopAnimating];
}

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
         [alert show];
         [alert release];
    }
}

@end