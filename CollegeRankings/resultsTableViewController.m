//
//  resultsTableViewController.m
//  CollegeRankings
//
//  Created by Nick Ladd on 12/7/14.
//  Copyright (c) 2014 Nick Ladd. All rights reserved.
//

#import "resultsTableViewController.h"
#import "detailTableViewController.h"
#import "filtersViewController.h"
#import "collegeObject.h"
#import "resultsTableViewCell.h"

@interface resultsTableViewController () <UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic, strong) UISearchController *searchController;

@property NSMutableArray *resultsArray;

@property NSMutableArray *filteredArray;

@property NSMutableArray *searchResults;

@property int numOfResults;

@property BOOL isFiltered;

@end

@implementation resultsTableViewController

- (void)viewDidLoad
{

    [super viewDidLoad];

    self.numOfResults = 10;

    [self calculateResults];

    [self initFilters];
    
    [self loadSearchController];

}

- (void) initFilters
{
    
    _filters = [[filterObject alloc] init];
    
    _filters.isFiltered = NO;
    
    _filters.filteredState = @"ALL";
    
    _filters.filteredType = @"ALL";
    
    _filters.maxTuitionFilter = [self getMaxTuition];
    
    _filters.setMaxTuitionFilter = [self getMaxTuition];
    
    _filters.minEnrollmentFilter = 0;
    
    _filters.maxEnrollmentFilter = [self getMaxEnrollment];
    
    self.numOfResults = 10;
    
    self.showMoreResults.hidden = NO;
    
    [self.tableView reloadData];

}

- (void) loadSearchController
{
    
    self.searchResults = [[NSMutableArray alloc] init];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    
    self.searchController.searchResultsUpdater = self;
    
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.searchController.searchBar.delegate = self;
    
    self.definesPresentationContext = YES;
    
}

- (int) getMaxTuition
{

    int returnValue = [[_resultsArray valueForKeyPath:@"@max.out"] intValue];
    
    returnValue = 50.0 * floor((returnValue/50.0)+0.5);
    
    return returnValue;

}

- (int) getMaxEnrollment
{

    int returnValue = [[_resultsArray valueForKeyPath:@"@max.undergradFullTimeEnrollment"] intValue];
    
    returnValue = 50.0 * floor((returnValue/50.0)+0.5);
    
    return returnValue;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.searchController.active)
    {
        
        return [self.searchResults count];
        
    }
    
    return self.numOfResults;

}

- (IBAction) loadMoreResults
{

    if(_filters.isFiltered == YES)
    {
        
        [self loadMoreResults:_filteredArray];
        
    }
    
    else if(_filters.isFiltered == NO)
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
    
    if (self.searchController.active)
    {
        
        cell.uniName.text = [[_searchResults objectAtIndex:indexPath.row] name];
        
        cell.uniTown.text = [NSString stringWithFormat:@"%@, %@", [[_searchResults objectAtIndex:indexPath.row] city], [[_searchResults objectAtIndex:indexPath.row] collegeState]];
        
        cell.uniRank.text = [NSString stringWithFormat: @"%i", (int)[[_searchResults objectAtIndex:indexPath.row] ranking]];
        
        return cell;
        
    }
    
    else if(_filters.isFiltered == NO)
    {
        
        cell.uniName.text = [[_resultsArray objectAtIndex:indexPath.row] name];
        
        cell.uniTown.text = [NSString stringWithFormat:@"%@, %@", [[_resultsArray objectAtIndex:indexPath.row] city], [[_resultsArray objectAtIndex:indexPath.row] collegeState]];
        
        cell.uniRank.text = [NSString stringWithFormat: @"%i", (int)[[_resultsArray objectAtIndex:indexPath.row] ranking]];
        
        return cell;
        
    }
    
    else
    {
        
        cell.uniName.text = [[_filteredArray objectAtIndex:indexPath.row] name];
        
        cell.uniTown.text = [NSString stringWithFormat:@"%@, %@", [[_filteredArray objectAtIndex:indexPath.row] city], [[_filteredArray objectAtIndex:indexPath.row] collegeState]];
        
        cell.uniRank.text = [NSString stringWithFormat: @"%i", (int)[[_filteredArray objectAtIndex:indexPath.row] ranking]];
        
        return cell;
        
    }
    
}

-(IBAction) filterViewDidUnwind:(UIStoryboardSegue *) segue
{
    
    [self filterResultsArray:_filters];
    
    [self.tableView reloadData];
    
}

