//
//  ViewController.h
//  PocketEnterprise
//
//  Created by Kiran Soumya on 1/9/13.
//  Copyright (c) 2013 Kiran Soumya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *Email;
@property (weak, nonatomic) IBOutlet UITextField *Password;

- (IBAction)LoginButtonPressed:(id)sender;

@end
