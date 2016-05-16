//
//  FeedViewCell.m
//  OMDbApiTest
//
//  Created by ros2 on 16/05/16.
//
//

#import "FeedViewCell.h"

@implementation FeedViewCell

- (void) setView{
    _title.text = @"";
    _year.text = @"";
    _director.text = @"";
    _icon.image = [UIImage imageNamed:@"icecube"];
    _icon.layer.borderColor =[[UIColor redColor] CGColor];
    _icon.layer.borderWidth = 2.0;
    _icon.layer.cornerRadius = _icon.frame.size.width / 2;
    _icon.layer.masksToBounds = YES;
    _icon.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)awakeFromNib {
    [self setView];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self setView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
@end
