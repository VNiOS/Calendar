//
//  EventCellView.h
//  CalendarProject1
//
//  Created by Applehouse on 10/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCellView : UITableViewCell{
    UILabel *titlelb;
    UILabel *timelb;
    
}
@property(nonatomic,retain) UILabel *titlelb;
@property(nonatomic,retain) UILabel *timelb;
@end
