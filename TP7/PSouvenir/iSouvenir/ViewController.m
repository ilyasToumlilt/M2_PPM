//
//  ViewController.m
//  iSouvenir
//
//  Created by ilyas TOUMLILT on 16/11/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    GlobalView *myView;             /* Vue principale de l'application */
    NSMutableArray *contactsArray;  /* Tableau de contacts */
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /***************** GlobalView setup ********************/
    myView = [[GlobalView alloc] initWithFrame:self.view.frame];
    [myView.myPToolbar setDelegate:self];
    
    /***************** Model setup *************************/
    contactsArray = [[NSMutableArray alloc] init];
    
    /* adding and releasing stuff */
    [self.view addSubview:myView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [myView drawSubviews:size];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

/************* Handling PToolbar actions ( I'm a delegate ;-) ) ************/
/**
 * Called when addButtonItem is touched down
 * to create a new annotation
 */
- (void)newAnnotation
{
    NSLog(@"TODO newAnnotation called");
    Contact* c = [[Contact alloc] initWithNumber:(int)contactsArray.count
                                         andName:[NSString stringWithFormat:@"toto %d", (int)contactsArray.count]];
    [contactsArray addObject:c];
    [myView.myPMap putPin:c.name];
    [c release];
}

/**
 * Called when trashButtonItem is touched down
 * to remove selected annotation
 */
- (void)removeSelectedAnnotation
{
    NSLog(@"TODO removeSelectedAnnotation called");
}

/**
 * Called when refresh button is tapped
 * to go to actual location
 */
- (void)moveToCurrentLocation
{
    NSLog(@"TODO moveToCurrentLocation called");
}

/**
 * Called when bookmarks button is tapped
 * to assign a contact to annotation
 */
- (void)assignContactToAnnotation
{
    NSLog(@"TODO assignContactToAnnotation called");
}

/**
 * Called when camera button is tapped
 * to take a picture for the contact
 */
- (void)takeNewPicture
{
    NSLog(@"TODO takeNewPicture");
}

/**
 * Called when organize item is tapped
 * to pick an image from the gallery
 */
- (void)pickNewPicture
{
    NSLog(@"TODO pickNewPicture called");
}

/**
 * must retain YES if camera source is available
 */
- (BOOL)hasCamera
{
    NSLog(@"TODO hasCamera is not respected bro");
    return YES;
}

/************************ Handling Map Actions **********************/
- (void)didSelectPin:(Contact*)c
{
    /* TODO */
}

- (void)didDiselectPin
{
    /* TODO */
}

/************************ additionnal setup *********************/
- (void)dealloc
{
    [myView         release];
    [contactsArray  release];
    
    [super dealloc];
}

@end
