//
//  ViewController.m
//  PocketEnterprise
//
//  Created by Kiran Soumya on 1/9/13.
//  Copyright (c) 2013 Kiran Soumya. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
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
    // Signup
    /*NSDictionary *params = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                                Email.text,
                                                                Password.text,
                                                                Password.text,
                                                                nil]
                                                       forKeys:[NSArray arrayWithObjects:
                                                                @"email",
                                                                @"password",
                                                                @"password_confirmation",
                                                                nil]];*/
    
    // Set up Article and Error Response Descriptors
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Group class]];
    [mapping addAttributeMappingsFromArray:@[@"groupID", @"name", @"createdAt"]];
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *groupDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping pathPattern:@"/groups.json" keyPath:NULL statusCodes:statusCodes];
    
    RKObjectMapping *errorMapping = [RKObjectMapping mappingForClass:[RKErrorMessage class]];
    // The entire value at the source key path containing the errors maps to the message
    [errorMapping addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:nil toKeyPath:@"message"]];
    
    NSIndexSet *status = RKStatusCodeIndexSetForClass(RKStatusCodeClassClientError);
    // Any response in the 4xx status code range with an "errors" key path uses this mapping
    RKResponseDescriptor *errorDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping pathPattern:nil keyPath:@"errors" statusCodes:status];
    
    
    
    NSURL* url = [[NSURL alloc]initWithString:@"http://localhost:3000"];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:url];
    
    [objectManager addResponseDescriptorsFromArray:@[ groupDescriptor, errorDescriptor ]];
    
    [objectManager.HTTPClient setAuthorizationHeaderWithUsername:Email.text password:Password.text];
    
    [objectManager getObjectsAtPath:@"/groups.json"
                         parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                NSLog(@"It Worked: %@", [mappingResult array]);
                                //  We found a matching login user!  Force the segue transition to the next view
                                [self performSegueWithIdentifier:@"LoginSegue" sender:sender];
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                NSLog(@"It Failed: %@", error);
                            }];
    //First Trial
    /*[objectManager getObjectsAtPath:@"/groups.json" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
     {
         NSLog(@"It Worked: %@", [mappingResult array]);
         // Or if you're only expecting a single object:
         NSLog(@"It Worked: %@", [mappingResult firstObject]);
     } failure:^(RKObjectRequestOperation *operation, NSError *error) {
         NSLog(@"It Failed: %@", error);
     }];*/
    
    
}
@end
