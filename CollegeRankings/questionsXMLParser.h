//
//  questionsXMLParser.h
//  CollegeRankings
//
//  Created by Nick Ladd on 11/19/14.
//  Copyright (c) 2014 Nick Ladd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface questionsXMLParser : NSXMLParser <NSXMLParserDelegate>

@property (strong, nonatomic) NSMutableArray *questions;

- (questionsXMLParser *) initXMLParser;

@end