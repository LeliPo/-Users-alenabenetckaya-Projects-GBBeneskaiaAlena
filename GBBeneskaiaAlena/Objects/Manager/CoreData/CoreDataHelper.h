//
//  CoreDataHelper.h
//  GBBeneskaiaAlena
//
//  Created by  Алёна Бенецкая on 22.02.2018.
//  Copyright © 2018  Алёна Бенецкая. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "DataManager.h"
#import "FavoriteTicket+CoreDataClass.h"
#import "Ticket.h"

@interface CoreDataHelper : NSObject
+ (instancetype)sharedInstance;
- (BOOL)isFavorite:(Ticket *)ticket;
- (NSArray *)favorites;
- (void)addToFavorite:(Ticket *)ticket;
- (void)removeFromFavorite:(Ticket *)ticket;
@end
