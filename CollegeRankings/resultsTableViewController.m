//
//  resultsTableViewController.m
//  CollegeRankings
//
//  Created by Nick Ladd on 12/7/14.
//  Copyright (c) 2014 Nick Ladd. All rights reserved.
//

#import "resultsTableViewController.h"
#import "detailViewController.h"
#import "filtersViewController.h"
#import "collegeObject.h"
#import "resultsTableViewCell.h"

@interface resultsTableViewController ()

@property int numOfResults;

@property NSMutableArray *resultsArray;

@property NSMutableArray *filteredArray;

@property NSArray *searchResults;

@end

@implementation resultsTableViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.controller = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    self.controller.searchBar.delegate = self;
    
    self.numOfResults = 10;
    
    self.filteredState = @"ALL";
    
    self.filteredType = @"ALL";
    
    _resultsArray = [[NSMutableArray alloc] init];
    
    [self calculateResults];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.tableView)
    {
        
        return self.numOfResults;
        
    }
    
    else
    {
        
        return [_searchResults count];

    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 51;
    
}

- (IBAction) loadMoreResults
{
    
    if(![_filteredState isEqualToString:@"ALL"])
    {
        
        [self loadMoreResults:_filteredArray];
        
    }
    
    else if([_filteredState isEqualToString:@"ALL"])
    {
        
        [self loadMoreResults:_resultsArray];
        
    }
    
}

- (void) loadMoreResults: (NSMutableArray *) array
{
    
    if([array count] > self.numOfResults + 10)
    {
        
        self.numOfResults = self.numOfResults + 10;
        
        [self.tableView reloadData];
        
    }
    
    else if([array count] <= self.numOfResults + 10)
    {
        
        self.numOfResults = (int)([_filteredArray count]-1);
        
        [self.tableView reloadData];
        
        self.showMoreResults.hidden = YES;
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    resultsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"school"];
    
    if (!(tableView == self.tableView))
    {
        
        cell.uniName.text = [[_searchResults objectAtIndex:indexPath.row] name];
        
        cell.uniTown.text = [NSString stringWithFormat:@"%@, %@", [[_searchResults objectAtIndex:indexPath.row] city], [[_searchResults objectAtIndex:indexPath.row] collegeState]];
        
        cell.uniRank.text = [NSString stringWithFormat: @"%i", [[_searchResults objectAtIndex:indexPath.row] ranking]];
        
        return cell;

    }
    
    else if([_filteredState isEqualToString:@"ALL"] && [_filteredType isEqualToString:@"ALL"])
    {
        
        cell.uniName.text = [[_resultsArray objectAtIndex:indexPath.row] name];
        
        cell.uniTown.text = [NSString stringWithFormat:@"%@, %@", [[_resultsArray objectAtIndex:indexPath.row] city], [[_resultsArray objectAtIndex:indexPath.row] collegeState]];
        
        cell.uniRank.text = [NSString stringWithFormat: @"%i", [[_resultsArray objectAtIndex:indexPath.row] ranking]];
        
        return cell;
        
    }
    
    else
    {
        
        cell.uniName.text = [[_filteredArray objectAtIndex:indexPath.row] name];
        
        cell.uniTown.text = [NSString stringWithFormat:@"%@, %@", [[_filteredArray objectAtIndex:indexPath.row] city], [[_filteredArray objectAtIndex:indexPath.row] collegeState]];
        
        cell.uniRank.text = [NSString stringWithFormat: @"%i", [[_filteredArray objectAtIndex:indexPath.row] ranking]];
        
        return cell;
        
    }
    
}

