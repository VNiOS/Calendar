//
//  BNAppDelegate.h
//  Calendar
//
//  Created by Tuan Nguyen on 10/21/12.
//  Copyright (c) 2012 Lifetimetech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNCalendarController.h"


@interface BNAppDelegate : UIResponder <UIApplicationDelegate,UITableViewDelegate, UINavigationControllerDelegate>{
    UINavigationController *navController;
    //id dataSource;
    BNCalendarController *calendarController;
    
    NSString * databasePath;
    
}
@property (nonatomic,retain) UINavigationController *navController;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) NSString *databasePath;
- (void)Checkdatabase ;
@end
