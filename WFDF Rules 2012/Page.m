//
//  Page.m
//  Rules
//
//  Created by Claudius Kirsch on 21.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Page.h"


@implementation Page

@synthesize title = _title;
@synthesize path = _path;
@synthesize content = _content;

-(id)initWithTitle:(NSString *)t path:(NSString *)p {
	self.title = t;
	self.path = p;
	self.content = nil;
	return self;
}

@end
