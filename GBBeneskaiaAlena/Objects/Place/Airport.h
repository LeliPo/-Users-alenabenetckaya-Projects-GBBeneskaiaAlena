//
//  Airport.h
//  GBBeneskaiaAlena
//
//  Created by  Алёна Бенецкая on 03.02.2018.
//  Copyright © 2018  Алёна Бенецкая. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Airport : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *timezone;
@property (nonatomic, strong) NSDictionary *translations;
@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSString *cityCode;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, getter=isFlightable) BOOL flightable;
//@property (nonatomic) CLLocationCoordinate2D coordinate;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
