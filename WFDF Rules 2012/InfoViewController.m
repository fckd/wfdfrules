//
//  InfoViewController.m
//  Rules
//
//  Created by Claudius Kirsch on 02.09.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "InfoViewController.h"


@implementation InfoViewController

@synthesize buttonBack, buttonMail, buttonDfv, buttonWfdf;

-(IBAction)back:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction)mailto:(id)sender {
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil) {
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail]) {
			[self displayComposerSheet];
		}
		else {
			[self launchMailAppOnDevice];
		}
	}
	else {
		[self displayComposerSheet];
	}
}

// Displays an email composition interface inside the application. Populates the subject.
-(void)displayComposerSheet {
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"Feedback"];
	
	// Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:@"ultimate@claudiuskirsch.com"]; 
	[picker setToRecipients:toRecipients];
	
	[self presentModalViewController:picker animated:YES];
}

// Dismisses the email composition interface when users tap Cancel or Send.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self dismissModalViewControllerAnimated:YES];
}

-(void)launchMailAppOnDevice {
	NSString *recipients = @"mailto:ultimate@claudiuskirsch.com?cc=&subject=Feedback";
	
	NSString *email = [NSString stringWithFormat:@"%@", recipients];
	
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}


//-(IBAction)mailto:(id)sender {
//	NSString *recipients = @"mailto:ultimate@claudiuskirsch.com?cc=&subject=Feedback";
//	
//	NSString *email = [NSString stringWithFormat:@"%@", recipients];
//	
//	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//	
//	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
//}

-(IBAction)actionDfv:(id)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.frisbeesportverband.de"]];
}
-(IBAction)actionWfdf:(id)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.wfdf.org"]];
}


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.contentSizeForViewInPopover = CGSizeMake(320, 400);
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}
 */


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    //[super dealloc];
}


@end
