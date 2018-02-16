//
//  APIManager.h
//  GBBeneskaiaAlena
//
//  Created by  Алёна Бенецкая on 08.02.2018.
//  Copyright © 2018  Алёна Бенецкая. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManager.h"
#import "SearchRequest.h"

@interface APIManager : NSObject

+ (instancetype)sharedInstance;

- (void)cityForCurrentIP:(void (^)(City *city))completion;

- (void)ticketsWithRequest:(SearchRequest)request withCompletion:(void (^)(NSArray *tickets))completion;

- (NSURL *)urlWithAirlineLogoForIATACode:(NSString *)code;
@end



