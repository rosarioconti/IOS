//
//  FeedViewCell.h
//  OMDbApiTest
//
//  Created by ros2 on 16/05/16.
//
//

#import <UIKit/UIKit.h>

@interface FeedViewCell : UITableViewCell

@property (nonatomic) IBOutlet UILabel *title;
@property (nonatomic) IBOutlet UIImageView *icon;
@property (nonatomic) IBOutlet UILabel *year;
@property (nonatomic) IBOutlet UILabel *director;

@end
