//
//  Group.h
//  PocketEnterprise
//
//  Created by Kiran Soumya on 1/12/13.
//  Copyright (c) 2013 Kiran Soumya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject

@property(nonatomic, retain) NSNumber* groupID;
@property(nonatomic, retain) NSString* name;
@property(nonatomic, retain) NSNumber* ownerID;
@property(nonatomic, retain) NSDateFormatter* createdAt;

@end
