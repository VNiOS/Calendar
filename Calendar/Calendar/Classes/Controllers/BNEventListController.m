//
//  BNEventListController.m
//  Calendar
//
//  Created by Applehouse on 10/25/12.
//  Copyright (c) 2012 WD. All rights reserved.
//



#import "BNEventListController.h"
#import "BNEventEditorController.h"
#import "BNCalendarController.h"
#import "EventDataSqlite.h"
#import "BNEventCell.h"
#define max 100000
#define textSize 14

@implementation BNEventListController
@synthesize tableView = _tableView,delegate,dateStart;

#pragma mark - init

- (id)init{
    self = [super init];
    if(self){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, 336) style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
     }  
    return self;
}

- (void)updateContentDate:(NSDate *)withdate
{
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    [format setDateFormat:@"dd/MM/YYYY"];
    NSString *stringdate=[format stringFromDate:withdate];
    NSLog(@"String with date is = %@",stringdate);
    
    
    dateEvent=[withdate retain];
    EventDataSqlite *eventDataSqlite = [[EventDataSqlite alloc] init];
    eventDay = [[NSArray arrayWithArray:[eventDataSqlite EventListIntoDate:dateEvent]]retain];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:_tableView];
    
    // add Header View
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,44)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    UIView *barView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [self addContentToHeadView:barView];
    [headerView addSubview:barView];
    [self.view addSubview:headerView];
    [headerView release];
    
    
    //add Toolbar 
    
    UIButton *addEventButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addEventButton.frame = CGRectMake(0, 356, 320, 44);
    [addEventButton setBackgroundImage:[UIImage imageNamed:@"Kal.bundle/kal_grid_background.png"] forState:UIControlStateNormal];
    [addEventButton setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Kal.bundle/kal_header_text_fill.png"]] forState:UIControlStateNormal];
    [addEventButton addTarget:self action:@selector(addEvent:) forControlEvents:UIControlEventTouchUpInside];
    [addEventButton setTitle:@"Add new event" forState:UIControlStateNormal];
    [self.view addSubview:addEventButton];
    
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
    UILabel *label=[[UILabel alloc]initWithFrame:footerView.frame];
    label.textColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"Kal.bundle/kal_header_text_fill.png"]];
    [label setFont:[UIFont boldSystemFontOfSize:22]];
    label.textAlignment=UITextAlignmentCenter;
    label.text=@"No event ";
    label.alpha=0.7;
    [footerView addSubview:label];
    _tableView.tableFooterView=footerView;
    [_tableView reloadData];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


