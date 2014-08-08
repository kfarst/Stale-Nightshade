//
//  MovieDetailViewController.m
//  Stale Nightshade
//
//  Created by Kevin Farst on 6/25/14.
//  Copyright (c) 2014 Kevin Farst. All rights reserved.
//

#import "MovieDetailViewController.h"

@interface MovieDetailViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *synposisView;

@end



@implementation MovieDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSURL *detailedPosterUrl = [NSURL URLWithString:self.movie.detailedPosterUrl];
    
    if (detailedPosterUrl) {
        NSData *posterData = [NSData dataWithContentsOfURL:detailedPosterUrl];
        UIGraphicsBeginImageContext(self.view.frame.size);
        [[UIImage imageWithData:posterData] drawInRect:self.view.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    }
    
    UITextView *synopsis = [[UITextView alloc] init];
    [synopsis setText:[NSString stringWithString:self.movie.synopsis]];
    self.synposisView = [[UIScrollView alloc] init];
    [self.synposisView addSubview:synopsis];
    [self.synposisView bringSubviewToFront:synopsis];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
