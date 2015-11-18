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
    Contact *currentContact;        /* Le contact sélectionné */
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
    
    /* aucun contect n'est selected au début */
    currentContact = nil;
    
    /* adding and releasing stuff */
    [self.view addSubview:myView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * Pour redessiner la vue lors d'une rotation
 */
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [myView drawSubviews:size];
}

/**
 * On permet la rotation
 */
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
    /* on rajoute un new pin vide */
    Contact* c = [[Contact alloc] initWithNumber:(int)contactsArray.count
                                         andName:[NSString stringWithFormat:@"Pas de contact"]];
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
    if( currentContact ) {
        [myView.myPMap removeSelectedPin];
        [contactsArray removeObject:currentContact];
        currentContact = nil;
    }
}

/**
 * Called when refresh button is tapped
 * to go to actual location
 */
- (void)moveToCurrentLocation
{
    /* TODO */
}

/**
 * Called when bookmarks button is tapped
 * to assign a contact to annotation
 */
- (void)assignContactToAnnotation
{
    [self showAddressBook];
}

/**
 * Called when camera button is tapped
 * to take a picture for the contact
 */
- (void)takeNewPicture
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self presentViewController:picker animated:YES completion:NULL];
    } else {
        UIPopoverController* popover = [[UIPopoverController alloc] initWithContentViewController:picker];
        [popover presentPopoverFromBarButtonItem:myView.myPToolbar.cameraItem
                        permittedArrowDirections:UIPopoverArrowDirectionUp
                                        animated:YES];
    }
}

/**
 * Called when organize item is tapped
 * to pick an image from the gallery
 */
- (void)pickNewPicture
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self presentViewController:picker animated:YES completion:NULL];
    } else {
        UIPopoverController* popover = [[UIPopoverController alloc] initWithContentViewController:picker];
        [popover presentPopoverFromBarButtonItem:myView.myPToolbar.galleryItem
                        permittedArrowDirections:UIPopoverArrowDirectionUp
                                        animated:YES];
    }
    
}
/**
 * must retain YES if camera source is available
 */
- (BOOL)hasCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

/************************ Handling Map Actions **********************/
/**
 * appelé par la map quand un pin c est selected
 */
- (void)didSelectPin:(Contact*)c
{
    currentContact = c;
    [myView.myPToolbar PTitemsEditConfiguration];
}

/**
 * appelé par la map quand un pin ( currentContact ) n'est plus selected
 */
- (void)didDiselectPin
{
    currentContact = nil;
    [myView.myPToolbar PTitemsIdleConfiguration];
}

/************************ AddressBook actions ************************/
/**
 * Affiche le carnet de contacts
 * Pour un iPad l'affichage se fait dans un popover
 */
- (void)showAddressBook
{
    _addressBookController = [[ABPeoplePickerNavigationController alloc] init];
    [_addressBookController setPeoplePickerDelegate:self];
    if([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self presentViewController:_addressBookController animated:YES completion:nil];
    } else {
        UIPopoverController* popover = [[UIPopoverController alloc] initWithContentViewController:_addressBookController];
        [popover presentPopoverFromBarButtonItem:myView.myPToolbar.addressBookItem
                        permittedArrowDirections:UIPopoverArrowDirectionUp
                                        animated:YES];
    }
}

/**
 * Appelé quand un contact a été selectionné dans le carnet d'adresses
 * le contact catché sera associé au pin courant
 */
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person
{
    NSMutableString* name = [[NSMutableString alloc] initWithFormat:@""];
    NSString *firstName = (NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    [name appendString:firstName];
    [name appendString:@" "];
    NSString *lastName= (NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
    [name appendString:lastName];
    
    if (currentContact) {
        /* TODO */
    }
    
}

/**
 * appelé à la fermeture de l'addressBook
 */
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    [_addressBookController dismissViewControllerAnimated:YES completion:nil];
    [_addressBookController release];
}

/********************** PickerView actions ***********************/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSLog(@"SELECTED");
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

/************************ additionnal setup *********************/
- (void)dealloc
{
    [myView         release];
    [contactsArray  release];
    
    [super dealloc];
}

@end
