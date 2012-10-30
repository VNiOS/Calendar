//
//  BNEventListController.m
//  Calendar
//
//  Created by Applehouse on 10/25/12.
//  Copyright (c) 2012 WD. All rights reserved.
//

#import "BNEventListController.h"
#import "BNEventEditorController.h"
@implementation BNEventListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *addEventButton=[[UIBarButtonItem alloc]initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addEvent:)];
    [self.navigationItem setRightBarButtonItem:addEventButton];
    // Do any additional setup after loading the view from its nib.
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
-(void)CloseEditView:(BNEventEditorController *)sender{
    [self dismissModalViewControllerAnimated:YES];
}
-(IBAction)addEvent:(id)sender{
    BNEventEditorController *editView=[[BNEventEditorController alloc]initWithNibName:@"BNEventEditorController" bundle:nil];
    editView.delegate=self;
    UINavigationController *navirControl=[[UINavigationController alloc]initWithRootViewController:editView];
    [navirControl.navigationBar setHidden:YES];
    navirControl.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:navirControl animated:YES];
}
@end
