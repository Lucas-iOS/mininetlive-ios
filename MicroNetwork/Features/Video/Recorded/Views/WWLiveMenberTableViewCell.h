//
//  WWLiveMenberTableViewCell.h
//  MicroNetwork
//
//  Created by Lucas on 16/7/4.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WWLiveMenberTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *menberCount;

- (void)setMenber:(NSArray *)menberList;

@end
