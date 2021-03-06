//
//  PMapView.m
//
//
//  Created by ilyas TOUMLILT on 16/11/2015.
//
//

#import "PMapView.h"

@interface PMapView(){
    BOOL isImageVisible;
    CGSize curFrame;
    UIImageView *targetView;
    MKPointAnnotation* selectedAnn;
    CLLocationCoordinate2D currentPos;
    CLLocationManager* locationManager;
}
@end

@implementation PMapView

#define HORIZONTAL_GUIDELINE 30.0
#define VERTICAL_GUIDELINE   30.0
#define TARGET_IMG_SIZE      30.0
#define SCV_BASE_HEIGHT      40.0

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self->isImageVisible = NO;
        self->selectedAnn=nil;
        
        self->locationManager = [ [ CLLocationManager alloc] init];
        self->locationManager.distanceFilter = kCLDistanceFilterNone;
        self->locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self->locationManager.delegate=self;
        [self->locationManager requestAlwaysAuthorization];
        [self->locationManager startUpdatingLocation];
        
        self.mv = [[MKMapView alloc]initWithFrame:frame];
        [self.mv setScrollEnabled:YES];
        [self.mv setZoomEnabled:YES];
        [self.mv setShowsUserLocation:YES];
        [self.mv setPitchEnabled:YES];
        [self.mv setMapType:MKMapTypeStandard];
        self.mv.delegate=self;
        self.mv.showsBuildings = YES;//todo pour 3d
        
        MKMapCamera *newCamera = [[self.mv camera] copy];
        [newCamera setPitch:45.0];
        [newCamera setHeading:50.0];
        [newCamera setAltitude:500.0];
        [self.mv setCamera:newCamera animated:YES];
        
        [self addSubview:self.mv];
        //[self.mv release];
        
        //sélection du type de carte
        self.scv=[[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"3D",@"Carte",@"Satélite",@"Hybride",nil]];
        [self.scv addTarget:self action:@selector(mapTypeChanges) forControlEvents:UIControlEventValueChanged];
        [self.scv setSelectedSegmentIndex:0];
        [self.scv setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.scv];
        //[self.scv release];
        
        self->targetView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"target"]];
        [self addSubview:self->targetView];
        [self->targetView release];
        
        self.iv = [[UIImageView alloc]init];
        [self addSubview:self.iv];
        //[self.iv release];
        
        self->curFrame = frame.size;
        [self setElementsSize:self->curFrame];
    }
    return self;
}

-(void)hideImage{
    self->isImageVisible = NO;
    [self setElementsSize:self->curFrame];
}

-(void)showImage:(UIImage*)image{
    self->isImageVisible = YES;
    self.iv.image = image;
    [self setElementsSize:self->curFrame];
}

-(void)setElementsSize:(CGSize)size
{
    CGFloat mapVHeight,mapHHeight;
    self->curFrame=size;
    
    self.frame = CGRectMake(0, 0, self->curFrame.width, self->curFrame.height) ;
    self.iv.hidden= !self->isImageVisible;
    
    //mode paysage
    if(self->curFrame.width>self->curFrame.height){
        mapHHeight =self->isImageVisible ? self->curFrame.width/2:self->curFrame.width;
        self.mv.frame = CGRectMake(0, 0, mapHHeight, self->curFrame.height);
        
        if(self->isImageVisible)
        {//à doite, côté de self.mv
            self.iv.frame=CGRectMake(
                                     self->curFrame.width/2,
                                     0,
                                     self->curFrame.width/2,
                                     self->curFrame.height
                                     );
        }
    }
    else
    {
        mapVHeight = self->isImageVisible ? self->curFrame.height/2:self->curFrame.height;
        self.mv.frame = CGRectMake(0, 0, self->curFrame.width, mapVHeight);
        
        if(self->isImageVisible)
        {//au dessous de self.mv
            self.iv.frame=CGRectMake(
                                     0,
                                     self->curFrame.height/2,
                                     self->curFrame.width,
                                     self->curFrame.height/2
                                     );
        }
    }
    
    //le symbole toujours au milieu de la carte
    self->targetView.frame = CGRectMake(
                                        (self.mv.frame.size.width/2)-(TARGET_IMG_SIZE/2),
                                        (self.mv.frame.size.height/2)-(TARGET_IMG_SIZE/2),
                                        TARGET_IMG_SIZE,
                                        TARGET_IMG_SIZE
                                        );
    
    //height, width en poucentage ?
    self.scv.frame = CGRectMake(
                                VERTICAL_GUIDELINE,
                                HORIZONTAL_GUIDELINE,
                                self.mv.frame.size.width-(2*VERTICAL_GUIDELINE),
                                self->isImageVisible ? SCV_BASE_HEIGHT/2:SCV_BASE_HEIGHT
                                );
}

