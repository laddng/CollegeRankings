//
//  filterObject.h
//  CollegeRankings
//
//  Created by Niclas Ladd on 2/21/15.
//  Copyright (c) 2015 Nick Ladd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface filterObject : NSObject

@property BOOL isFiltered;

@property NSString *filteredState;

@property NSString *filteredType;

@property int maxTuitionFilter;

@property int setMaxTuitionFilter;

@property int minEnrollmentFilter;

@property int setMinEnrollmentFilter;

@property int maxEnrollmentFilter;

@property int setMaxEnrollmentFilter;

@end