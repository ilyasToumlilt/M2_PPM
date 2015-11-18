//
//  PToolbarView.m
//  
//
//  Created by ilyas TOUMLILT on 16/11/2015.
//
//

#import "PToolbarView.h"

@implementation PToolbarView

NSMutableArray *items;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self){
        /************* setting up the UIToolbar *****************/
        _myToolbar = [[UIToolbar alloc] init];
        //_myToolbar.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        /* items */
        items = [[NSMutableArray alloc] init];
        [items addObject:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                        target:self
                                                                        action:@selector(addButtonAction)]
                          autorelease]];
        [items addObject:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                                        target:self
                                                                        action:@selector(trashButtonAction)]
                          autorelease]];
        [items addObject:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                        target:nil
                                                                        action:nil]
                          autorelease]];
        [items addObject:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                        target:self
                                                                        action:@selector(refreshButtonAction)]
                          autorelease]];
        [items addObject:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                        target:nil
                                                                        action:nil]
                          autorelease]];
        _addressBookItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks
                                                                     target:self
                                                                    action:@selector(bookmarksButtonAction)];
        [items addObject:_addressBookItem];
        _cameraItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                                                    target:self
                                                                    action:@selector(cameraButtonAction)];
        [items addObject:_cameraItem];
        _galleryItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize
                                                                     target:self
                                                                     action:@selector(organizeButtonAction)];
        [items addObject:_galleryItem];
        
        [self drawSubviews:frame];
        
        [self PTitemsIdleConfiguration];
        
        [self addSubview:_myToolbar];
    }
    
    return self;
}

- (void)drawSubviews:(CGRect)frame
{
    self.frame = CGRectMake(frame.origin.x,
                            frame.origin.y,
                            frame.size.width,
                            frame.size.height);
    
    _myToolbar.frame = CGRectMake(0,
                                  0,
                                  self.frame.size.width,
                                  self.frame.size.height);
    
    
    [_myToolbar setItems:items animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/******************* Toolbar items state configuration **********************/
/**
 * Quand aucune annontation n'est sélectionnée, certains bouttons de la barre
 * doivent être grisés, inutilisables.
 */
- (void)PTitemsIdleConfiguration
{
    UIBarButtonItem* tmp;
    
    /* trash item */
    tmp = [items objectAtIndex:1];
    tmp.enabled = NO;
    
    /* bookmarks item */
    tmp = [items objectAtIndex:5];
    tmp.enabled = NO;
    
    /* camera item */
    tmp = [items objectAtIndex:6];
    tmp.enabled = NO;
    
    /* organize item */
    tmp = [items objectAtIndex:7];
    tmp.enabled = NO;
}

/**
 * Dans le cas où une annotation serait sélectionnée, les boutons d'édition
 * doivent être utilisables.
 */
- (void)PTitemsEditConfiguration
{
    UIBarButtonItem* tmp;
    
    /* trash item */
    tmp = [items objectAtIndex:1];
    tmp.enabled = YES;
    
    /* bookmarks item */
    tmp = [items objectAtIndex:6];
    tmp.enabled = YES;
    
    /* camera item */
    [_delegate retain];
    if([_delegate respondsToSelector:@selector(hasCamera)]){
        tmp = [items objectAtIndex:7];
        tmp.enabled = [_delegate hasCamera];
    }
    [_delegate release];
    
    /* organize item */
    tmp = [items objectAtIndex:8];
    tmp.enabled = YES;
}


/******************* Toolbar Actions ************************/
- (void)addButtonAction
{
    [_delegate retain];
    if([_delegate respondsToSelector:@selector(newAnnotation)]){
        [_delegate newAnnotation];
    }
    [_delegate release];
}

- (void)trashButtonAction
{
    [_delegate retain];
    if([_delegate respondsToSelector:@selector(removeSelectedAnnotation)]){
        [_delegate removeSelectedAnnotation];
    }
    [_delegate release];
}

- (void)refreshButtonAction
{
    [_delegate retain];
    if([_delegate respondsToSelector:@selector(moveToCurrentLocation)]){
        [_delegate moveToCurrentLocation];
    }
    [_delegate release];
}

- (void)bookmarksButtonAction
{
    [_delegate retain];
    if([_delegate respondsToSelector:@selector(assignContactToAnnotation)]){
        [_delegate assignContactToAnnotation];
    }
    [_delegate release];
}

- (void)cameraButtonAction
{
    [_delegate retain];
    if([_delegate respondsToSelector:@selector(takeNewPicture)]){
        [_delegate takeNewPicture];
    }
    [_delegate release];
}

- (void)organizeButtonAction
{
    [_delegate retain];
    if([_delegate respondsToSelector:@selector(pickNewPicture)]){
        [_delegate pickNewPicture];
    }
    [_delegate release];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)dealloc
{
    [_addressBookItem release];
    [_cameraItem release];
    [_galleryItem release];
    [items release];
    [_myToolbar release];
    [super dealloc];
}

@end
