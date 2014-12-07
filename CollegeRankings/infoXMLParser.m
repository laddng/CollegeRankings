//
//  infoXMLParser.m
//  CollegeRankings
//
//  Created by Nick Ladd on 11/19/14.
//  Copyright (c) 2014 Nick Ladd. All rights reserved.
//

#import "infoXMLParser.h"

@implementation infoXMLParser

- (infoXMLParser *) initInfoXMLParser
{
    
    self = [super init];
    
    _info = [[NSMutableArray alloc] init];
    
    return self;
    
}

-(void) parser:(NSXMLParser*) parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"info"])
    {
        
        NSString *informationString = [attributeDict valueForKey:@"text"];
        
        [_info addObject:informationString];
        
    }
    
}

@end