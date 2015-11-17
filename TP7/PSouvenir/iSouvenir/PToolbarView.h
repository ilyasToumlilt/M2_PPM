//
//  PToolbarView.h
//  
//
//  Created by ilyas TOUMLILT on 16/11/2015.
//
//

#import <UIKit/UIKit.h>

@protocol  PToolbarViewDelegate;

@interface PToolbarView : UIView

@property (assign, nonatomic) id<PToolbarViewDelegate> delegate;

@property (assign, nonatomic) UIToolbar *myToolbar;

/**
 * Quand aucune annontation n'est sélectionnée, certains bouttons de la barre
 * doivent être grisés, inutilisables.
 */
- (void)PTitemsIdleConfiguration;
/**
 * Dans le cas où une annotation serait sélectionnée, les boutons d'édition
 * doivent être utilisables.
 */
- (void)PTitemsEditConfiguration;

- (void)drawSubviews:(CGSize)size;

@end

@protocol PToolbarViewDelegate <NSObject>

/**
 * Called when addButtonItem is touched down
 * to create a new annotation
 */
- (void)newAnnotation;

/**
 * Called when trashButtonItem is touched down
 * to remove selected annotation
 */
- (void)removeSelectedAnnotation;

/**
 * Called when refresh button is tapped
 * to go to actual location
 */
- (void)moveToCurrentLocation;

/**
 * Called when bookmarks button is tapped
 * to assign a contact to annotation
 */
- (void)assignContactToAnnotation;

/**
 * Called when camera button is tapped
 * to take a picture for the contact
 */
- (void)takeNewPicture;

/**
 * Called when organize item is tapped
 * to pick an image from the gallery
 */
- (void)pickNewPicture;

/**
 * must retain YES if camera source is available
 */
- (BOOL)hasCamera;


@end
