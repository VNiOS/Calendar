//
//  BNEventEditorController.h
//  Calendar
//
//  Created by Applehouse on 10/25/12.
//  Copyright (c) 2012 WD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNEventEntity.h"
#import "FMDatabase.h"
#import "EventDataSqlite.h"

@class BNEventEditorController;

@protocol EditEventDelegate <NSObject>

-(void)CloseEditView:(BNEventEditorController *)sender;

@end


@interface BNEventEditorController : UIViewController<UIActionSheetDelegate>{
    UITableView *tableView;
    
    BNEventEntity *eventEdited;
    EventDataSqlite *dataSqlite;
    int EditType;
    UITextField *titletf;
    UITextField *location;
    UITextView *description;
    UILabel *startDatelb;
    UILabel *endDatelb;
    
    UILabel *repeat;
    UILabel *repeatTime;
    int repeatInt;
    int repeatTimeInt;
    
    UIView *headView;
    
}
@property(nonatomic,retain) BNEventEntity *eventEdited;


@property(nonatomic,retain)IBOutlet UITableView *tableView;
@property(nonatomic,strong) id<EditEventDelegate> delegate;
@property(nonatomic,retain) UILabel *startDatelb;     
@property(nonatomic,retain) UILabel *endDatelb;


-(IBAction)closeTextField:(id)sender;
-(IBAction)done:(id)sender;
-(IBAction)back:(id)sender;
-(IBAction)deleteEvent:(id)sender;


-(void)checkDataInput;
-(void)saveData:(int)type;
-(void)getEventInput:(BNEventEntity *)event;    
    
-(void)showAlerView:(NSString *)title andSucces :(BOOL)succes;
-(void)showOption:(int)type;

-(void)addContentToHeadView:(UIView *)view;
-(void)addContentToFooterView:(UIView *)view;
@end
