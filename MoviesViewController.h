//
//  MoviesViewController.h
//  Stale Nightshade
//
//  Created by Kevin Farst on 6/4/14.
//  Copyright (c) 2014 Kevin Farst. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    movieView,
    dvdView
} ViewMode;

@interface MoviesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    ViewMode mode;
}

-(id) initWithMode:(ViewMode)aMode;

@end
