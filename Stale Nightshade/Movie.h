//
//  Movie.h
//  Stale Nightshade
//
//  Created by Kevin Farst on 6/5/14.
//  Copyright (c) 2014 Kevin Farst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *thumbnailPosterUrl;
@property (nonatomic, strong) NSString *originalPosterUrl;
@property (nonatomic, strong) NSString *rating;
@property (nonatomic, strong) NSString *synopsis;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)moviesWithArray:(NSArray *)array;

@end
