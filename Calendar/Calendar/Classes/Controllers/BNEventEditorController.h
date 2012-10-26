//
//  BNEventEditorController.h
//  Calendar
//
//  Created by Applehouse on 10/25/12.
//  Copyright (c) 2012 WD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNEventEntity.h"
@class BNEventEditorController;

@protocol EditEventDelegate <NSObject>

-(void)CloseEditView:(BNEventEditorController *)sender;

@end


@interface BNEventEditorController : UITableViewController{
    BNEventEntity *eventEdited;
    UITextField *title;
    UITextField *location;
    UITextView *description;
    UILabel *startDatelb;
    UILabel *endDatelb;
    UILabel *repeat;
    UILabel *repeatTime;
    
}
@property(nonatomic,strong) id<EditEventDelegate> delegate;
-(IBAction)done:(id)sender;
-(IBAction)closeTextField:(id)sender;
    

@end
