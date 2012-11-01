//
//  BNEventCell.m
//  Calendar
//
//  Created by Tuan Nguyen on 10/21/12.
//  Copyright (c) 2012 Lifetimetech. All rights reserved.
//

#import "BNEventCell.h"
#import "BNEventEntity.h"
#define textSize 14
#define max 100000

@implementation BNEventCell
@synthesize titleLabel,timeStartLabel,timeEndLabel,timeRepeat,LocalLabel,DetailLabel,editButton;
@synthesize delegate;
@synthesize heightOfCell;

#pragma mark - init
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel =[[UILabel alloc]init];
//        [self.titleLabel setTextAlignment:UITextAlignmentCenter];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [self addSubview:self.titleLabel];
        
        startLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 60, 60, 20)];
        startLabel.text = @"Start   : ";
        [startLabel setFont:[UIFont boldSystemFontOfSize:textSize]];
        [self addSubview:startLabel];
        self.timeStartLabel =[[UILabel alloc]init];
        [self.timeStartLabel setFont:[UIFont systemFontOfSize:textSize]];
        [self addSubview:self.timeStartLabel];
        
        
        
        endLabel = [[UILabel alloc]init];
        endLabel.text = @"End    : ";
        [endLabel setFont:[UIFont boldSystemFontOfSize:textSize]];
        [self addSubview:endLabel];
        self.timeEndLabel =[[UILabel alloc]init];
        [self.timeEndLabel setFont:[UIFont systemFontOfSize:textSize]];
        [self addSubview:self.timeEndLabel];
        
        
        localLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 70, 60, 20)];
        localLabel.text = @"Local  : ";
        [localLabel setFont:[UIFont boldSystemFontOfSize:textSize]];
        [self addSubview:localLabel];
        self.LocalLabel =[[UILabel alloc]init];
        [self.LocalLabel setFont:[UIFont systemFontOfSize:textSize]];
        [self addSubview:self.LocalLabel];
        
        
        
        detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 90, 60, 20)];
        detailLabel.text = @"Detail : ";
        [detailLabel setFont:[UIFont boldSystemFontOfSize:textSize]];
        [self addSubview:detailLabel];
        self.DetailLabel =[[UILabel alloc]init];
        [self.DetailLabel setFont:[UIFont systemFontOfSize:textSize]];
        [self addSubview:self.DetailLabel];
        
        
        self.editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [editButton setBackgroundColor:[UIColor greenColor]];
        [editButton setBackgroundImage:[UIImage imageNamed:@"Kal.bundle/kal_grid_background.png"] forState:UIControlStateNormal];
        [editButton setTitleColor: [UIColor colorWithPatternImage:[UIImage imageNamed:@"Kal.bundle/kal_header_text_fill.png"]]  forState:UIControlStateNormal];
        [editButton setTitle:@"Edit" forState:UIControlStateNormal];
        [editButton addTarget:self action:@selector(DidClickToEditButton:) forControlEvents:UIControlEventTouchUpInside];
        [editButton.titleLabel setTextAlignment:UITextAlignmentCenter];
        [self addSubview:editButton];
        
    }
    return self;
}

#pragma mark - update Content Cell

- (void)UpdateContentCell:(BNEventEntity *)event
{
    self.titleLabel.text = event.title;
    
    self.timeStartLabel.text =[self convertStringNoSecond:event.timeStart];
    self.timeEndLabel.text = [self convertStringNoSecond:event.timeEnd];
    
    self.LocalLabel.text = event.local;
    self.DetailLabel.text = event.detail;
    
    CGSize titleSize = [event.title sizeWithFont:[UIFont boldSystemFontOfSize:20] constrainedToSize:CGSizeMake(270, max) lineBreakMode:UILineBreakModeCharacterWrap];
    self.titleLabel.frame = CGRectMake(40,10 , 270, titleSize.height);
    self.titleLabel.numberOfLines = 0;
    
    
    startLabel.frame = CGRectMake(15, titleSize.height + 20, 60, 20);
    self.timeStartLabel.frame = CGRectMake(75,titleSize.height + 20, 240, 20);
    
    
    endLabel.frame = CGRectMake(15, titleSize.height + 40, 60, 20);
    self.timeEndLabel.frame = CGRectMake(75,titleSize.height + 40, 240, 20);
    
    
    CGSize localLabelSize = [event.local sizeWithFont:[UIFont systemFontOfSize:textSize] constrainedToSize:CGSizeMake(240, max) lineBreakMode:UILineBreakModeCharacterWrap];
    localLabel.frame = CGRectMake(15, titleSize.height + 60, 60, 20);
    self.LocalLabel.frame = CGRectMake(75,60 + titleSize.height , 240, localLabelSize.height);
    self.LocalLabel.numberOfLines = 0;
    
    CGSize detailLabelSize = [event.detail sizeWithFont:[UIFont systemFontOfSize:textSize] constrainedToSize:CGSizeMake(240, max) lineBreakMode:UILineBreakModeCharacterWrap];
    detailLabel.frame = CGRectMake(15, 60 + titleSize.height + localLabelSize.height, 60, 20);
    self.DetailLabel.frame = CGRectMake(75,60 + titleSize.height + localLabelSize.height, 240, detailLabelSize.height);
    self.DetailLabel.numberOfLines = 0;
    
    
    editButton.frame = CGRectMake(250, 65 + titleSize.height + localLabelSize.height + detailLabelSize.height, 60, 20);
    
}
-(NSString *)convertStringNoSecond:(NSString *)dateString{
    NSDateFormatter *dfOld = [[[NSDateFormatter alloc] init]autorelease];
    [dfOld setDateFormat:@"yyyy-MM-dd   HH:mm:ss"];
     NSDate *date=[dfOld  dateFromString:dateString];
    NSDateFormatter *dfNew = [[[NSDateFormatter alloc] init]autorelease];
    [dfNew setDateFormat:@"yyyy-MM-dd   HH:mm"];
    NSString *results = [dfNew stringFromDate:date];
    return results;
}

- (void)DidClickToEditButton:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(bnEventCellDidClickedAtCell:)]) {
        [self.delegate bnEventCellDidClickedAtCell:self];
    }
}

@end