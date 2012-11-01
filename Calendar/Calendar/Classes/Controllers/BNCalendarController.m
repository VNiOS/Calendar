//
//  BNCalendarController.m
//  Calendar
//
//  Created by Tuan Nguyen on 10/21/12.
//  Copyright (c) 2012 Lifetimetech. All rights reserved.
//


#import "KalViewController.h"
#import "KalLogic.h"
#import "KalDataSource.h"
#import "KalDate.h"
#import "KalPrivate.h"

#import "EventDataSqlite.h"
#import "BNEventListController.h"
#import "BNCalendarController.h"
#import "BNEventEditorController.h"


//NSString *const KalDataSourceChangedNotification = @"KalDataSourceChangedNotification";
@interface BNCalendarController ()
@property (nonatomic, retain, readwrite) NSDate *initialDate;
@property (nonatomic, retain, readwrite) NSDate *selectedDate;
- (KalView*)calendarView;
@end

@implementation BNCalendarController

@synthesize dataSource, delegate, initialDate, selectedDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        dataSource=[[EventDataSqlite alloc]init];
        
        // Custom initialization
    }
    return self;
}


- (id)init
{
    return [self initWithSelectedDate:[NSDate date]];
}
- (id)initWithSelectedDate:(NSDate *)date
{
    if ((self = [super init])) {
        logic = [[KalLogic alloc] initForDate:date];
        self.initialDate = date;
        self.selectedDate = date;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(significantTimeChangeOccurred) name:UIApplicationSignificantTimeChangeNotification object:nil];
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:KalDataSourceChangedNotification object:nil];
    }
    return self;
}

- (KalView*)calendarView 
{ return (KalView*)self.view; 
}

- (void)setDataSource:(id<KalDataSource>)aDataSource
{
    if (dataSource != aDataSource) {
        dataSource = aDataSource;
        tableView.dataSource = dataSource;
    }
}

- (void)setDelegate:(id<UITableViewDelegate>)aDelegate
{
    if (delegate != aDelegate) {
        delegate = aDelegate;
        tableView.delegate = self;
    }
}

- (void)clearTable
{
    [dataSource removeAllItems];
    [tableView reloadData];
}

- (void)reloadData
{
    NSLog(@"reload data") ; 
    [dataSource presentingDatesFrom:logic.fromDate to:logic.toDate delegate:self];
}

- (void)significantTimeChangeOccurred
{
    [[self calendarView] jumpToSelectedMonth];
    [self reloadData];
}
#pragma mark KalViewDelegate protocol

- (void)didSelectDate:(KalDate *)date
{
    self.selectedDate = [date NSDate];
    //lay diem dau cuoi cua ngay de load data  
    NSDate *from = [[date NSDate] cc_dateByMovingToBeginningOfDay];
    NSDate *to = [[date NSDate] cc_dateByMovingToEndOfDay];
    [self clearTable];
    [dataSource loadItemsFromDate:from toDate:to];//load dulieu event cua selected day
    [tableView reloadData];//load lai du lieu event tren tableview
    [tableView flashScrollIndicators];
}

- (void)showPreviousMonth
{
    [self clearTable];
    [logic retreatToPreviousMonth];
    [[self calendarView] slideDown];
    [self reloadData];
}

- (void)showFollowingMonth
{
    [self clearTable];
    [logic advanceToFollowingMonth];
    [[self calendarView] slideUp];
    [self reloadData];
}


#pragma mark KalDataSourceCallbacks protocol

- (void)loadedDataSource:(id<KalDataSource>)theDataSource;
{
    NSArray *markedDates = [theDataSource markedDatesFrom:logic.fromDate to:logic.toDate];
    NSMutableArray *dates = [[markedDates mutableCopy] autorelease];
    for (int i=0; i<[dates count]; i++)
        [dates replaceObjectAtIndex:i withObject:[KalDate dateFromNSDate:[dates objectAtIndex:i]]];
    
    [[self calendarView] markTilesForDates:dates];
    [self didSelectDate:self.calendarView.selectedDate];
}
- (void)showAndSelectDate:(NSDate *)date
{
    if ([[self calendarView] isSliding])
        return;
    
    [logic moveToMonthForDate:date];
    [[self calendarView] jumpToSelectedMonth];
    
    [[self calendarView] selectDate:[KalDate dateFromNSDate:date]];
    [self reloadData];
}

