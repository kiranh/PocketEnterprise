//
//  PocketEnterpriseViewController.h
//  PocketEnterprise
//
//  Created by Kiran Soumya on 1/9/13.
//  Copyright (c) 2013 Kiran Soumya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PocketEnterpriseViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *UIEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *UIPasswordTextField;

- (IBAction)loginButtonPressed:(id)sender;
@end
