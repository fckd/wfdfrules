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

// private interface, only needed inside this object
@interface AppDelegate (Private)
- (void)createEditableCopyOfDatabaseIfNeeded;
- (void)initializeDatabase;
@end

@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize splitViewController = _splitViewController;
@synthesize pages, languages, savedLanguage, languageDirectory, tableView;
@synthesize langs, title, content, currentRow;

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
	    
		masterViewController.mainDetailViewController = detailViewController;
	    self.window.rootViewController = self.splitViewController;
	}
//	custom code
	[self createEditableCopyOfDatabaseIfNeeded];
	[self initializeDatabase];
	
	self.languages = [[NSMutableArray alloc] initWithObjects:@"English", @"Deutsch", nil];
	// get the prefs
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//	self.savedLanguage = [prefs stringForKey:@"language"];
//	if(savedLanguage == nil) {
//		NSLog(@"Nothing Saved");
//		//[self createPages:@"English"];
//		//set an initial value to savedLanguage to get a checkmark
//		self.savedLanguage = @"English";
//		[self reloadPages:savedLanguage];
//	} else {
//		NSLog(@"Saved Language: %@", savedLanguage);
//		//[self createPages:savedLanguage];
//		[self reloadPages:savedLanguage];
//	}
	
	self.savedLanguage = @"English";
	[self reloadPages:savedLanguage];
	
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)reloadPages:(NSString *)language {	
	//define the localized path to load the correct files
//	if([language isEqualToString:@"English"]) {
//		self.languageDirectory = @"English.lproj";
//	} else if([language isEqualToString:@"Deutsch"]) {
//		self.languageDirectory = @"German.lproj";
//	}
	
//	[self createPages:language];
	
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
//	self.pages = [[NSMutableArray alloc] initWithObjects:null,one,two,three,four,five,six,seven,eight,nine,ten,eleven,twelve,thirteen,fourteen,fifteen,sixteen,seventeen,eighteen,nineteen,twenty,twentyone,twentytwo,nil];
	//[data release];
}

#pragma mark database
// Creates a writable copy of the bundled default database in the application Documents directory.
- (void)createEditableCopyOfDatabaseIfNeeded {
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"langs.sqlite"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) return;
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"langs.sqlite"];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

// Open the database connection and retrieve minimal information for all objects.
- (void)initializeDatabase {
	NSMutableArray *tablesArray = [[NSMutableArray alloc] init];
	NSString *currentLanguage = @"german";
    NSMutableArray *pageArray = [[NSMutableArray alloc] init];
    self.pages = pageArray;
    // The database is stored in the application bundle. 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"langs.sqlite"];
	
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
//		get all table names
		NSString *tableString = @"SELECT name FROM sqlite_master WHERE type IN ('table','view') AND name NOT LIKE 'sqlite_%' UNION ALL SELECT name FROM sqlite_temp_master WHERE type IN ('table','view') ORDER BY 1";
		sqlite3_stmt *statement;    
        if (sqlite3_prepare_v2(database, [tableString UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
				NSString *tableName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
//				NSLog(@"%@", tableName);
                [tablesArray addObject:tableName];
            }
        }
        // "Finalize" the statement - releases the resources associated with the statement.
        sqlite3_finalize(statement);
		statement = nil;
		

        // Get the primary key for all books.
//        const char *sql = "SELECT key FROM german";
		NSString *queryString = [NSString stringWithFormat:@"SELECT key FROM %@", currentLanguage];
//        sqlite3_stmt *statement;
        // Preparing a statement compiles the SQL query into a byte-code program in the SQLite library.
        // The third parameter is either the length of the SQL string or -1 to read up to the first null terminator.        
        if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
                // The second parameter indicates the column index into the result set.
                int primaryKey = sqlite3_column_int(statement, 0);
                // We avoid the alloc-init-autorelease pattern here because we are in a tight loop and
                // autorelease is slightly more expensive than release. This design choice has nothing to do with
                // actual memory management - at the end of this block of code, all the book objects allocated
                // here will be in memory regardless of whether we use autorelease or release, because they are
                // retained by the books array.
                Page *page = [[Page alloc] initWithPrimaryKey:primaryKey database:database language:currentLanguage];
                [self.pages addObject:page];
            }
        }
        // "Finalize" the statement - releases the resources associated with the statement.
        sqlite3_finalize(statement);
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }
	
//	NSLog(@"%@", [[NSString alloc] initWithFormat:[[pages objectAtIndex:1] content]]);
//	NSLog(@"%i", self.pages.count);
}

#pragma mark -



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