- (NSDate *)selectedDate
{
    return [self.calendarView.selectedDate NSDate];
}
#pragma mark - tableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"tableView click");
    BNEventListController *eventDay = [[BNEventListController alloc]init];
    eventDay.delegate=self;
    [eventDay updateContentDate:selectedDate];
    [self.navigationController pushViewController:eventDay animated:YES];
}
#pragma mark - BNEventEditor delegate and action
-(IBAction)addNewEvent:(id)sender{
    
//    NSDictionary *data2=[[NSDictionary alloc]initWithObjectsAndKeys:
//                         @"5",@"event_id",
//                         @"test update event 3",         @"title",
//                         @"2012-10-31 11:00:00",         @"timeStart",
//                         @"2012-10-31 11:30:00",         @"timeEnd",
//                         @"No repeat",        @"repeat",
//                         @"10 min",        @"timeRepeat",
//                         @"Ngoc khanh",         @"local",
//                         @"Day la event test",         @"detail",
//                         
//                         nil];
//    BNEventEntity *testUpdate=[[BNEventEntity alloc ]initWithDictionary:data2];    
    
    
    
    BNEventEditorController *editView=[[BNEventEditorController alloc]initWithNibName:@"BNEventEditorController" bundle:nil];
    editView.delegate=self;
    [editView getEventInput:nil];
    [self.navigationController pushViewController:editView animated:YES];
}
-(void)reloadDatainView{
    [self reloadData];
}
-(void)CloseEditView:(BNEventEditorController *)sender{
    
}
#pragma mark - EventlistDelegate
-(void)reloadDataList{
    
    NSLog(@"reload data in calendar_________");
    [self reloadData];
}
#pragma mark - life circle

- (void)loadView
{
    if (!self.title)
        self.title = @"Calendar";
    KalView *kalView = [[[KalView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] delegate:self logic:logic] autorelease];
    self.view = kalView;
    tableView = kalView.tableView;
    tableView.dataSource = dataSource;
    tableView.delegate = self;
    [tableView retain];
    [kalView selectDate:[KalDate dateFromNSDate:self.initialDate]];
    [self reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //button for add new event
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    [headView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Kal.bundle/kal_grid_background.png"]]];
    [headView setAlpha:0.8];
    UIButton *AddEvent=[[UIButton alloc]initWithFrame:CGRectMake(20, 0, 280, 40)];
    [AddEvent setTitle:@"Add new event" forState:UIControlStateNormal];
    [AddEvent setTitleColor: [UIColor colorWithPatternImage:[UIImage imageNamed:@"Kal.bundle/kal_header_text_fill.png"]] forState:UIControlStateNormal];
    [AddEvent addTarget:self action:@selector(addNewEvent:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:AddEvent];
    tableView.tableHeaderView=headView;
    
    
    
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    UILabel *label=[[UILabel alloc]initWithFrame:footerView.frame];
    label.textColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"Kal.bundle/kal_header_text_fill.png"]];
    [label setFont:[UIFont boldSystemFontOfSize:18]];
    label.textAlignment=UITextAlignmentCenter;
    label.text=@"No event ";
    label.alpha=0.7;
    [footerView addSubview:label];
    tableView.tableFooterView=footerView;
    
    [tableView reloadData];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [super viewDidUnload];
    [tableView release];
    tableView = nil;
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [tableView flashScrollIndicators];
}
- (void)didReceiveMemoryWarning
{
    self.initialDate = self.selectedDate; // must be done before calling super
    [super didReceiveMemoryWarning];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)dealloc{
    [super dealloc];
    [logic release];
    [tableView release];
    [initialDate release];
    [selectedDate release];
}
@end
