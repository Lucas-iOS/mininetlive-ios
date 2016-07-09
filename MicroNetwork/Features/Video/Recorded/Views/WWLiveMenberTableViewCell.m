//
//  WWLiveMenberTableViewCell.m
//  MicroNetwork
//
//  Created by Lucas on 16/7/4.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWLiveMenberTableViewCell.h"
#import "WWUserInfoModel.h"

@implementation WWLiveMenberTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMenber:(NSArray *)menberList {
    
    NSArray *image = @[@"head_001", @"head_002", @"head_003", @"head_004", @"head_005", @"head_001", @"head_002", @"head_003", @"head_004", @"head_005"];
    for (int i = 0; i < 10; i++) {
        WWUserInfoModel *menber = menberList[i];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 35 +35, 42, 30, 30)];
        [imageView setImage:[UIImage imageNamed:image[i]]];
    
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(i * 35 +35, 80, 30, 30)];
        name.text = menber.nickname;
        
        [self addSubview:imageView];
        [self addSubview:name];
    }
}

@end
