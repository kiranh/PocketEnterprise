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
    Email.delegate = self;
    Password.delegate = self;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];//Dismiss the keyboard.
    //Add action you want to call here.
    return YES;
}

- (IBAction)LoginButtonPressed:(id)sender {
    //Authentication token for every request devise
    /*NSString *path = [NSString stringWithFormat:@"/%@/%i", [self pluralizedName], identifier];
     path = [path stringByAppendingQueryParameters:[self appendAuthenticationToken:params]];
     [[RKObjectManager sharedManager] loadObjectsAtResourcePath:path delegate:delegate];*/
    
    NSLog(@"Log In button was pressed!");
    NSLog(@"%@",Email.text);

    [self userLoginProcess:sender];
    
}

- (void)userLoginProcess:(id)sender {
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
    
    //coredata related
    
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    NSString *path = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"Store.sqlite"];
    [managedObjectStore addSQLitePersistentStoreAtPath:path fromSeedDatabaseAtPath:nil withConfiguration:nil options:nil error:nil];
    [managedObjectStore createManagedObjectContexts];
    
    
    // Set up Group and Error Response Descriptors
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
    
    objectManager.managedObjectStore = managedObjectStore;
    
    // or directly from the HTTP client
    NSURLRequest *request = [objectManager.HTTPClient requestWithMethod:@"GET" path:@"/groups.json" parameters:nil];
    //RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[groupDescriptor]];
    
    RKManagedObjectRequestOperation *operation = [[RKManagedObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[groupDescriptor]];
    operation.managedObjectContext = managedObjectStore.mainQueueManagedObjectContext;
    operation.managedObjectCache = managedObjectStore.managedObjectCache;
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        Group *group = [result firstObject];
        NSLog(@"Mapped the group: %@", group.name);
        [self performSegueWithIdentifier:@"LoginSegue" sender:sender];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Failed with error: %@", [error localizedDescription]);
    }];
    
    NSOperationQueue *operationQueue = [NSOperationQueue new];
    [operationQueue addOperation:operation];
    
    /*[objectManager getObjectsAtPath:@"/groups.json"
     parameters:nil
     success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
     NSLog(@"It Worked: %@", [mappingResult array]);
     //  We found a matching login user!  Force the segue transition to the next view
     [self performSegueWithIdentifier:@"LoginSegue" sender:sender];
     }
     failure:^(RKObjectRequestOperation *operation, NSError *error) {
     NSLog(@"It Failed: %@", error);
     }];*/
}
@end
