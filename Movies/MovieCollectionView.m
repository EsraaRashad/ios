//
//  MovieCollectionView.m
//  Movies
//
//  Created by Lost Star on 4/13/19.
//  Copyright © 2019 esraa. All rights reserved.
//

#import "MovieCollectionView.h"
#import "Movie_Pojo.h"
#import "AFNetworking.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DetailsViewController.h"


@interface MovieCollectionView (){
    NSString *moviestr;
    
    NSMutableArray *results;
    NSDictionary *pojo_dic;
    UIImageView *imageView;
    Movie_Pojo *pojo;
    NSArray *selectMovieType;
}

@end

@implementation MovieCollectionView
NSMutableArray *results  ;
NSMutableDictionary *dic ;
NSURLRequest *request ;
NSMutableData *myData ;
//@synthesize requestType;
NSString * urlAsString ;
NSString * type ;

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    

    pojo=[Movie_Pojo new];
    results=[NSMutableArray new];
    dic = [NSMutableDictionary new ];
    
    
    urlAsString = [NSString stringWithFormat:@"http://api.themoviedb.org/3/discover/movie?api_key=fba1791e7e4fb5ada6afc4d9e80550a0"];
    [self MakeRequest:urlAsString];
    
    
 
    
    //[UIColor colorWithRed:0.29 green:0.33 blue:0.62 alpha:1.0];
    selectMovieType = @[@"Home",@"Most Popular", @"Top Rated"];
   
    
    
    //create drop down menu
    
    self.navBarMenu = [[MKDropdownMenu alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    self.navBarMenu.dataSource = self;
    self.navBarMenu.delegate = self;
    
    // Make background light instead of dark when presenting the dropdown
    self.navBarMenu.backgroundDimmingOpacity = -0.67;
    
    // Set custom disclosure indicator image
    UIImage *indicator = [UIImage imageNamed:@"indicator"];
    self.navBarMenu.disclosureIndicatorImage = indicator;
    
    // Let the dropdown take the whole width of the screen with 10pt insets
    self.navBarMenu.useFullScreenWidth = YES;
    self.navBarMenu.fullScreenInsetLeft = 10;
    self.navBarMenu.fullScreenInsetRight = 10;
    
    // Add the dropdown menu to navigation bar
    self.navigationItem.titleView = self.navBarMenu;
    
    
    

}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navBarMenu closeAllComponentsAnimated:NO];
   
}



