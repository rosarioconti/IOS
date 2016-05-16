//
//  MovieExtra.h
//  OMDbApiTest
//
//  Created by ros2 on 16/05/16.
//
//

#import <Foundation/Foundation.h>

@interface MovieExtra : NSObject

@property (nonatomic, strong) NSString *Title;
@property (nonatomic, strong) NSString *Year;
@property (nonatomic, strong) NSString *Director;
@property (nonatomic, strong) NSString *Poster;
@property (nonatomic, strong) NSString *Plot;
@property (nonatomic, strong) NSString *raw;

@end
