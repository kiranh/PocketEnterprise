//
//  PocketEnterpriseViewController.m
//  PocketEnterprise
//
//  Created by Kiran Soumya on 1/9/13.
//  Copyright (c) 2013 Kiran Soumya. All rights reserved.
//

#import "PocketEnterpriseViewController.h"

@interface PocketEnterpriseViewController ()

@end

@implementation PocketEnterpriseViewController
@synthesize UIEmailTextField;
@synthesize UIPasswordTextField;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender {
    //Authentication token for every request devise
    /*NSString *path = [NSString stringWithFormat:@"/%@/%i", [self pluralizedName], identifier];
    path = [path stringByAppendingQueryParameters:[self appendAuthenticationToken:params]];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:path delegate:delegate];*/
    
    NSLog(@"Log In button was pressed!");
    NSLog(@"%@",UIEmailTextField.text);
        
    NSDictionary *params = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                                UIEmailTextField.text,
                                                                UIPasswordTextField.text,
                                                                UIPasswordTextField.text,
                                                                nil]
                                                       forKeys:[NSArray arrayWithObjects:
                                                                @"email",
                                                                @"password",
                                                                @"password_confirmation",
                                                                nil]];
    
    NSURL* url = [[NSURL alloc]initWithString:@"http://localhost:3000"];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:url];
    
    [objectManager.HTTPClient setAuthorizationHeaderWithUsername:UIEmailTextField.text password:UIPasswordTextField.text];
    
    [objectManager getObjectsAtPath:@"/welcome/index.json" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
     {
         NSLog(@"It Worked: %@", [mappingResult array]);
         // Or if you're only expecting a single object:
         NSLog(@"It Worked: %@", [mappingResult firstObject]);
     } failure:^(RKObjectRequestOperation *operation, NSError *error) {
         NSLog(@"It Failed: %@", error);
     }];
}
@end
