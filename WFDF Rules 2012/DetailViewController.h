//
//  DetailViewController.h
//  WFDF Rules 2012
//
//  Created by Claudius Kirsch on 16.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Page.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) Page *detailItem;
@property (unsafe_unretained, nonatomic) IBOutlet UIWebView *webView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