-(IBAction) filterViewDidUnwind:(UIStoryboardSegue *) segue
{
    
    if ([_filteredState isEqualToString:@"ALL"] && [_filteredType isEqualToString:@"ALL"])
    {
        
        [self clearFilters];
        
    }
    
    else if ((![_filteredState isEqualToString:@"ALL"]) && [_filteredType isEqualToString:@"ALL"])
    {
        
        [self filterByState:YES type:NO];
        
    }
    
    else if ((![_filteredState isEqualToString:@"ALL"]) && (![_filteredType isEqualToString:@"ALL"]))
    {
        
        [self filterByState:YES type:YES];
        
    }
    
    else if ([_filteredState isEqualToString:@"ALL"] && (![_filteredType isEqualToString:@"ALL"]))
    {
        
        [self filterByState:NO type:YES];
        
        
    }
    
    [self.tableView reloadData];
    
}

- (void) filterByState:(BOOL)state type:(BOOL)type
{
    
    int rankingIndex = 0;
    
    collegeObject *object;
    
    if (state && !type)
    {
        
        _filteredArray = [[NSMutableArray alloc] init];
        
        for(int i=0; i<[_resultsArray count]; i++){
            
            if([[[_resultsArray objectAtIndex:i] collegeState] isEqualToString:_filteredState])
            {
                
                rankingIndex++;
                
                object = [_resultsArray objectAtIndex:i];
                
                object.ranking = rankingIndex;
                
                [_filteredArray addObject:object];
                
            }
            
        }
        
        if([_filteredArray count] < 10)
        {
            
            self.numOfResults = (int)[_filteredArray count];
            self.showMoreResults.hidden = YES;
            
        }
        
        else
        {
            
            self.numOfResults = 10;
            self.showMoreResults.hidden = NO;
            
        }
        
    }
    
    if (state && type)
    {
        
        _filteredArray = [[NSMutableArray alloc] init];
        
        for(int i=0; i<[_resultsArray count]; i++)
        {
            
            if([[[_resultsArray objectAtIndex:i] collegeState] isEqualToString:_filteredState] && [[[_resultsArray objectAtIndex:i] collegeType] isEqualToString:_filteredType])
            {
                
                rankingIndex++;
                
                object = [_resultsArray objectAtIndex:i];
                
                object.ranking = rankingIndex;
                
                [_filteredArray addObject:object];
                
            }
            
        }
        
        if([_filteredArray count] < 10)
        {
            
            self.numOfResults = (int)[_filteredArray count];
            self.showMoreResults.hidden = YES;
            
        }
        
        else
        {
            
            self.numOfResults = 10;
            self.showMoreResults.hidden = NO;
            
        }
        
    }
    
    if (!state && type)
    {
        
        _filteredArray = [[NSMutableArray alloc] init];
        
        for(int i=0; i<[_resultsArray count]; i++)
        {
            
            if([[[_resultsArray objectAtIndex:i] collegeType] isEqualToString:_filteredType])
            {
                
                rankingIndex++;
                
                object = [_resultsArray objectAtIndex:i];
                
                object.ranking = rankingIndex;
                
                [_filteredArray addObject:object];
            }
            
        }
        
        if([_filteredArray count] < 10)
        {
            
            self.numOfResults = (int)[_filteredArray count];
            self.showMoreResults.hidden = YES;
            
        }
        
        else
        {
            
            self.numOfResults = 10;
            self.showMoreResults.hidden = NO;
            
        }
        
    }
    
}

-(IBAction) clearFilters:(UIStoryboardSegue *) segue
{
    
    [self clearFilters];
    
}

- (void) clearFilters
{
    
    _filteredState = @"ALL";
    
    _filteredType = @"ALL";
    
    self.numOfResults = 10;
    
    self.showMoreResults.hidden = NO;
    
    [self.tableView reloadData];
    
}

