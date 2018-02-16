//
//  Country.h
//  GBBeneskaiaAlena
//
//  Created by  Алёна Бенецкая on 03.02.2018.
//  Copyright © 2018  Алёна Бенецкая. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Country : NSObject

@property (nonatomic, strong) NSString*name;
@property (nonatomic, strong) NSString*currency;
@property (nonatomic, strong) NSDictionary*translations;
@property (nonatomic, strong) NSString*code;
- (instancetype) initWithDictionary:( NSDictionary*)dictionary;
@end
