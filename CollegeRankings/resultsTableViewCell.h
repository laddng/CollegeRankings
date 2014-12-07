//
//  resultsTableViewCell.h
//  CollegeRankings
//
//  Created by Nick Ladd on 10/18/14.
//  Copyright (c) 2014 Nick Ladd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface resultsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *uniName;

@property (weak, nonatomic) IBOutlet UILabel *uniTown;

@property (weak, nonatomic) IBOutlet UILabel *uniRank;

@end