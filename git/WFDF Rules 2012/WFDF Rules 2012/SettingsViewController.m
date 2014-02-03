//
//  SettingsViewController.m
//  Rules
//
//  Created by Claudius Kirsch on 23.09.09.
//  Copyright 2009 Claudius Kirsch. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"


@implementation SettingsViewController

@synthesize selectedLanguage, selection, navItem, popoverController;

-(IBAction)saveSettings:(id)sender {
	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	//save the settings
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setObject:selectedLanguage forKey:@"language"];


	// tell the delegate to reload the data, if appropriate
	if(![selectedLanguage isEqualToString:appDelegate.savedLanguage] && selectedLanguage != NULL) {
		//NSLog(@"reload data: %@", selectedLanguage);
		[appDelegate reloadPages:selectedLanguage];
		//set the savedLanguage of our delegate to the newly selected one. The initial savedLanguage gets only loaded on startup.
		appDelegate.savedLanguage = selectedLanguage;
	}
	
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		[self dismissModalViewControllerAnimated:YES];
	} else {
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:appDelegate.currentRow inSection:0];
		[appDelegate.tableView.delegate tableView:appDelegate.tableView didSelectRowAtIndexPath:indexPath];
		[appDelegate.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:appDelegate.currentRow inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
		[self.popoverController dismissPopoverAnimated:YES];
	}
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navItem.title = NSLocalizedString(@"settings", @"settings title");
//	if(!self.navigationController) {
//		self.navigationController = [[UINavigationController alloc] initWithRootViewController:self];
//		NSLog(@"%@", self.navigationController);
//	}
	
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//		self.clearsSelectionOnViewWillAppear = NO;
		self.contentSizeForViewInPopover = CGSizeMake(320.0, 140.0);
		
		// save button
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveSettings:)];
	}
}




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//		self.parentViewController.contentSizeForViewInPopover = CGSizeMake(320.0, 140.0);
		[self.popoverController setPopoverContentSize:CGSizeMake(320.0, 180.0) animated:YES];
	}
}


/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.popoverController=nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.languages.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set up the cell...
	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	cell.textLabel.text = [appDelegate.languages objectAtIndex:indexPath.row];
	cell.accessoryType = UITableViewCellAccessoryNone;
	
	//set the checkmark: if the saved value equals the text of the cell, make a checkmark.
	if([appDelegate.savedLanguage isEqualToString:cell.textLabel.text]) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
		self.selection = indexPath;
	}
	
	
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return NSLocalizedString(@"language", @"Settings menu header");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	//get the selected language
	selectedLanguage = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
	
	//if a new cell was clicked, change the checkmark
	if ([indexPath compare:selection] != NSOrderedSame) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
		UITableViewCell *lastCell = [tableView cellForRowAtIndexPath:selection];
		lastCell.accessoryType = UITableViewCellAccessoryNone;
		self.selection = indexPath;
	}
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    //[super dealloc];
}


@end

