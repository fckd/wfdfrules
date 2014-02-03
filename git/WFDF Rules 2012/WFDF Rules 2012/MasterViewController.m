//
//  MasterViewController.m
//  WFDF Rules 2012
//
//  Created by Claudius Kirsch on 16.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "Page.h"

@implementation MasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize appDelegate = _appDelegate;
@synthesize infoViewController, settingsViewController;
@synthesize mainDetailViewController,settingsPopover, settingsNavigationController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = NSLocalizedString(@"chapters", nil);
		if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
		    self.clearsSelectionOnViewWillAppear = NO;
		    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
		}
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	_appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	_appDelegate.tableView = self.tableView;
	
	//loading the localized string with an additional comment
	self.navigationItem.title = NSLocalizedString(@"maintitle", @"Name of the app in the tableView");
	
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		// buttons
		UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
		infoButton.backgroundColor = [UIColor clearColor];
		[infoButton addTarget:self action:@selector(infoButtonPressed) forControlEvents:UIControlEventTouchUpInside];
		// setting up the UIButton as an UIBarButtonItem to position it in the Navigation Bar:
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"flags.png"]  style:UIBarButtonItemStyleBordered target:self action:@selector(settingsButtonPressed)];
	} else {
		self.mainDetailViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"flags.png"]  style:UIBarButtonItemStyleBordered target:self action:@selector(settingsButtonPressed)];
		// show initial page
		Page *page = (Page *)[_appDelegate.pages objectAtIndex:[[NSIndexPath indexPathForRow:0 inSection:0] row]];
		mainDetailViewController.navigationItem.title = [page title];
	}
	
	// Do any additional setup after loading the view, typically from a nib.
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
	    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
	}
}

- (void)infoButtonPressed {
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		if(!self.infoViewController) {
			InfoViewController *infoController = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:[NSBundle mainBundle]];
			self.infoViewController = infoController;
		}
		[self presentModalViewController:infoViewController animated:YES];
	} else {
		if(!self.infoViewController) {
			InfoViewController *infoController = [[InfoViewController alloc] initWithNibName:@"InfoViewController_iPad" bundle:[NSBundle mainBundle]];
			self.infoViewController = infoController;
			self.infoViewController.title = NSLocalizedString(@"info", nil);
		}
		[self.settingsNavigationController pushViewController:self.infoViewController animated:YES];
	}
}

-(void)settingsButtonPressed {
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		if(self.settingsViewController == nil) {
			SettingsViewController *Controller = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController_iPhone" bundle:[NSBundle mainBundle]];
			self.settingsViewController = Controller;
		}
		settingsViewController.navItem.title = NSLocalizedString(@"settings", @"settings title");
		settingsViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		[self presentModalViewController:settingsViewController animated:YES];
	} else {
		if(!self.settingsPopover) {			
			SettingsViewController *Controller = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController_iPad" bundle:[NSBundle mainBundle]];
			self.settingsViewController = Controller;
			self.settingsViewController.title = NSLocalizedString(@"settings", nil);
			self.settingsViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"info",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(infoButtonPressed)];
			
			self.settingsNavigationController = [[UINavigationController alloc] initWithRootViewController:self.settingsViewController];
			
			self.settingsPopover = [[UIPopoverController alloc] initWithContentViewController:self.settingsNavigationController];
			Controller.popoverController = self.settingsPopover;
			
		} else {
			[self.settingsPopover dismissPopoverAnimated:YES];
			[self.settingsNavigationController popViewControllerAnimated:YES];
		}
		[self.settingsPopover presentPopoverFromBarButtonItem:self.mainDetailViewController.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.settingsViewController=nil;
	self.settingsPopover = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
	    return YES;
	}
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_appDelegate.pages count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }

	// Configure the cell.
	Page *page = (Page *)[_appDelegate.pages objectAtIndex:indexPath.row];
	// html content	
	// getting the title + increasing chapter number
	NSString *count = [NSString stringWithFormat:@"%d. ", indexPath.row];
	// leave out the count on the first item:
	if(indexPath.row == 0 || indexPath.row > 20) {
		count = @"";
	}

	cell.textLabel.text = [count stringByAppendingString:page.title];
	cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
	
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	Page *page = (Page *)[_appDelegate.pages objectAtIndex:indexPath.row];
//	NSLog(@"%@", page.title);
//	NSLog(@"%@"	, [[_appDelegate.pages objectAtIndex:indexPath.row] title]);
//	NSLog(@"%@", [[self.pages objectAtIndex:indexPath.row] title]);
//	mainDetailViewController.navigationItem.title = [page title];
	
//	NSString *path = [[NSBundle mainBundle] pathForResource:[page path] ofType:@"html" inDirectory:_appDelegate.languageDirectory];
//	NSFileHandle *readHandle = [NSFileHandle fileHandleForReadingAtPath:path];
	
//	NSString *htmlString = [[NSString alloc] initWithData:[readHandle readDataToEndOfFile] encoding:NSUTF8StringEncoding];
	// creating a baseURL makes loading local files like images + css possible. They then refer to their relative path.
//	NSURL *baseURL = [NSURL fileURLWithPath:path];
	
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    if (!self.detailViewController) {
	        self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController_iPhone" bundle:nil];
	    }
		
		self.detailViewController.title = [page title];
        [self.navigationController pushViewController:self.detailViewController animated:YES];
//		[self.detailViewController.webView loadHTMLString:htmlString baseURL:baseURL];
    } else {
		if (!self.mainDetailViewController) {
	        self.mainDetailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController_iPad" bundle:nil];
	    }
		self.appDelegate.currentRow = indexPath.row;
		self.mainDetailViewController.detailItem = [_appDelegate.pages objectAtIndex:indexPath.row];
//		[self.mainDetailViewController.webView loadHTMLString:htmlString baseURL:baseURL];
//		[self.mainDetailViewController.webView loadHTMLString:page.content baseURL:nil];
		
//		[self.navigationController pushViewController:self.detailViewController animated:YES];
//		[self.detailViewController.webView loadHTMLString:htmlString baseURL:baseURL];
		
	}
}

// set a different height for the cells:
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 40.0;
}


@end
