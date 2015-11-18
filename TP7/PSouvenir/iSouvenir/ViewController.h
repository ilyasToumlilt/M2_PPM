//
//  ViewController.h
//  iSouvenir
//
//  Created by ilyas TOUMLILT on 16/11/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import "GlobalView.h"
#import "PToolbarView.h"
#import "PMapView.h"
#import "Contact.h"



@interface ViewController : UIViewController<PToolbarViewDelegate,
                                                PMapViewDelegate,
                                                ABPeoplePickerNavigationControllerDelegate,
                                                UIImagePickerControllerDelegate,
                                                UINavigationControllerDelegate>

@property (nonatomic, assign) ABPeoplePickerNavigationController *addressBookController;

@end

