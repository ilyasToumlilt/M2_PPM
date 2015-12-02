//
//  MainView.m
//  rouleTaBille
//
//  Created by m2sar on 30/11/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import "MainView.h"

@interface MainView()

@property (nonatomic, retain) NSArray* imageNames;
@property (nonatomic, assign) int      imageCounter;

@end

@implementation MainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if( self ){
        /* compteur à 0 */
        _imageCounter = 0;
        
        /* le tableau contient la liste des images disponibles pour les fonds */
        _imageNames = [[NSArray alloc] initWithObjects:@"rouletabille-fond-eau",
                                                        @"rouletabille-fond-mosaique",
                                                        @"rouletabille-fond-phobos",
                                                        @"rouletabille-fond-voutes", nil];
        
        /* image de fond */
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:_imageNames[_imageCounter]]];
    }
    
    return self;
}

- (void)displayNextBackgroundImage
{
    _imageCounter = (_imageCounter+1)%_imageNames.count;
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:_imageNames[_imageCounter]]];
}

- (void)dealloc
{
    [_imageNames release];
    
    [super dealloc];
}

@end