- (void) filterResultsArray:(filterObject *) filtersApplied
{

    int rankingIndex = 0;

    collegeObject *collegeObject;
        
    _filteredArray = [[NSMutableArray alloc] init];
        
    for(int i=0; i<[_resultsArray count]; i++)
    {
        
        collegeObject = [_resultsArray objectAtIndex:i];

        if([self collegeMeetsFilterRequirement:_filters college:collegeObject])
        {

            rankingIndex++;
            
            collegeObject.ranking = rankingIndex;
            
            [_filteredArray addObject:collegeObject];

        }
       
    }
    
    _filters.isFiltered = YES;

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

- (BOOL) collegeMeetsFilterRequirement:(filterObject *) filtersToApply college:(collegeObject *) collegeToBeFiltered
{
    
    if (![[collegeToBeFiltered collegeState] isEqualToString:[_filters filteredState]] && ![[_filters filteredState] isEqualToString:@"ALL"])
    {

        return NO;
        
    }
    
    else if(![[collegeToBeFiltered collegeType] isEqualToString:[_filters filteredType]] && ![[_filters filteredType] isEqualToString:@"ALL"])
    {
        
        return NO;
        
    }
    
    else if([collegeToBeFiltered out] > (int)[_filters setMaxTuitionFilter])
    {
        
        return NO;
        
    }
    
    else if([collegeToBeFiltered undergradFullTimeEnrollment] > (int)[_filters setMaxEnrollmentFilter])
    {
        
        return NO;
        
    }
    
    else if ([collegeToBeFiltered undergradFullTimeEnrollment] < (int)[_filters minEnrollmentFilter])
    {
        
        return NO;
        
    }
    
    return YES;
    
}

-(IBAction) clearFilters:(UIStoryboardSegue *) segue
{
    
    [self initFilters];
    
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
    self.showMoreResults.hidden = YES;
    
    NSString *searchString = [self.searchController.searchBar text];
    
    NSString *scope = nil;
    
    [self updateFilteredContentForName:searchString type:scope];
    
    [self.tableView reloadData];
    
}

- (void)updateFilteredContentForName:(NSString *)name type:(NSString *)typeName
{
    
    if ((name == nil) || [name length] == 0)
    {
        if (_filters.isFiltered == NO)
        {
            
            self.searchResults = [self.resultsArray mutableCopy];

        }
        
        else
        {
            
            self.searchResults = [self.filteredArray mutableCopy];
            
        }
        
        return;
        
    }
    
    [self.searchResults removeAllObjects];

    if (_filters.isFiltered == NO)
    {
    
        for (collegeObject *college in self.resultsArray)
        {
                
                NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
                
                NSRange nameRange = NSMakeRange(0, college.name.length);
                
                NSRange foundRange = [college.name rangeOfString:name options:searchOptions range:nameRange];
                
                if (foundRange.length > 0)
                {
                    
                    [self.searchResults addObject:college];
                    
                }
            
        }
        
    }
    
    else
    {
        for (collegeObject *college in self.filteredArray)
        {
                
                NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
                
                NSRange nameRange = NSMakeRange(0, college.name.length);
                
                NSRange foundRange = [college.name rangeOfString:name options:searchOptions range:nameRange];
                
                if (foundRange.length > 0)
                {
                    
                    [self.searchResults addObject:college];
                    
                }
            
        }
        
    }
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"detailVC"])
    {
        
        detailTableViewController *detailView = [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        
        if (self.searchController.active)
        {
            
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            
            detailView.collegeInfo = [_searchResults objectAtIndex:indexPath.row];
            
        }
        
        else if(_filters.isFiltered == NO)
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

        filtersView.filtersToBeApplied = self.filters;
        
    }
    
}

