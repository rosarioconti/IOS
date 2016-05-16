//
//  MovieExtra.m
//  OMDbApiTest
//
//  Created by ros2 on 16/05/16.
//
//

#import "MovieExtra.h"

@implementation MovieExtra

-(id)init{
    self = [super init];
    
    if(self)
    {
        self.Title = @"";
        self.Year = @"";
        self.Director = @"";
        self.Poster = @"";
    }
    return self;
}

@end
