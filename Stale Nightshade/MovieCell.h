//
//  MovieCell.h
//  Stale Nightshade
//
//  Created by Kevin Farst on 6/5/14.
//  Copyright (c) 2014 Kevin Farst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@end
