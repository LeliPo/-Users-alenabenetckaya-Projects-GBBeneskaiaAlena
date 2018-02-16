//
//  Country.m
//  GBBeneskaiaAlena
//
//  Created by  Алёна Бенецкая on 03.02.2018.
//  Copyright © 2018  Алёна Бенецкая. All rights reserved.
//

#import "Country.h"

@implementation Country

- (instancetype) initWithDictionary:(NSDictionary*)dictionary
{
    self  = [super init];
    if (self)  {
        _currency  = [dictionary  valueForKey: @"currency"];
        _translations  = [dictionary  valueForKey:@"name_translations"];
        _name  = [dictionary  valueForKey: @"name"];
        _code  = [dictionary  valueForKey: @"code"];
    }
    return self;
    
}
@end