- (void) calculateResults
{
    
#include "collegeData.h"
    
    float myArray[11] = {[[self.surveyInput objectAtIndex:0] floatValue], [[self.surveyInput objectAtIndex:1] floatValue], [[self.surveyInput objectAtIndex:2] floatValue],[[self.surveyInput objectAtIndex:3] floatValue], [[self.surveyInput objectAtIndex:4] floatValue], [[self.surveyInput objectAtIndex:5] floatValue], [[self.surveyInput objectAtIndex:6] floatValue], [[self.surveyInput objectAtIndex:7] floatValue], [[self.surveyInput objectAtIndex:8] floatValue], [[self.surveyInput objectAtIndex:9] floatValue], [[self.surveyInput objectAtIndex:10] floatValue]};
    
    float myResult[1989];
    float temp1[1989];
    float temp2[1989];
    float temp3[1989];
    
    float sum = 0.0;
    int rows=1989;
    int columns=11;
    int i,j,k;
    
    for (i=0; i < rows ; i++ )
    {
        sum = 0.0;
        for ( k = 0 ; k < columns ; k++ )
        {
            sum = sum + myMatrix1[i][k]*myArray[k];
        }
        
        temp1[i] = sum;
        sum = 0.0;
    }
    
    for (i=0; i < rows ; i++ )
    {
        sum = 0.0;
        
        for ( k = 0 ; k < columns ; k++ )
        {
            sum = sum + myMatrix2[i][k]*myArray[k];
        }
        
        temp2[i] = sum;
        sum = 0.0;
    }
    
    for ( k = 0 ; k < rows ; k++ )
    {
        temp3[k] = temp1[k]/temp2[k];
        myResult[k] = (temp1[k]/temp2[k])*100.0;
    }
    
    for (j=0;j< keysArray.count; j++)
    {
        
        [rankingsListing setObject :[NSNumber numberWithFloat:myResult[j]] forKey: keysArray[j]];
        
    };
    
    NSComparisonResult (^cmp)(id, id) = ^(id obj1, id obj2)
    {
        
        return [obj2 compare:obj1];
        
    };
    
    // Problem here in sorting keys
    NSArray *orderedKeys = [rankingsListing keysSortedByValueUsingComparator:cmp];
    
    NSArray *items;
    
    int resultsRanking = 0;
    
    for (id key in orderedKeys)
    {
        
        resultsRanking++;
        
        items = [key componentsSeparatedByString:@","];
        collegeObject *result = [[collegeObject alloc] init];
        result.name = items[0];
        result.city = items[1];
        result.collegeState = items[2];
        result.url = items[3];
        result.collegeType = items[4];
        result.ins = items[5];
        result.out = items[6];
        result.ranking = resultsRanking;
        
        [_resultsArray addObject:result];
        
    }
    
    [self.tableView reloadData];
    
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    
    if([_filteredState isEqualToString:@"ALL"] && [_filteredType isEqualToString:@"ALL"])
    {
        
        _searchResults = [_resultsArray filteredArrayUsingPredicate:resultPredicate];
        
    }
    
    else
    {
        
        _searchResults = [_filteredArray filteredArrayUsingPredicate:resultPredicate];
        
    }
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    [self filterContentForSearchText:searchText scope:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"detailVC"])
    {
        
        detailViewController *detailView = [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        
        if (self.controller.active)
        {
            
            //myIndexPath = [self.controller.searchResultsController indexPathForSelectedRow];
            
            detailView.collegeInfo = [_searchResults objectAtIndex:myIndexPath.row];
            
        }
        
        else if([_filteredState isEqualToString:@"ALL"] && [_filteredType isEqualToString:@"ALL"])
        {
            
            detailView.collegeInfo = [_resultsArray objectAtIndex:myIndexPath.row];
            
        }
        
        else
        {
            
            detailView.collegeInfo = [_filteredArray objectAtIndex:myIndexPath.row];
            
        }
        
    }
    
    else if ([[segue identifier] isEqualToString:@"filtersVC"])
    {
        
        UINavigationController *nav = segue.destinationViewController;
        
        filtersViewController *filtersView = (filtersViewController *) nav.topViewController;
        
        filtersView.filteredByState = self.filteredState;
        
        filtersView.filteredByType = self.filteredType;
        
    }
    
}

@end