- (void) calculateResults
{

    _resultsArray = [[NSMutableArray alloc] init];

    NSString *urlToLocalMatrix = [[NSBundle mainBundle] pathForResource:@"count_matrix" ofType:@"csv"];

    NSString *stringOfMatrix = [NSString stringWithContentsOfFile:urlToLocalMatrix encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *countMatrixArray = [stringOfMatrix componentsSeparatedByString:@"\n"];

    NSMutableArray *countMatrix = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[countMatrixArray count]; i++)
    {
        
        NSArray *entry = [[countMatrixArray objectAtIndex:i] componentsSeparatedByString:@","];
        
        [countMatrix addObject:entry];
        
    }
    
    NSString *urlToLocalSchoolsFile = [[NSBundle mainBundle] pathForResource:@"schools" ofType:@"csv"];
    
    NSString *stringOfSchools = [NSString stringWithContentsOfFile:urlToLocalSchoolsFile encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *schoolsArray = [stringOfSchools componentsSeparatedByString:@"\n"];
    
    NSMutableArray *schools = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[schoolsArray count]; i++)
    {

        NSArray *entry = [[schoolsArray objectAtIndex:i] componentsSeparatedByString:@","];

        if ([entry count] > 0)
        {
            
            collegeObject *entrySchool = [[collegeObject alloc] init];

            entrySchool.id = i;
            entrySchool.name = entry[0];
            entrySchool.city = entry[1];
            entrySchool.collegeState = entry[2];
            entrySchool.url = entry[3];
            entrySchool.collegeType = entry[4];
            entrySchool.ins = [entry[5] intValue];
            entrySchool.out = [entry[6] intValue];
            entrySchool.undergradEnrollment = [entry[7] intValue];
            entrySchool.undergradFullTimeEnrollment = [entry[8] intValue];
            entrySchool.undergradPartTimeEnrollment = [entry[9] intValue];

            [schools addObject:entrySchool];
            
        }

    }
    
    NSString *urlToLocalZmatrixFile = [[NSBundle mainBundle] pathForResource:@"z_matrix" ofType:@"csv"];
    
    NSString *stringOfZmatrix = [NSString stringWithContentsOfFile:urlToLocalZmatrixFile encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *zMatrixArray = [stringOfZmatrix componentsSeparatedByString:@"\n"];
    
    NSMutableArray *z_matrix = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[zMatrixArray count]; i++)
    {
        
        NSMutableArray *entry = [[NSMutableArray alloc] initWithArray:[[zMatrixArray objectAtIndex:i] componentsSeparatedByString:@","]];
        
        [entry removeObjectAtIndex:[entry count]-1];
        
        [z_matrix addObject:entry];
        
    }
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    float sum = 0.0;
    
    for (int i=0; i<[z_matrix count]; i++)
    {
        
        sum = 0.0;
        
        for (int k=0; k<[[z_matrix objectAtIndex:i] count]-1; k++)
        {
            
            NSArray *temporaryArray = [z_matrix objectAtIndex:i];
                
            sum = sum + [[temporaryArray objectAtIndex:k] floatValue]*[[_surveyInputValues objectAtIndex:k] floatValue];
            
        }
        
        NSNumber *number = [NSNumber numberWithFloat:sum];
        
        [tempArray addObject:number];
        
        sum = 0.0;
        
    }
    
    NSMutableArray *tempArray2 = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[countMatrix count]; i++)
    {
        
        sum = 0.0;
        
        for (int k=0; k<[[countMatrix objectAtIndex:i] count]-1; k++)
        {
            
            sum = sum + [[[countMatrix objectAtIndex:i] objectAtIndex:k] floatValue]*[[_surveyInputValues objectAtIndex:k] floatValue];
            
        }
        
        NSNumber *number = [NSNumber numberWithFloat:sum];
        
        [tempArray2 addObject:number];
        
        sum = 0.0;
        
    }
    
    NSMutableArray *tempArray3 = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[tempArray count]; i++)
    {
        
        float tempCalc = ([[tempArray objectAtIndex:i] floatValue]/[[tempArray2 objectAtIndex:i] floatValue])*100.0;
        
        NSNumber *number = [NSNumber numberWithFloat:tempCalc];
        
        [tempArray3 addObject:number];
        
    }

    for (int i=0; i<[schools count]; i++)
    {
        
        collegeObject *tempCollegeObject = [schools objectAtIndex:i];
        tempCollegeObject.ranking = [[tempArray3 objectAtIndex:i] floatValue];
        [schools replaceObjectAtIndex:i withObject:tempCollegeObject];
        
    }

    [schools sortUsingDescriptors: [NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"ranking" ascending:NO], nil]];
    
    for (int i=0; i<[schools count]; i++)
    {
        collegeObject *tempCollegeObject = [schools objectAtIndex:i];
        tempCollegeObject.ranking = i+1;
        [schools replaceObjectAtIndex:i withObject:tempCollegeObject];
    }
    
    _resultsArray = schools;

    [self.tableView reloadData];

}

@end