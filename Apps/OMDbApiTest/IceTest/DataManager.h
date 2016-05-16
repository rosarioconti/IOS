//
//  DataManager.h
//  OMDbApiTest
//
//  Created by ros2 on 16/05/16.
//
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

+ (DataManager *)sharedManager;

- (NSArray*) getFeed;
- (void) searchFeed:(NSString*) searchStr;
- (void) searchByID:(NSString*) searchId callback:(void (^)(NSArray* extra))callback;
- (int) getQuantity;

@end
