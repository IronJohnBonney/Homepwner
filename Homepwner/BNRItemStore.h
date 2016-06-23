//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Stephen Looney on 12/14/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BNRItem;

@interface BNRItemStore : NSObject

{
    NSMutableArray *allItems;
    NSMutableArray *allAssetTypes;
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

// Notice that this is a class method and prefixed with a + instead of a -

+ (BNRItemStore *)sharedStore;

- (NSArray *)allItems;
- (BNRItem *)createItem;
- (void)removeItem:(BNRItem *)p;
- (void)moveItemAtIndex:(int)from
                toIndex:(int)to;


- (NSString *)itemArchivePath;
- (BOOL)saveChanges;

- (void)loadAllItems;

- (NSArray *)allAssetTypes;

@end
