//
//  MovieCollectionView.h
//  Movies
//
//  Created by Lost Star on 4/13/19.
//  Copyright © 2019 esraa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MKDropdownMenu.h"

@interface MovieCollectionView : UICollectionViewController<MKDropdownMenuDataSource, MKDropdownMenuDelegate>

@property (strong, nonatomic) MKDropdownMenu *navBarMenu;



@end


