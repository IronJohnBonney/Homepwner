//
//  BNRImageStore.m
//  Homepwner
//
//  Created by Stephen Looney on 6/20/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "BNRImageStore.h"

@implementation BNRImageStore

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

+ (BNRImageStore *)sharedStore
{
    static BNRImageStore *sharedStore = nil;
    if (!sharedStore) {
        // Create the singleton
        sharedStore = [[super allocWithZone:NULL] init];
    }
    return sharedStore;
}

- (id)init
{
    self = [super init];
    if (self) {
        dictionary = [[NSMutableDictionary alloc] init];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(clearCache:)
                   name:UIApplicationDidReceiveMemoryWarningNotification
                 object:nil];
    }
    
    return self;
}


- (void)setImage:(UIImage *)i forKey:(NSString *)s
{
    [dictionary setObject:i forKey:s];
    
    // Create full path for image
    NSString *imagePath = [self imagePathForKey:s];
    
    // Turn image into a JPEG data
    NSData *d = UIImageJPEGRepresentation(i, 0.5);
    
    // Write it to full path
    [d writeToFile:imagePath atomically:YES];
    
    NSLog(@"Just saved image");
}

- (NSString *)imagePathForKey:(NSString *)key
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                       NSUserDomainMask,
                                                                       YES);
    
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:key];
}


- (UIImage *)imageForKey:(NSString *)s
{
    // return [dictionary objectForKey:s]; Commenting out to add in code to load image from filesystem
    
    // If possible, get it from the dictionary
    UIImage *result = [dictionary objectForKey:s];
    
    if (!result) {
        // Create UIImage object from file
        result = [UIImage imageWithContentsOfFile:[self imagePathForKey:s]];
        
        // If we found an image on the file system, place it into the cache
        if (result)
            [dictionary setObject:result forKey:s];
        else
            NSLog(@"Error: unable to find %@", [self imagePathForKey:s]);
    }
    return result;
}

- (void)deleteImageForKey:(NSString *)s
{
    if (!s)
        return;
    [dictionary removeObjectForKey:s];
    
    NSString *path = [self imagePathForKey:s];
    [[NSFileManager defaultManager] removeItemAtPath:path
                                               error:NULL];
}

// Below clears the cache (upon receiving a low memory warning or otherwise)
- (void)clearCache:(NSNotification *)note
{
    NSLog(@"flushing %lu images out of the cache", (unsigned long)[dictionary count]);
    [dictionary removeAllObjects];
}

@end
