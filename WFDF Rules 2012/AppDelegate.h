//
//  AppDelegate.h
//  WFDF Rules 2012
//
//  Created by Claudius Kirsch on 16.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
	sqlite3 *database;
}


-(void)createPages:(NSString *)language;
-(void)reloadPages:(NSString *)language;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UISplitViewController *splitViewController;
@property (strong, nonatomic) UITableView *tableView;

@property(strong, nonatomic) NSMutableArray *pages;
//@property(nonatomic,retain) NSMutableArray *pages;
@property(strong, nonatomic) NSMutableArray *languages;
@property(strong, nonatomic) NSString *savedLanguage;
@property(strong, nonatomic) NSString *languageDirectory;
@property(strong, nonatomic) NSMutableArray *langs;
//@property (assign, nonatomic, readonly) NSInteger primaryKey;

@property(nonatomic) NSInteger currentRow;

//@property(assign, nonatomic, readonly) NSInteger primaryKey;
@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *content;

@end
