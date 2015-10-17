#import "MiniNavView.h"

@interface MiniNavView(){
    CGFloat HORIZ_GUIDELINE ;
    CGFloat VERTIC_GUIDELINE ;
    CGFloat PADDING ;
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
        
        self.toolBarNav = [[UIToolbar alloc]init];
        
        self.btnRefresh = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(doRefreshAction)];
        self.btnPrev    = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(doPrevAction)];
        self.btnNext    = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(doNextAction)];
        self.btnUrl     = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(doRefreshAction)];
        
        self.btnRefresh.style = UIBarButtonItemStyleDone;
        self.btnPrev.style    = UIBarButtonItemStyleDone;
        self.btnNext.style    = UIBarButtonItemStyleDone;
        self.btnUrl.style     = UIBarButtonItemStyleDone;

        navButtons = [[NSMutableArray alloc] initWithCapacity:4];
        [navButtons addObject:self.btnRefresh]; [self.btnRefresh release];
        [navButtons addObject:self.btnPrev];    [self.btnPrev release];
        [navButtons addObject:self.btnNext];    [self.btnNext release];
        [navButtons addObject:self.btnUrl];     [self.btnUrl release];
        [self.toolBarNav setItems:navButtons];

        self.webView = [[UIWebView alloc]init];
        //[self setBackgroundColor:[UIColor yellowColor]];
        
        [self addSubview:self.toolBarNav];  [self.toolBarNav release];
        [self addSubview:self.webView];     [self.webView release];

        [self setElementSize:frame.size];
    }
    return self;
}

-(void) setElementSize : (CGSize) frame
{
    self.toolBarNav.frame = CGRectMake(
        self->VERTIC_GUIDELINE,
        self->HORIZ_GUIDELINE,
        frame.width - (2*self->VERTIC_GUIDELINE),
        50
    );
    
    self.webView.frame = CGRectMake(
       self->VERTIC_GUIDELINE,
       self->HORIZ_GUIDELINE + self.toolBarNav.frame.size.height,
       frame.width - (2*self->VERTIC_GUIDELINE),
       frame.height - self.toolBarNav.frame.size.height - (2 * self->HORIZ_GUIDELINE)
    );
}

-(void) doRefreshAction{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Votre URL"
                                                    message:@"Saisissez-la ici"
                                                   delegate:self
                                          cancelButtonTitle:@"Aller à"
                                          otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
    [alert release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
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

-(void)doNextAction{
    if ([self.webView canGoForward])
        [self.webView goForward];}

-(void)doPrevAction{
    if ([self.webView canGoBack])
        [self.webView goBack];
}

@end