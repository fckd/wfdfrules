//
//  Page.h
//  Rules
//
//  Created by Claudius Kirsch on 21.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Page : NSObject {

}

@property(nonatomic,assign) NSString *title;
@property(nonatomic,assign) NSString *path;
@property(nonatomic,assign) NSString *content;

-(id)initWithTitle:(NSString *)t path:(NSString *)p;

@end
