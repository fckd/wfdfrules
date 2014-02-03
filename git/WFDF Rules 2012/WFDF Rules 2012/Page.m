//
//  Page.m
//  Rules
//
//  Created by Claudius Kirsch on 21.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Page.h"

static sqlite3_stmt *init_statement = nil;

@implementation Page

@synthesize title = _title;
@synthesize path = _path;
@synthesize content = _content, primaryKey;

-(id)initWithTitle:(NSString *)t path:(NSString *)p {
	self.title = t;
	self.path = p;
	self.content = nil;
	return self;
}

- (id)initWithPrimaryKey:(NSInteger)pk database:(sqlite3 *)db language:(NSString *)lang {
	if (self = [super init]) {
        primaryKey = pk;
        database = db;
        // Compile the query for retrieving book data. See insertNewBookIntoDatabase: for more detail.
        if (init_statement == nil) {
            // Note the '?' at the end of the query. This is a parameter which can be replaced by a bound variable.
            // This is a great way to optimize because frequently used queries can be compiled once, then with each
            // use new variable values can be bound to placeholders.
			NSString *queryString = [NSString stringWithFormat:@"SELECT title,content FROM %@ WHERE key=?", lang];
//            const char *sql = "SELECT title,content FROM ? WHERE key=?";
            if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &init_statement, NULL) != SQLITE_OK) {
                NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
            }
        }
        // For this query, we bind the primary key to the first (and only) placeholder in the statement.
        // Note that the parameters are numbered from 1, not from 0.
		sqlite3_bind_int(init_statement, 1, primaryKey);
        if (sqlite3_step(init_statement) == SQLITE_ROW) {
			self.title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 0)];
            self.content = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 1)];
//			NSLog(@"%@", self.content);
        } else {
            self.title = @"Nothing";
        }
        // Reset the statement for future reuse.
        sqlite3_reset(init_statement);
    }
//	self.path = nil;
    return self;
}

@end
