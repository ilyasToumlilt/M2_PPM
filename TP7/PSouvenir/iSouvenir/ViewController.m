//
//  ViewController.m
//  iSouvenir
//
//  Created by ilyas TOUMLILT on 16/11/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /***************** GlobalView setup ********************/
    GlobalView *myView = [[GlobalView alloc] initWithFrame:self.view.frame];
    
    [myView.myPToolbar setDelegate:self];
    
    /* adding and releasing stuff */
    [self.view addSubview:myView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/************* Handling PToolbar actions ( I'm a delegate ;-) ) ************/
/**
 * Called when addButtonItem is touched down
 * to create a new annotation
 */
- (void)newAnnotation
{
    NSLog(@"TODO newAnnotation called");
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

@end
