//
//  collegeObject.h
//  CollegeRankings
//
//  Created by Nick Ladd on 10/18/14.
//  Copyright (c) 2014 Nick Ladd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface collegeObject : NSObject

@property int id;

@property NSString *name;

@property NSString *city;

@property NSString *collegeState;

@property NSString *url;

@property int ins;

@property int out;

@property NSString *collegeType;

@property int undergradEnrollment;

@property int undergradFullTimeEnrollment;

@property int undergradPartTimeEnrollment;

@property float ranking;

@end