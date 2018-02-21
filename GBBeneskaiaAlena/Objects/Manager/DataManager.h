//
//  DataManager.h
//  GBBeneskaiaAlena
//
//  Created by  Алёна Бенецкая on 08.02.2018.
//  Copyright © 2018  Алёна Бенецкая. All rights reserved.
//

#import "Country.h"
#import "City.h"
#import "Airport.h"
#import "DataSourceTypeEnum.h"

#define kDataManagerLoadDataDidComplete  @"DataManagerLoadDataDidComplete"


@interface DataManager : NSObject

@property(nonatomic, strong, readonly) NSArray *countries;
@property(nonatomic, strong, readonly) NSArray *cities;
@property(nonatomic, strong, readonly) NSArray *airports;

+ (instancetype)sharedInstance;

- (void)loadData;
- (City *)cityForCityCode:(NSString *)iata;

- (City *)cityForLocation:(CLLocation *)location;
@end
