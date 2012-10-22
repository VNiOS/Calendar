//
//  AppDelegate.h
//  CalendarProject1
//
//  Created by Applehouse on 10/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KalViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate,UITableViewDelegate>{
    
    UINavigationController *navControl;
    id dataSource;
    KalViewController *calendarView;
    
    
}

@property (strong, nonatomic) UIWindow *window;

@end
