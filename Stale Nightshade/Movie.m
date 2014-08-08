//
//  Movie.m
//  Stale Nightshade
//
//  Created by Kevin Farst on 6/5/14.
//  Copyright (c) 2014 Kevin Farst. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.title = dictionary[@"title"];
        self.thumbnailPosterUrl = dictionary[@"posters"][@"thumbnail"];
        self.originalPosterUrl = dictionary[@"posters"][@"original"];
        self.profilePosterUrl = dictionary[@"posters"][@"profile"];
        self.detailedPosterUrl = dictionary[@"posters"][@"detailed"];
        self.rating = dictionary[@"mpaa_rating"];
        self.synopsis = dictionary[@"synopsis"];
    }
    
    return self;
}

+ (NSArray *)moviesWithArray:(NSArray *)array {
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in array) {
        Movie *movie = [[Movie alloc] initWithDictionary:dictionary];
        [movies addObject:movie];
    }
    
    return movies;
}

@end
