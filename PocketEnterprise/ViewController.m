//
//  ViewController.m
//  PocketEnterprise
//
//  Created by Kiran Soumya on 1/9/13.
//  Copyright (c) 2013 Kiran Soumya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize Email;
@synthesize Password;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LoginButtonPressed:(id)sender {
    //Authentication token for every request devise
    /*NSString *path = [NSString stringWithFormat:@"/%@/%i", [self pluralizedName], identifier];
     path = [path stringByAppendingQueryParameters:[self appendAuthenticationToken:params]];
     [[RKObjectManager sharedManager] loadObjectsAtResourcePath:path delegate:delegate];*/
    
    NSLog(@"Log In button was pressed!");
    NSLog(@"%@",Email.text);
    
    NSDictionary *params = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                                Email.text,
                                                                Password.text,
                                                                Password.text,
                                                                nil]
                                                       forKeys:[NSArray arrayWithObjects:
                                                                @"email",
                                                                @"password",
                                                                @"password_confirmation",
                                                                nil]];
    
    NSURL* url = [[NSURL alloc]initWithString:@"http://localhost:3000"];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:url];
    
    [objectManager.HTTPClient setAuthorizationHeaderWithUsername:Email.text password:Password.text];
    
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
