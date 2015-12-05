//
//  ViewController.h
//  Humeur
//
//  Created by m2sar on 05/12/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSNetServiceDelegate, NSNetServiceBrowserDelegate, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (retain)UITableView*utbv;
@property (retain)UIPickerView*upv;

@end

