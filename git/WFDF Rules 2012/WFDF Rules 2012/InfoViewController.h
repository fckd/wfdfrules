//
//  InfoViewController.h
//  Rules
//
//  Created by Claudius Kirsch on 02.09.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface InfoViewController : UIViewController <MFMailComposeViewControllerDelegate> {
	IBOutlet UIButton *buttonBack;
	IBOutlet UIButton *buttonMail;
	IBOutlet UIButton *buttonDfv;
	IBOutlet UIButton *buttonWfdf;
}

@property(nonatomic,retain) UIButton *buttonBack;
@property(nonatomic,retain) UIButton *buttonMail;
@property(nonatomic,retain) UIButton *buttonDfv;
@property(nonatomic,retain) UIButton *buttonWfdf;

-(IBAction)back:(id)sender;
-(IBAction)mailto:(id)sender;
-(IBAction)actionDfv:(id)sender;
-(IBAction)actionWfdf:(id)sender;

-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;

@end