-(void)MakeRequest:(NSString *) req{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [[NSURL alloc] initWithString:req];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSLog(@"%@" , request);
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"%@" , error);
        } else {
            
            
            //self->results=[responseObject objectForKey:@"results"];
            
            
           
            
            printf("%lu" , (unsigned long)self->results.count);
            
            NSMutableArray *resultDictinary = [responseObject objectForKey:@"results"];
            for (NSDictionary *userDictionary in resultDictinary)
            {
                //allocating new user from the dictionary
                //self->pojo=[[Movie_Pojo alloc]initWithDictionary:userDictionary];
                [self->results addObject:userDictionary];

            }
            [self.collectionView reloadData];
            
        }
    }];
    [dataTask resume];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [results count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    imageView =(UIImageView *)[cell viewWithTag:2];
    
  
    NSString *urlAsStringImg = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w780%@",  results [indexPath.row][@"poster_path"]];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString: urlAsStringImg] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];

  if (indexPath.row == results.count-1) {
        
      urlAsString = [NSString stringWithFormat:@"http://api.themoviedb.org/3/discover/movie?api_key=fba1791e7e4fb5ada6afc4d9e80550a0&page=%lu",results.count/20+1];
      
        [self MakeRequest:urlAsString];
      
      
        //results.count/20+1
    }
    
    pojo=results[indexPath.row];
//    NSString *urlAsStringImg = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w500%@",  results [indexPath.row][@"poster_path"]];
//    imageView = [cell viewWithTag:2];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:urlAsStringImg]
//                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//    // Configure the cell
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     pojo=results[indexPath.row];
    
//    [pojo setTitles:results[indexPath.row][@"original_title"]];
//    [pojo setOverview:results[indexPath.row][@"overview"]];
//    [pojo setRate:results[indexPath.row][@"vote_average"]];
//    [pojo setPosterPath:results[indexPath.row][@"poster_path"]];
//    [pojo setReleaseDate:results[indexPath.row][@"release_date"]];
//    [pojo setBackPath:results[indexPath.row][@"backdrop_path"]];
//    [pojo setMovieID:results[indexPath.row][@"id"]];
//    
    DetailsViewController *Details = [self.storyboard instantiateViewControllerWithIdentifier:@"details"];
    [Details setMovie:pojo];
    [Details setMovieId:results[indexPath.row][@"id"]];
    [Details setName : results[indexPath.row][@"original_title"] ];
    [Details setPic: results[indexPath.row][@"backdrop_path"] ];
    [Details setDate : results[indexPath.row][@"release_date"] ];
    [Details setRate: results[indexPath.row][@"vote_average"]];
    [Details setDetails:results[indexPath.row][@"overview"]];
    
    
    
    [self.navigationController pushViewController:Details animated:YES];
    
    
    
    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/





#pragma mark - MKDropdownMenuDataSource

- (NSInteger)numberOfComponentsInDropdownMenu:(MKDropdownMenu *)dropdownMenu {
    return 1;
}

- (NSInteger)dropdownMenu:(MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

#pragma mark - MKDropdownMenuDelegate

- (CGFloat)dropdownMenu:(MKDropdownMenu *)dropdownMenu rowHeightForComponent:(NSInteger)component {
    return 60;
}

- (NSAttributedString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu attributedTitleForComponent:(NSInteger)component {
//    self.view.backgroundColor = [UIColor colorWithRed:0.29 green:0.33 blue:0.62 alpha:1.0];
    return [[NSAttributedString alloc] initWithString:@"Movie Filter"
                                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18 weight:UIFontWeightLight],
                                                        NSForegroundColorAttributeName: [UIColor colorWithRed:0.29 green:0.33 blue:0.62 alpha:1.0]}];
}

- (NSAttributedString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSMutableAttributedString *string =
    [[NSMutableAttributedString alloc] initWithString: selectMovieType[row]
                                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20 weight:UIFontWeightMedium],
                                                        NSForegroundColorAttributeName: [UIColor colorWithRed:0.64 green:0.67 blue:0.95 alpha:1.0]}];
//    [string appendAttributedString:
//     [[NSAttributedString alloc] initWithString:selectMovieType[row]
//                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20 weight:UIFontWeightMedium],
//                                                  NSForegroundColorAttributeName: [UIColor colorWithRed:0.64 green:0.67 blue:0.95 alpha:1.0]}]];
    return string;
}

- (UIColor *)dropdownMenu:(MKDropdownMenu *)dropdownMenu backgroundColorForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [UIColor colorWithRed:0.29 green:0.33 blue:0.62 alpha:1.0];
}





- (UIColor *)dropdownMenu:(MKDropdownMenu *)dropdownMenu backgroundColorForHighlightedRowsInComponent:(NSInteger)component {
    return [UIColor colorWithWhite:0.5 alpha:0.5];
}


- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    NSString *colorString = self.selectMovieType[row];
//    self.textLabel.text = colorString;
//
    switch (row) {
            case 0:
            [self setTitle:@"Home"];
          
            moviestr =@"http://api.themoviedb.org/3/discover/movie?api_key=fba1791e7e4fb5ada6afc4d9e80550a0";
          
            [self MakeRequest:moviestr];
            [dropdownMenu closeAllComponentsAnimated:YES];
            break;
            
        case 1:
            [self setTitle:@"Pop Movies"];
            
            moviestr =@"http://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=fba1791e7e4fb5ada6afc4d9e80550a0";
            
            [self MakeRequest:moviestr];
            [dropdownMenu closeAllComponentsAnimated:YES];
            break;
            
            case 2:
            [self setTitle:@"Rated Movies"];
           
            moviestr =@"http://api.themoviedb.org/3/discover/movie?sort_by=top_rated.desc&api_key=fba1791e7e4fb5ada6afc4d9e80550a0";
            [self setTitle:@"Rated Movies"];
         
            [self MakeRequest:moviestr];
            [dropdownMenu closeAllComponentsAnimated:YES];
            break;
            
        default:
            break;
    }
    
//    delay(0.15, ^{
//        [dropdownMenu closeAllComponentsAnimated:YES];
//    });
}

@end
