//
//  LMDetailsViewController.m
//  Localise-Moi
//
//  Created by m2sar on 07/12/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import "LMDetailsViewController.h"

@interface LMDetailsViewController ()

/* pour le parse : */
@property (nonatomic, retain) NSMutableData* buffer;
@property (nonatomic, retain) NSMutableString* strBuffer;
@property (nonatomic, retain) NSXMLParser* parser;
@property (nonatomic, assign) BOOL locationSIG;
@property (nonatomic, assign) BOOL latSIG;
@property (nonatomic, assign) BOOL lngSIG;
@property (nonatomic, assign) BOOL foundSIG;
/* data */
@property (nonatomic, assign) CLLocationCoordinate2D currentLocation;
@property (nonatomic, retain) NSString* currentRequest;

@end

@implementation LMDetailsViewController

- (instancetype)init
{
    [super init];
    
    if(self){
        /* tabBarItem pour les iphones < 6 */
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone &&
            [[UIScreen mainScreen] scale] != 3.0) {
            self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Localisation" image:[UIImage imageNamed:@"icone-terre"] tag:1];
        }
        /* titre de la navigationBar */
        self.navigationItem.title = [NSString stringWithFormat:@"Localisation"];
        
        /* buffer received data */
        _buffer = [[NSMutableData alloc] init];
        _strBuffer = [[NSMutableString alloc] init];
        _locationSIG = NO;
        _latSIG = NO;
        _lngSIG = NO;
        _foundSIG = NO;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /* myLMMapView */
    _myLMMapView = [[LMMapView alloc] initWithFrame:self.view.frame];
    _myLMMapView.delegate = self;
    
    /* Adding my cool subviews */
    [self.view addSubview:_myLMMapView];
    
    /* releasing stuff */
    [_myLMMapView release];
    
    /* pour choper les retours du background */
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(returnsFromBackground)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];

}

- (void)returnsFromBackground
{
    if( [[[NSUserDefaults standardUserDefaults] stringForKey:@"sat_preference"] isEqualToString:@"0"]){
        [_myLMMapView hideSatelliteSegment];
    } else {
        [_myLMMapView showSatelliteSegment];
    }
}

/************************************************************************************************
 * Managing subviews
 ***********************************************************************************************/
- (void)drawSubviews:(CGSize)size
{
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, size.width, size.height);
    
    [_myLMMapView drawSubviews:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, size.width, size.height)];
}

- (void)viewDidLayoutSubviews
{
    [self drawSubviews:[[[[self navigationController] topViewController] view] frame].size];
}

/************************************************************************************************
 * LMMapViewDelegate
 ***********************************************************************************************/
- (void)searchAddress:(NSString *)adr
{
    [_buffer setLength:0]; // je clean le buffer.
    
    _currentRequest = [NSString stringWithString:[adr copy]];
    NSString* escapedString = [adr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    
    NSURL* URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/xml?address=%@&sensor=false", escapedString]];
    NSURLRequest* req = [NSURLRequest requestWithURL:URL];
    [NSURLConnection connectionWithRequest:req
                                  delegate:self];
}

/************************************************************************************************
 * NSURLConnectionDelegate & NSURLConnectionDataDelegate
 ***********************************************************************************************/
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Problème réseau"
                                                    message:@"Vérifiez votre connexion réseau"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];

    [alert show];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_buffer appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _parser = [[NSXMLParser alloc] initWithData:_buffer];
    _parser.delegate = self;
    [_parser parse];
}

/************************************************************************************************
 * NSXMLParserDelegate
 ***********************************************************************************************/
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    _strBuffer = [NSMutableString stringWithFormat:@""];
    _foundSIG = NO;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if(!_foundSIG){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Not found"
                                                        message:@"Adresse Introuvable !"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        
        [alert show];
    } else {
        [_myLMMapView goToLocation:_currentLocation];
        
        [_delegate retain];
        [_delegate addLocation:_currentLocation withRequest:_currentRequest];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Problème XML"
                                                    message:@"Le fichier XML est mal formé"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    
    [alert show];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:[NSString stringWithFormat:@"location"]] && !_foundSIG) {
        _locationSIG = YES;
    }
    else if([elementName isEqualToString:[NSString stringWithFormat:@"lat"]] && _locationSIG) {
        _strBuffer = [NSMutableString stringWithFormat:@""];
        _latSIG = YES;
    }
    else if([elementName isEqualToString:[NSString stringWithFormat:@"lng"]] && _locationSIG) {
        _strBuffer = [NSMutableString stringWithFormat:@""];
        _lngSIG = YES;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(_locationSIG && _latSIG){
        [_strBuffer appendString:string];
    }
    else if (_locationSIG && _lngSIG){
        [_strBuffer appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:[NSString stringWithFormat:@"location"]]) {
        _locationSIG = NO;
        _foundSIG = YES;
        //[parser abortParsing];
    }
    else if([elementName isEqualToString:[NSString stringWithFormat:@"lat"]] && _locationSIG) {
        _latSIG = NO;
        _currentLocation.latitude = [_strBuffer doubleValue];
    }
    else if([elementName isEqualToString:[NSString stringWithFormat:@"lng"]] && _locationSIG) {
        _lngSIG = NO;
        _currentLocation.longitude = [_strBuffer doubleValue];
    }
}
/************************************************************************************************
 * Memory Care Center
 ***********************************************************************************************/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_buffer release];
    [_strBuffer release];
    _delegate = nil;
    
    [super dealloc];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
