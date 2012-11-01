//
//  BNEventCell.h
//  Calendar
//
//  Created by Tuan Nguyen on 10/21/12.
//  Copyright (c) 2012 Lifetimetech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNEventEntity.h"
@class BNEventCell;
@protocol BNEventCellDelegate <NSObject>

@optional 
- (void) bnEventCellDidClickedAtCell:(BNEventCell *) cell;
@end

@interface BNEventCell : UITableViewCell{
    UILabel *titleLabel,*timeStartLabel,*timeEndLabel,*timeRepeat,*LocalLabel,*DetailLabel;
    UIButton *editButton;
    NSInteger heightOfCell;
    UILabel *startLabel;
    UILabel *endLabel;
    UILabel *localLabel;
    UILabel *detailLabel;
}
@property(nonatomic, strong) id<BNEventCellDelegate> delegate;
@property  NSInteger heightOfCell;
@property(nonatomic, retain)UILabel *titleLabel,*timeStartLabel,*timeEndLabel,*timeRepeat,*LocalLabel,*DetailLabel;
@property(nonatomic, retain) UIButton *editButton;
- (void)DidClickToEditButton:(UIButton *)button;
- (void)UpdateContentCell:(BNEventEntity *)event;
@end
