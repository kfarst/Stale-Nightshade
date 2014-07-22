//
//  MoviesViewController.m
//  Stale Nightshade
//
//  Created by Kevin Farst on 6/4/14.
//  Copyright (c) 2014 Kevin Farst. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "Movie.h"
#import "SVProgressHUD.h"

static NSString * const ApiKey = @"tax9gwc3xnks8xpkdhamyfke";

@interface MoviesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *movies;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation MoviesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Movies";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    [self showLoading];
    [self fetchMovies];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refresh:)
             forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *movieCell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    Movie *movie = self.movies[indexPath.row];
    NSURL *thumbnailPosterUrl = [NSURL URLWithString:movie.thumbnailPosterUrl];
    
    movieCell.titleLabel.text = movie.title;
    movieCell.synopsisLabel.text = movie.synopsis;
    if (thumbnailPosterUrl) {
        [movieCell.posterView setImageWithURL:thumbnailPosterUrl];
    }
    return movieCell;
}

-(void)fetchMovies {
    NSUInteger selectedIndex = self.movieTypeMenu.selectedIndex;
    NSString *movieTypeUrlString;
    
    switch (selectedIndex) {
        case 0:
            movieTypeUrlString = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=%@", ApiKey];
            break;
        case 1:
            movieTypeUrlString = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=%@", ApiKey];
            break;
    }

    NSURL *url = [NSURL URLWithString:movieTypeUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.movies = [Movie moviesWithArray:responseObject[@"movies"]];
        [self dismissLoading];
        [self.tableView reloadData];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self dismissLoading];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                      message:[error localizedDescription]
                                                      delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
        [alertView show];
    }];

    [operation start];
}

-(void) showLoading {
    [SVProgressHUD show];
}

-(void) dismissLoading {
    [SVProgressHUD dismiss];
}

-(void) refresh:(id)sender {
    [self fetchMovies];
    [self.refreshControl endRefreshing];
}

@end
