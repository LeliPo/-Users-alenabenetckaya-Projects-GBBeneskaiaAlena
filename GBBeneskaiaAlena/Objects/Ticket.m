//
//  Ticket.m
//  GBBeneskaiaAlena
//
//  Created by  Алёна Бенецкая on 08.02.2018.
//  Copyright © 2018  Алёна Бенецкая. All rights reserved.
//

#import "Ticket.h"
#import "NSDate+FromISOString.h"

@implementation Ticket {
    
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _airline = dictionary[@"airline"];
        _expires = [[NSDate alloc] initWithISOString:dictionary[@"expires_at"]];
        _departure = [[NSDate alloc] initWithISOString:dictionary[@"departure_at"]];
        _flightNumber = [dictionary valueForKey:@"flight_number"];
        _price = [dictionary valueForKey:@"price"];
        _returnDate = [[NSDate alloc] initWithISOString:dictionary[@"return_at"]];
    }
    return self;
}


@end
