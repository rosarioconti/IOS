//
//  DataManager.m
//  OMDbApiTest
//
//  Created by ros2 on 16/05/16.
//
//

#import "DataManager.h"
#import "MovieExtra.h"

@interface DataManager ()

@property (nonatomic, strong) NSArray *feed;
@property (nonatomic) int quantity;

@end

@implementation DataManager

+ (DataManager *)sharedManager
{
    static dispatch_once_t p = 0;
    __strong static DataManager *sharedInstance = nil;
    dispatch_once(&p, ^{
        sharedInstance = [[DataManager alloc] init];
    });
    return sharedInstance;
}


- (void) searchFeed:(NSString*) searchStr
{
    NSURL *URL = [NSURL URLWithString: [NSString stringWithFormat:@"http://www.omdbapi.com/?s=%@&y=&plot=short&r=json&type=movie&Page=1",searchStr]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      NSError *jsonError;
                                      NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                                      
                                      if(jsonError) {
                                          NSLog(@"json error : %@", [jsonError localizedDescription]);
                                      } else {
                                          if ([[jsonObject valueForKey:@"Response"] isEqualToString:@"True"]) {
                                            
                                              //@TODO : Later to handle pages
                                              //_quantity = [[searchResult valueForKey:@"totalResults"] integerValue];
                                              //NSLog(@"_quantity: %d", _quantity);
                                              
                                              NSArray *searchResultArray = [jsonObject valueForKey:@"Search"];

                                              NSMutableArray *searchResultExtraArray = [[NSMutableArray alloc] init];
                                              for (int i = 0; i < searchResultArray.count; i++)
                                              {
                                                  MovieExtra *Me = [[MovieExtra alloc] init];
                                                  Me.Title = [searchResultArray[i] valueForKey:@"Title"];
                                                  Me.Year = [searchResultArray[i] valueForKey:@"Year"];
                                                  Me.Poster = [searchResultArray[i] valueForKey:@"Poster"];
                                                  
                                                  [self searchByID:[searchResultArray[i] valueForKey:@"imdbID"] callback:^(NSArray* extra) {
                                                      if (extra) {
                                                          Me.Director = [extra valueForKey:@"Director"];
                                                          Me.Plot = [extra valueForKey:@"Plot"];
                                                          Me.raw = [NSString stringWithFormat:@"%@",extra];
                                                      }
                                                  }];
                                                      
                                                  [searchResultExtraArray addObject:Me];
                                              }
                                            
                                              _feed = searchResultExtraArray;
                                                   
                                              [[NSNotificationCenter defaultCenter] postNotificationName:@"reload_data" object:nil];
                                          }
                                      }
                                  }];
    
    [task resume];
}

- (void) searchByID:(NSString*) searchId callback:(void (^)(NSArray* extra))callback
{

    NSURL *URL = [NSURL URLWithString: [NSString stringWithFormat:@"http://www.omdbapi.com/?i=%@&y=&plot=full&r=json&Movie=1", searchId]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      NSError *jsonError;
                                      if (data != nil) {
                                          NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                                          
                                          if(jsonError) {
                                              NSLog(@"json error : %@", [jsonError localizedDescription]);
                                              if (callback) {
                                                  callback(nil);
                                              }
                                          } else {
                                              if ([[jsonObject valueForKey:@"Response"] isEqualToString:@"True"]) {
                                                  if (callback) {
                                                      callback(jsonObject);
                                                  }
                                              }
                                          }
                                      } else {
                                          if (callback) {
                                              callback(nil);
                                          }
                                      }
                                  }];
    
    [task resume];
}

- (NSArray*) getFeed
{
    return self.feed;
}

- (int) getQuantity
{
    return _quantity;
}
@end
