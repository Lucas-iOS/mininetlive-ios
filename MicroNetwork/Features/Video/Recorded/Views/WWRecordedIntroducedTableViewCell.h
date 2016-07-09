//
//  WWRecordedIntroducedTableViewCell.h
//  MicroNetwork
//
//  Created by Lucas on 16/6/6.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WWRecordedIntroducedTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelIntroduced;

- (void)autoLayoutHeight:(NSString *)str;

@end
