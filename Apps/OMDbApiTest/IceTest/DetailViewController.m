//
//  DetailViewController.m
//  OMDbApiTest
//
//  Created by ros2 on 16/05/16.
//
//

#import "DetailViewController.h"
#import "DataManager.h"
#import "MovieExtra.h"

@interface DetailViewController ()

@property (nonatomic,strong) IBOutlet UILabel *Title;
@property (nonatomic,strong) IBOutlet UIImageView *Poster;
@property (nonatomic,strong) IBOutlet UILabel *Plot;
@property (nonatomic,strong) IBOutlet UILabel *raw;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _Title.text = _item.Title;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *poster = _item.Poster;
        if (![poster isEqualToString:@"N/A"]) {
            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:poster]];
            if ( data != nil ) {
                _Poster.image = [UIImage imageWithData: data];
            }
        }
        
    });
    _Plot.text = _item.Plot;
    _raw.text = _item.raw;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

@end