- (void)drawSubviews:(CGSize)size
{
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            size.width,
                            size.height);
    
    [self setElementsSize:size];
}

/*
 Quand on appuye sur le selected control,
 on change le type de carte.
 Le type 0 n'est pas implémenté, il nécessite le 3d
 http://nscookbook.com/2013/10/ios-programming-recipe-30-using-3d-mapping/
 */
-(void)mapTypeChanges
{
    switch (self.scv.selectedSegmentIndex) {
        case 0:
            [self.mv setMapType:MKMapTypeStandard];
            [self.mv setPitchEnabled:YES];
            break;
        case 1:
            [self.mv setPitchEnabled:NO];
            [self.mv setMapType:MKMapTypeStandard];
            break;
        case 2:
            [self.mv setMapType:MKMapTypeSatellite];
            break;
        case 3:
            [self.mv setMapType:MKMapTypeHybrid];
            break;
            
    }
}



/**
 * doit remplacer putPin
 * Contact est déjà un MKAnnotation
 * il suffit de modifier sa prop coordinates
 * et de le rajouter à la mapView.
 * ne pas le release.
 */
- (void)addNewPin:(Contact*)c
{
    //transformation du centre de la MapView en coordonnés grâce convertPoint
    CGPoint point = CGPointMake(self.mv.frame.size.width/2,self.mv.frame.size.height/2);
    CLLocationCoordinate2D pinPoint = [self.mv convertPoint:point toCoordinateFromView:self.mv];
    
    c.coordinate = pinPoint;
    
    MKPointAnnotation *newPin = [[MKPointAnnotation alloc] init];
    [newPin setTitle:c.title];
    [newPin setSubtitle:c.subtitle];
    newPin.coordinate = pinPoint;
    
    [self.mv addAnnotation:newPin];
}


/**
 * - le VC est assez intelligent pour n'appeler cette
 * méthode que si un pin est sélectionné, mais on
 * testera quand même.
 * - supprime le pin selectionné.
 * - pas de release
 * - retourne le number du pin selectionné ( prop contact )
 */
- (void)removeSelectedPin
{
    [self.mv removeAnnotation:self->selectedAnn];
    self->selectedAnn=nil;
}

- (void)updateSelectedPin:(NSString*)newTitle
{
    
    MKPointAnnotation *newPin = [[MKPointAnnotation alloc] init];
    [newPin setTitle:selectedAnn.title];
    [newPin setSubtitle:newTitle];
    newPin.coordinate = selectedAnn.coordinate;
    
    [self.mv removeAnnotation:self->selectedAnn];
    [self.mv addAnnotation:newPin];
}
/************* Managing Annotation Selection ***************/
/**
 * Lorsqu'une Annotation est sélectionnée
 * - vérifier si elle a une photo, si c'est le cas, l'afficher.
 * - signaler la sélection au VC délégué.
 */
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    self->selectedAnn = [view.annotation retain] ;
    
    
    [_delegate retain];
    if([_delegate respondsToSelector:@selector(didSelectPin:)]){
        [_delegate didSelectPin:selectedAnn.title];
    }
    [_delegate release];
    
}


/**
 * Lorsqu'une Annotation n'est plus sélectionnée :
 * - virer la photo s'il le faut
 * - signaler l'événement au chef
 */
/*
 Dernière annotation sectionnée.
 On stocke la MKAnnotationView et non pas la MKPointAnnotation ajoutée dans self.putPin
 */
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    
    self->selectedAnn=nil;
    
    [_delegate retain];
    if([_delegate respondsToSelector:@selector(didDiselectPin)]){
        [_delegate didDiselectPin];
    }
    [_delegate release];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *newLocation = [locations lastObject];
    self->currentPos = newLocation.coordinate;
}

-(CLLocationCoordinate2D) getCurrentPosition{
    return self->currentPos;
}

-(void)gotToCurrentPosition{
    [self.mv setCenterCoordinate:self->currentPos];
}

- (void)dealloc
{
    [_mv release];
    [_iv release];
    [_scv release];
    [super dealloc];
}


@end
