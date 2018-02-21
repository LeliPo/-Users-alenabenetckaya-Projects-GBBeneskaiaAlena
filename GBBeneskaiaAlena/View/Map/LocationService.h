//
//  GBBeneskaiaAlena
//
//  Created by  Алёна Бенецкая on 08.02.2018.
//  Copyright © 2018  Алёна Бенецкая. All rights reserved.
//


#import <CoreLocation/CoreLocation.h>
#define kLocationServiceDidUpdateCurrentLocation @"LocationServiceDidUpdateCurrentLocation"

@interface LocationService : NSObject
- (void)cityNameForLocation:(CLLocation *)location completeWithName:(void (^)(NSString *))completion;
@end
