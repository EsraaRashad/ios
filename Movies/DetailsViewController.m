//
//  DetailsViewController.m
//  Movies
//
//  Created by Lost Star on 4/14/19.
//  Copyright © 2019 esraa. All rights reserved.
////#import "DBmanager.h"

#import "DetailsViewController.h"
#import "MovieCollectionView.h"
#import "Movie_Pojo.h"
#import "AFNetworking.h"

@interface DetailsViewController (){
    UILabel *author;
    UITextView *content1;
//    DBmanager *db;
    Boolean flag;
}

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    flag=false;
    _fav= [NSMutableArray new];
    [_mytable setDelegate:self];
    [_mytable setDataSource:self];
//    db=[DBmanager new];
//
    NSString *urlAsStringImg = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w500%@", _pic ];
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString: urlAsStringImg] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [_lname setText:_name];
    [_lDate setText:_date];
    [_rateLabel setText:[NSString stringWithFormat:@"%@", _rate]];
    
    [_overTxt setText:_details];
    
//    flag= [db findFavMovie:_movie];
//    flag=false;
//    if(!flag){
//
//        [_btfav setBackgroundImage:[UIImage imageNamed:@"favorite_ic_act.png"] forState:UIControlStateNormal];
//    } else {
//
//        [_btfav setBackgroundImage:[UIImage imageNamed:@"favorite_ic.png"] forState:UIControlStateNormal];
//    }
   
     [self getReviewsData:[NSString stringWithFormat:@"%@", _movieId]];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numOfSections = 1;
    if ([_reviews count] != 0)
    {
        self.mytable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        [_noReviewsView setHidden:YES];
        
        
    }
    else
    {
        [_noReviewsView setHidden:NO];
        
    }
    return numOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger numOfRows=0;
    if([_reviews count] != 0){
        numOfRows=[_reviews count];
    }
    
    return numOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *cellIdentifier = @"reviewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    author=[cell viewWithTag:11];
    content1=[cell viewWithTag:12];
    
    author.text=_reviews[indexPath.row][@"author"];
    content1.text=_reviews[indexPath.row][@"content"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)setReviews:(NSMutableArray *)reviews{
    _reviews=reviews;
    [self.mytable reloadData];
    
}

- (void)setKey:(NSString *)key{
    _key=key;
    NSString *keystr=[@"youtube://" stringByAppendingString:_key];
    NSURL *str=[NSURL URLWithString:keystr];
    if ([[UIApplication sharedApplication] canOpenURL:str])
    {  [[UIApplication sharedApplication] openURL:str];
        
    } else {
        NSString *keystr=[@"http://www.youtube.com/watch?v=" stringByAppendingString:_key];
        NSURL *str=[NSURL URLWithString:keystr];
        [[UIApplication sharedApplication] openURL:str];
    }
}


- (IBAction)youtubeBt:(id)sender {
    [self getVideoData:[NSString stringWithFormat:@"%@", _movieId]];
    
   
}


-(void)getVideoData:(NSString *) req{
    
    NSString *str =[[@"http://api.themoviedb.org/3/movie/" stringByAppendingString:req] stringByAppendingString:@"/videos?api_key=fba1791e7e4fb5ada6afc4d9e80550a0&append_to_response=videos"];
    
  
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [[NSURL alloc] initWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSLog(@"%@" , request);
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"%@" , error);
        } else {
         
            NSMutableArray *resultArray = [responseObject objectForKey:@"results"];
            
            
            NSString *keyresult =[resultArray objectAtIndex:0][@"key"];
           
            [self setKey:keyresult];
        }
    }];
    [dataTask resume];
    
}


-(void)getReviewsData :(NSString *)req {
    
    NSString *str =[[@"http://api.themoviedb.org/3/movie/" stringByAppendingString:req] stringByAppendingString:@"/reviews?api_key=fba1791e7e4fb5ada6afc4d9e80550a0"];
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [[NSURL alloc] initWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSLog(@"%@" , request);
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"%@" , error);
        } else {
            
            NSMutableArray *resultArray = [responseObject objectForKey:@"results"];
            
//            NSString *keyresult =[resultArray objectAtIndex:0][@"key"];
            
            [self setReviews:resultArray];
        }
    }];
    [dataTask resume];
    
    
}

- (IBAction)favBt:(id)sender {
    
//    Boolean f;
//    flag= [db findFavMovie:_movie];
    flag=!flag;
    if(flag){
       
        [_btfav setBackgroundImage:[UIImage imageNamed:@"favorite_ic.png"] forState:UIControlStateHighlighted];
//        f=   [db deleteFavMovie:_movie];
        
    } else {
        
        [_btfav setBackgroundImage:[UIImage imageNamed:@"favorite_ic_act.png"] forState:UIControlStateHighlighted];
//        f= [db insertFavMovie:_movie];
        
    }
    
}
@end
