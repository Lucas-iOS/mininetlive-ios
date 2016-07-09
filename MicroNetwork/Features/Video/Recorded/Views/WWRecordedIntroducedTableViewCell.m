//
//  WWRecordedIntroducedTableViewCell.m
//  MicroNetwork
//
//  Created by Lucas on 16/6/6.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWRecordedIntroducedTableViewCell.h"

@implementation WWRecordedIntroducedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)autoLayoutHeight:(NSString *)str {

    self.labelIntroduced.text = str;
}

@end
