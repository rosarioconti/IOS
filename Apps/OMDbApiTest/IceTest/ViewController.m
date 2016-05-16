//
//  ViewController.m
//  OMDbApiTest
//
//  Created by ros2 on 16/05/16.
//
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "FeedViewCell.h"
#import "DataManager.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) IBOutlet UITextField *search;
@property (strong, nonatomic) IBOutlet UITableView * tableView;
@property (nonatomic) NSArray *feed;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(reloadData) name:@"reload_data" object:nil];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsZero;
    [self searchFeed];
}

-(IBAction)searchBtn:(id)sender
{
    [_search resignFirstResponder];
    [self searchFeed];
}

-(void) searchFeed
{
    [[DataManager sharedManager] searchFeed:_search.text];
}

-(void) reloadData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"reloading data...");
        self.feed = [DataManager sharedManager].getFeed;
        [self.tableView reloadData];
    });

}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DETAIL_VIEW"])
    {
        DetailViewController *detailViewController = segue.destinationViewController;
        NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
        detailViewController.item = _feed[selectedPath.row];
    }
}


#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"DETAIL_VIEW" sender:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedViewCell" forIndexPath:indexPath];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *poster = [_feed[indexPath.row] valueForKey:@"Poster"];
        
        if (![poster isEqualToString:@"N/A"]) {
            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:poster]];
            if ( data != nil ) {
                cell.icon.image = [UIImage imageWithData: data];
            }
        } else {
            //NSLog(@"setting icecube");
            cell.icon.image = [UIImage imageNamed:@"icecube"];
        }
        
    });
    cell.title.text = [_feed[indexPath.row] valueForKey:@"Title"];
    cell.year.text =[_feed[indexPath.row] valueForKey:@"Year"];
    cell.director.text =[_feed[indexPath.row] valueForKey:@"Director"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [DataManager sharedManager].getFeed.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


@end
