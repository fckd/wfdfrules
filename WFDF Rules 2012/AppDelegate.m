//
//  AppDelegate.m
//  WFDF Rules 2012
//
//  Created by Claudius Kirsch on 16.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Page.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize splitViewController = _splitViewController;
@synthesize pages, languages, savedLanguage, languageDirectory, tableView;
@synthesize langs, title, content;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    MasterViewController *masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController_iPhone" bundle:nil];
	    self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
	    self.window.rootViewController = self.navigationController;
	} else {
	    MasterViewController *masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController_iPad" bundle:nil];
	    UINavigationController *masterNavigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
	    
	    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController_iPad" bundle:nil];
	    UINavigationController *detailNavigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
		
	    self.splitViewController = [[UISplitViewController alloc] init];
	    self.splitViewController.delegate = detailViewController;
	    self.splitViewController.viewControllers = [NSArray arrayWithObjects:masterNavigationController, detailNavigationController, nil];
	    
	    self.window.rootViewController = self.splitViewController;
	}
//	custom code
	self.languages = [[NSMutableArray alloc] initWithObjects:@"English", @"Deutsch", nil];
	// get the prefs
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	self.savedLanguage = [prefs stringForKey:@"language"];
	if(savedLanguage == nil) {
		NSLog(@"Nothing Saved");
		//[self createPages:@"English"];
		//set an initial value to savedLanguage to get a checkmark
		self.savedLanguage = @"English";
		[self reloadPages:savedLanguage];
	} else {
		NSLog(@"Saved Language: %@", savedLanguage);
		//[self createPages:savedLanguage];
		[self reloadPages:savedLanguage];
	}
	
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)reloadPages:(NSString *)language {	
	//define the localized path to load the correct files
	if([language isEqualToString:@"English"]) {
		self.languageDirectory = @"English.lproj";
	} else if([language isEqualToString:@"Deutsch"]) {
		self.languageDirectory = @"German.lproj";
	}
	
	[self createPages:language];
	
	[self.tableView reloadData];
}

