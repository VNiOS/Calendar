//
//  EventCellView.m
//  CalendarProject1
//
//  Created by Applehouse on 10/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EventCellView.h"

@implementation EventCellView
@synthesize timelb,titlelb;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.titlelb=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 180, 30)];
        [self.titlelb setTextAlignment:UITextAlignmentLeft];
        [self.titlelb setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
        [self addSubview:self.titlelb];
        
        
        self.timelb=[[UILabel alloc]initWithFrame:CGRectMake(200, 5, 110, 30)];
        [titlelb setTextAlignment:UITextAlignmentLeft];
        [self addSubview:self.timelb];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