# pragma mark - Set Content for table View

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    
    if ([eventDay count]==0) {
        [_tableView.tableFooterView setHidden:NO];
    }
    else{
        [_tableView.tableFooterView setHidden:YES];
    }
    
    return [eventDay count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier = @"BNEventCell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    cell.delegate = self;
    if (cell == nil) {
        cell = [[[BNEventCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier]autorelease];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    BNEventEntity *event = [self eventAtIndexPath:indexPath];
    [cell UpdateContentCell:event];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BNEventEntity *event = [eventDay objectAtIndex:indexPath.row];
    return [self heightofCell:event];
}


// get heigt of Cell
-(CGFloat)heightofCell:(BNEventEntity *)event2
{
    CGSize titleSize = [event2.title sizeWithFont:[UIFont boldSystemFontOfSize:20] constrainedToSize:CGSizeMake(270, max) lineBreakMode:UILineBreakModeCharacterWrap];
    
    CGSize localLabelSize = [event2.local sizeWithFont:[UIFont systemFontOfSize:textSize] constrainedToSize:CGSizeMake(240, max) lineBreakMode:UILineBreakModeCharacterWrap];
    
    CGSize detailLabelSize = [event2.detail sizeWithFont:[UIFont systemFontOfSize:textSize] constrainedToSize:CGSizeMake(240, max) lineBreakMode:UILineBreakModeCharacterWrap];
    
    return (90 + titleSize.height + localLabelSize.height + detailLabelSize.height);
    
}

// jump to view Edit when click edit Button

- (void)bnEventCellDidClickedAtCell:(BNEventCell *)cell1
{
    NSIndexPath *indexPathCell = [self.tableView indexPathForCell:cell1];
    BNEventEntity *selectedEvent = [eventDay objectAtIndex:indexPathCell.row];
    
    BNEventEditorController *editView=[[BNEventEditorController alloc]initWithNibName:@"BNEventEditorController" bundle:nil];
    editView.delegate = self;
    dateStart=[[NSDate alloc]init];
    dateStart=selectedEvent.startDate;
    [editView getDateStart:dateStart];
    [editView getEventInput:selectedEvent];
    
    [self.navigationController pushViewController:editView animated:YES];
}


// get event from indexPath
- (BNEventEntity *)eventAtIndexPath:(NSIndexPath *)indexPath{
    return  [eventDay objectAtIndex:indexPath.row];
    
}



-(void)CloseEditView:(BNEventEditorController *)sender{
    
    [self dismissModalViewControllerAnimated:YES];
    
    
}

//add Event when click addButton

-(IBAction)addEvent:(id)sender{
    BNEventEditorController *editView=[[BNEventEditorController alloc]initWithNibName:@"BNEventEditorController" bundle:nil];
    editView.delegate=self;
    [editView getEventInput:nil];
    [self.navigationController pushViewController:editView animated:YES];
}

#pragma mark - set content for Header
// add headerView

-(void)addContentToHeadView:(UIView *)view{
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Kal.bundle/kal_grid_background.png"]];
    CGRect imageFrame = view.frame;
    imageFrame.origin = CGPointZero;
    backgroundView.frame = imageFrame;
    [view addSubview:backgroundView];
    [backgroundView release];
    
    titlelb = [[UILabel alloc]initWithFrame:CGRectMake(45, 10,120, 20)];
    titlelb.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Kal.bundle/kal_header_text_fill.png"]];
    titlelb.text= [self conVertDateToStringDate:dateEvent];
    titlelb.font=[UIFont boldSystemFontOfSize:22.f];
    [titlelb setBackgroundColor:[UIColor clearColor]];
    titlelb.shadowColor = [UIColor whiteColor];
    titlelb.shadowOffset = CGSizeMake(0.f, 1.f);
    [view addSubview:titlelb];
    
    dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(240,5, 40, 30)];
    dayLabel.text = [self conVertDateToStringDay:dateEvent];
    dayLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Kal.bundle/kal_header_text_fill.png"]];
    [dayLabel setBackgroundColor:[UIColor clearColor]];
    dayLabel.shadowColor = [UIColor whiteColor];
    dayLabel.font=[UIFont boldSystemFontOfSize:22.f];
    [view addSubview:dayLabel];

    
    
    UIButton *BackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 46, 30)];
    [BackButton setImage:[UIImage imageNamed:@"Kal.bundle/kal_left_arrow.png"] forState:UIControlStateNormal];
    BackButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    BackButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [BackButton addTarget:self action:@selector(backToCalendar:)  forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:BackButton];
    
    
    UIButton *PrevButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 5, 46, 30)];
    [PrevButton setImage:[UIImage imageNamed:@"Kal.bundle/kal_left_arrow.png"] forState:UIControlStateNormal];
    PrevButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    PrevButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [PrevButton addTarget:self action:@selector(eventPrevDay:)  forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:PrevButton];
    
    
    UIButton *NextButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 5, 46, 30)];
    [NextButton setImage:[UIImage imageNamed:@"Kal.bundle/kal_right_arrow.png"] forState:UIControlStateNormal];
    NextButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    NextButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [NextButton addTarget:self action:@selector(eventNextDay:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:NextButton];
    
}


-(IBAction)backToCalendar:(id)sender{
    [self.delegate reloadDataList];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)eventNextDay:(id)sender{
    [eventDay release];
    eventDay = nil;
    NSDate *nextDay = [[NSDate dateWithTimeInterval:24*60*60 sinceDate:dateEvent]retain];
    dateEvent = nextDay;
    titlelb.text = [self conVertDateToStringDate:dateEvent];
    dayLabel.text = [self conVertDateToStringDay:dateEvent];
    [self updateContentDate:nextDay];
    [self.tableView reloadData];
    NSLog(@"date event is = %@",dateEvent);
    
}


-(IBAction)eventPrevDay:(id)sender
{
    [eventDay release];
    eventDay = nil;
    NSDate *prevDay = [[NSDate dateWithTimeInterval:-24*60*60 sinceDate:dateEvent]retain];
    dateEvent = prevDay;
    titlelb.text = [self conVertDateToStringDate:dateEvent];
    dayLabel.text = [self conVertDateToStringDay:dateEvent];
    [self updateContentDate:prevDay];
    [self.tableView reloadData];
    
}


// function Convert Date to string format @"yyyy-MM-dd"
-(NSString *)conVertDateToStringDate:(NSDate *)date1
{
    NSDateFormatter *df = [[[NSDateFormatter alloc]init]autorelease];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [df stringFromDate:date1];
    return dateString;
}

// function Convert Date to string format @"dd"
-(NSString *)conVertDateToStringDay:(NSDate *)date2
{
    NSDateFormatter *dfDay = [[[NSDateFormatter alloc]init]autorelease];
    [dfDay setDateFormat:@"dd"];
    NSString *dayString = [dfDay stringFromDate:date2];
    return dayString;
}
-(void)reloadDatainView{
    NSLog(@"reload data in list view");
    [self updateContentDate:dateEvent];
    
}
- (void) dealloc{
    [_tableView release];
    [dateEvent release];
    [eventDay release];
    [super dealloc];
}


@end



