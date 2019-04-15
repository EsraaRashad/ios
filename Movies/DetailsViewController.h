//
//  DetailsViewController.h
//  Movies
//
//  Created by Lost Star on 4/14/19.
//  Copyright © 2019 esraa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "Movie_Pojo.h"
#import "MovieCollectionView.h"

@interface DetailsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UITextView *lname;
- (IBAction)youtubeBt:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lDate;
@property (weak, nonatomic) IBOutlet UILabel *lrating;

- (IBAction)favBt:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UIButton *btfav;
@property (weak, nonatomic) IBOutlet UITableView *mytable;
@property (weak, nonatomic) IBOutlet UIView *noReviewsView;
@property (weak, nonatomic) IBOutlet UITextView *overTxt;


@property NSString *name ;
@property NSString *date ;
@property NSString *details ;
@property NSString *pic ;
@property NSNumber *rate ;
@property NSNumber *movieId;

@property NSMutableArray *fav;
@property Movie_Pojo *movie ;
@property (nonatomic) NSString *key;
@property (nonatomic) NSMutableArray *reviews;

@end

