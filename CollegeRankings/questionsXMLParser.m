//
//  questionsXMLParser.m
//  CollegeRankings
//
//  Created by Nick Ladd on 11/19/14.
//  Copyright (c) 2014 Nick Ladd. All rights reserved.
//

#import "questionsXMLParser.h"

@implementation questionsXMLParser

- (questionsXMLParser *) initXMLParser
{
    
    self = [super init];
    
    _questions = [[NSMutableArray alloc] init];
    
    return self;
    
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"question"])
    {
        
        NSString *question = [attributeDict valueForKey:@"text"];
        
        [_questions addObject:question];
        
    }
    
}

@end