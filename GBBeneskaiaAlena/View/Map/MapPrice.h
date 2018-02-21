//
//  GBBeneskaiaAlena
//
//  Created by  Алёна Бенецкая on 08.02.2018.
//  Copyright © 2018  Алёна Бенецкая. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"


@interface MapPrice : NSObject
@property(strong, nonatomic) City *destination;
@property(strong, nonatomic) City *origin;
@property(strong, nonatomic) NSDate *departure;
@property(strong, nonatomic) NSDate *returnDate;
@property(nonatomic) NSInteger numberOfChanges;
@property(nonatomic) NSInteger value;
@property(nonatomic) NSInteger distance;
@property(nonatomic) BOOL actual;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary withOrigin:(City *)origin;
@end
