//
//  Movie_Pojo.h
//  Movies
//
//  Created by Lost Star on 4/13/19.
//  Copyright © 2019 esraa. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Movie_Pojo : NSObject

@property  NSString *movieId;
@property  NSString *overview;
@property  NSString *rate;
@property  NSString *posterPath;
@property  NSString *releaseDate;
@property  NSString *titles;
@property  NSString *backPath;

-(id)initWithDictionary:(NSDictionary *)sourceDictionary;

@end


