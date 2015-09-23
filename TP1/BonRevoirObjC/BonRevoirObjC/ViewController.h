//
//  ViewController.h
//  BonRevoirObjC
//
//  Created by m2sar on 19/09/2015.
//
//  @author Ilyas  Toumlilt - <ilyas.toumlilt@etu.upmc.fr>
//  @author Adrien Ferreira - <adrien.ferreira@etu.upmc.fr>
//
//  Copyright (c) 2015 m2sar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UIButton *myButton;

- (IBAction)onClickMyButton:(id)sender;

@end