-(void)createPages:(NSString *)language {
	NSMutableDictionary *data = [NSMutableDictionary dictionary];
	NSLog(@"createPages: %@", language);
	
	if([language isEqualToString:@"English"]) {
		[data setValue:@"Introduction" forKey:@"00"];
		[data setValue:@"Spirit of the Game" forKey:@"01"];
		[data setValue:@"Playing Field" forKey:@"02"];
		[data setValue:@"Equipment" forKey:@"03"];
		[data setValue:@"Point, Goal and Game" forKey:@"04"];
		[data setValue:@"Teams" forKey:@"05"];
		[data setValue:@"Starting a Game" forKey:@"06"];
		[data setValue:@"The Pull" forKey:@"07"];
		[data setValue:@"Status of the Disc" forKey:@"08"];
		[data setValue:@"Stall Count" forKey:@"09"];
		[data setValue:@"The Check" forKey:@"10"];
		[data setValue:@"Out-of-Bounds" forKey:@"11"];
		[data setValue:@"Receivers and Positioning" forKey:@"12"];
		[data setValue:@"Turnovers" forKey:@"13"];
		[data setValue:@"Scoring" forKey:@"14"];
		[data setValue:@"Calling Fouls, Infractions and Violations" forKey:@"15"];
		[data setValue:@"Continuation after a Foul or Violation Call" forKey:@"16"];
		[data setValue:@"Fouls" forKey:@"17"];
		[data setValue:@"Infractions and Violations" forKey:@"18"];
		[data setValue:@"Stoppages" forKey:@"19"];
		[data setValue:@"Time-Outs" forKey:@"20"];
		[data setValue:@"Definitions" forKey:@"21"];
		[data setValue:@"Legal License" forKey:@"22"];
	} else if([language isEqualToString:@"Deutsch"]) {
		[data setValue:@"Einleitung" forKey:@"00"];
		[data setValue:@"Spirit of the Game" forKey:@"01"];
		[data setValue:@"Spielfeld" forKey:@"02"];
		[data setValue:@"Ausrüstung" forKey:@"03"];
		[data setValue:@"Punkt, Punktgewinn und Spiel" forKey:@"04"];
		[data setValue:@"Mannschaften" forKey:@"05"];
		[data setValue:@"Spielbeginn" forKey:@"06"];
		[data setValue:@"Anwurf" forKey:@"07"];
		[data setValue:@"Status der Scheibe" forKey:@"08"];
		[data setValue:@"Anzählen" forKey:@"09"];
		[data setValue:@"Check" forKey:@"10"];
		[data setValue:@"Bestimmungen zum Aus" forKey:@"11"];
		[data setValue:@"Fänger und Stellung auf dem Spielfeld" forKey:@"12"];
		[data setValue:@"Turnover" forKey:@"13"];
		[data setValue:@"Punktgewinn" forKey:@"14"];
		[data setValue:@"Anzeigen von Regelverletzungen" forKey:@"15"];
		[data setValue:@"Weiterspielen nach einem Call" forKey:@"16"];
		[data setValue:@"Fouls" forKey:@"17"];
		[data setValue:@"Infractions und Violations" forKey:@"18"];
		[data setValue:@"Spielunterbrechungen" forKey:@"19"];
		[data setValue:@"Time-Outs" forKey:@"20"];
		[data setValue:@"Definitionen" forKey:@"21"];
		[data setValue:@"Rechtehinweis" forKey:@"22"];
	}
	
	Page *null = [[Page alloc] initWithTitle:[data valueForKey:@"00"] path:@"00_einleitung"];
	Page *one = [[Page alloc] initWithTitle:[data valueForKey:@"01"] path:@"01_spirit"];
	Page *two = [[Page alloc] initWithTitle:[data valueForKey:@"02"] path:@"02_spielfeld"];
	Page *three = [[Page alloc] initWithTitle:[data valueForKey:@"03"] path:@"03_ausruestung"];
	Page *four = [[Page alloc] initWithTitle:[data valueForKey:@"04"] path:@"04_punkt"];
	Page *five = [[Page alloc] initWithTitle:[data valueForKey:@"05"] path:@"05_mannschaften"];
	Page *six = [[Page alloc] initWithTitle:[data valueForKey:@"06"] path:@"06_spielbeginn"];
	Page *seven = [[Page alloc] initWithTitle:[data valueForKey:@"07"] path:@"07_anwurf"];
	Page *eight = [[Page alloc] initWithTitle:[data valueForKey:@"08"] path:@"08_scheibe"];
	Page *nine = [[Page alloc] initWithTitle:[data valueForKey:@"09"] path:@"09_anzaehlen"];
	Page *ten = [[Page alloc] initWithTitle:[data valueForKey:@"10"] path:@"10_check"];
	Page *eleven = [[Page alloc] initWithTitle:[data valueForKey:@"11"] path:@"11_aus"];
	Page *twelve = [[Page alloc] initWithTitle:[data valueForKey:@"12"] path:@"12_faenger"];
	Page *thirteen = [[Page alloc] initWithTitle:[data valueForKey:@"13"] path:@"13_turnover"];
	Page *fourteen = [[Page alloc] initWithTitle:[data valueForKey:@"14"] path:@"14_punktgewinn"];
	Page *fifteen = [[Page alloc] initWithTitle:[data valueForKey:@"15"] path:@"15_regelverletzungen"];
	Page *sixteen = [[Page alloc] initWithTitle:[data valueForKey:@"16"] path:@"16_weiterspielen"];
	Page *seventeen = [[Page alloc] initWithTitle:[data valueForKey:@"17"] path:@"17_fouls"];
	Page *eighteen = [[Page alloc] initWithTitle:[data valueForKey:@"18"] path:@"18_infractions"];
	Page *nineteen = [[Page alloc] initWithTitle:[data valueForKey:@"19"] path:@"19_unterbrechungen"];
	Page *twenty = [[Page alloc] initWithTitle:[data valueForKey:@"20"] path:@"20_timeouts"];
	Page *twentyone = [[Page alloc] initWithTitle:[data valueForKey:@"21"] path:@"21_definitionen"];
	Page *twentytwo = [[Page alloc] initWithTitle:[data valueForKey:@"22"] path:@"22_copyright"];
	
	//[self.pages release];
	self.pages = [[NSMutableArray alloc] initWithObjects:null,one,two,three,four,five,six,seven,eight,nine,ten,eleven,twelve,thirteen,fourteen,fifteen,sixteen,seventeen,eighteen,nineteen,twenty,twentyone,twentytwo,nil];
	//[data release];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
	/*
	 Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	 Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	 */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	/*
	 Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	 If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	 */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	/*
	 Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	 */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	/*
	 Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	 */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	/*
	 Called when the application is about to terminate.
	 Save data if appropriate.
	 See also applicationDidEnterBackground:.
	 */
}

@end
