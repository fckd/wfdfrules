//
//  SettingsViewController.h
//  Rules
//
//  Created by Claudius Kirsch on 23.09.09.
//  Copyright 2009 Claudius Kirsch. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsViewController : UIViewController {
	NSString *selectedLanguage;
	NSIndexPath *selection;
	IBOutlet UINavigationItem *navItem;
}

@property(nonatomic, retain) NSString *selectedLanguage;
@property(nonatomic, retain) NSIndexPath *selection;
@property(nonatomic, retain) UINavigationItem *navItem;

-(IBAction)saveSettings:(id)sender;


@end
