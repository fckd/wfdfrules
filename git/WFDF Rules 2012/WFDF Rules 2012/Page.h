//
//  Page.h
//  Rules
//
//  Created by Claudius Kirsch on 21.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface Page : NSObject {
	sqlite3 *database;
}

@property(nonatomic,assign) NSString *title;
@property(nonatomic,assign) NSString *path;
@property(nonatomic,assign) NSString *content;

@property (assign, nonatomic, readonly) NSInteger primaryKey;

-(id)initWithTitle:(NSString *)t path:(NSString *)p;

- (id)initWithPrimaryKey:(NSInteger)pk database:(sqlite3 *)db language:(NSString *)lang;

@end
