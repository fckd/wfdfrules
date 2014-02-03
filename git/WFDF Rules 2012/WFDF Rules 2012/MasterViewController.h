//
//  MasterViewController.h
//  WFDF Rules 2012
//
//  Created by Claudius Kirsch on 16.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "InfoViewController.h"
#import "SettingsViewController.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property(strong, nonatomic) DetailViewController *detailViewController;
@property(strong, nonatomic) AppDelegate *appDelegate;
@property(strong, nonatomic) InfoViewController *infoViewController;
@property(strong, nonatomic) SettingsViewController *settingsViewController;
@property (strong, nonatomic) DetailViewController *mainDetailViewController;
@property (nonatomic, retain) UIPopoverController *settingsPopover;
@property (nonatomic, retain) UINavigationController *settingsNavigationController;

@end
