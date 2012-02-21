//
//  DetailViewController.h
//  WFDF Rules 2012
//
//  Created by Claudius Kirsch on 16.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Page.h"
#import "AppDelegate.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (retain, nonatomic) id detailItem;
@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property(strong, nonatomic) AppDelegate *appDelegate;

@end
