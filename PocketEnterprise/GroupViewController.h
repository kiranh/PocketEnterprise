//
//  GroupViewController.h
//  PocketEnterprise
//
//  Created by Kiran Soumya on 1/18/13.
//  Copyright (c) 2013 Kiran Soumya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupViewController : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSMutableArray *groupListData;

- (void)readDataForTable;

@end
