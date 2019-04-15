//
//  Movie_Pojo.m
//  Movies
//
//  Created by Lost Star on 4/13/19.
//  Copyright © 2019 esraa. All rights reserved.
//

#import "Movie_Pojo.h"

@implementation Movie_Pojo

-(id)initWithDictionary:(NSDictionary *)sourceDictionary{
    self = [super init];
    _movieId=[sourceDictionary valueForKey:@"id"];
    _overview=[sourceDictionary valueForKey:@"overview"];
    _posterPath=[sourceDictionary valueForKey:@"poster_path"];
    _backPath=[sourceDictionary valueForKey:@"backdrop_path"];
    _rate=[sourceDictionary valueForKey:@"vote_average"];
    _releaseDate=[sourceDictionary valueForKey:@"release_date"];
    _titles=[sourceDictionary valueForKey:@"title"];
    return self;
}

@end
