//
//  APIManager.m
//  GBBeneskaiaAlena
//
//  Created by  Алёна Бенецкая on 08.02.2018.
//  Copyright © 2018  Алёна Бенецкая. All rights reserved.
//

#import "APIManager.h"
#import "Ticket.h"
#import "APIManager.m"
#import "DataManager.h"
#import "MapPrice.h"

#define API_MAIN_HOST       @"api.travelpayouts.com/v1/prices/cheap"
#define API_GET_IP          @"https://api.ipify.org/?format=json"
#define API_CITY_FOR_IP     @"https://www.travelpayouts.com/whereami?ip="
#define API_URL_MAP_PRICE   @"http://map.aviasales.ru/prices.json?origin_iata="


@interface APIManager ()
@property(nonatomic, strong) id apikey;
@end

@implementation APIManager {
    
}

+ (instancetype)sharedInstance {
    static APIManager *shared;
    static dispatch_once_t dispatchOperation;
    dispatch_once(&dispatchOperation, ^{
        shared = [[APIManager alloc] init];
        
        NSString *path = [NSBundle.mainBundle pathForResource:@"apikey"
                                                       ofType:@"plist"];
        NSDictionary *apiPlist = [NSDictionary dictionaryWithContentsOfFile:path];
        shared.apikey = apiPlist[@"apiToken"];
    });
    return shared;
}

- (void)cityForCurrentIP:(void (^)(City *city))completion {
    [self IPAddressWithCompletion:^(NSString *ipAddress) {
        NSString *urlString = [NSString stringWithFormat:@"%@%@", API_CITY_FOR_IP, ipAddress];
        [self loadWithURLString:urlString completion:^(id result) {
            NSDictionary *json = result;
            NSString *cityCode = [json valueForKey:@"iata"];
            if (!cityCode) return;
            City *city = [DataManager.sharedInstance cityForCityCode:cityCode];
            if (!city) return;
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(city);
            });
        }];
    }];
}

- (void)IPAddressWithCompletion:(void (^)(NSString *ipAddress))completion {
    [self loadWithURLString:API_GET_IP completion:^(id _Nullable result) {
        NSDictionary *json = result;
        NSLog(@"My ip address is: %@", [json valueForKey:@"ip"]);
        completion([json valueForKey:@"ip"]);
    }];
}

- (void)loadWithURLString:(NSString *)urlString completion:(void (^)(id _Nullable result))completion {
    NSURL *url = [[NSURL alloc] initWithString:urlString];
   
    dispatch_async(dispatch_get_main_queue(), ^{
        UIApplication.sharedApplication.networkActivityIndicatorVisible = YES;
    });
    
    [[NSURLSession.sharedSession
      dataTaskWithURL:url
      completionHandler:^(
              NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
          
          
          if (error) {
              NSLog(@"[%@ %@]: download error:%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), error);
              dispatch_async(dispatch_get_main_queue(), ^{
                  UIApplication.sharedApplication.networkActivityIndicatorVisible = NO;
              });
              return;
          } else if (data.length == 0) {
              NSLog(@"[%@ %@]: download error: server responded with empty data block",
                    NSStringFromClass(self.class), NSStringFromSelector(_cmd));
              dispatch_async(dispatch_get_main_queue(), ^{
                  UIApplication.sharedApplication.networkActivityIndicatorVisible = NO;
              });
              return;
          }
          
          completion([NSJSONSerialization JSONObjectWithData:data
                                                     options:NSJSONReadingMutableContainers
                                                       error:nil]);
      }] resume];
}

#pragma mark Tickets request

- (void)ticketsWithRequest:(SearchRequest)request withCompletion:(void (^)(NSArray *tickets))completion {
    
    NSString *urlString = [[[self urlForSearchRequest:request] absoluteString] stringByRemovingPercentEncoding];
    NSLog(@"Requset URL String is: %@", urlString);
    
    [self loadWithURLString:urlString completion:^(id result) {
        
        NSDictionary *json = [[(NSDictionary *) result valueForKey:@"data"] valueForKey:request.destination];
        if (!json) {
            NSLog(@"JSON object not found");
            return;
        }
        
        NSMutableArray *array = [NSMutableArray new];
        for (NSString *key in json) {
            NSDictionary *value = [json valueForKey:key];
            Ticket *ticket = [[Ticket alloc] initWithDictionary:value];
            ticket.from = request.origin;
            ticket.to = request.destination;
            [array addObject:ticket];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(array);
        });
    }];
    
}

- (NSURL *)urlForSearchRequest:(SearchRequest)request {
    NSURLComponents *components = [NSURLComponents new];
    components.scheme = @"https";
    components.host = API_MAIN_HOST;
    
    NSMutableArray *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *token = [[NSURLQueryItem alloc] initWithName:@"token" value:_apikey];
    [queryItems addObject:token];
    
    NSURLQueryItem *origin = [[NSURLQueryItem alloc] initWithName:@"origin" value:request.origin];
    [queryItems addObject:origin];
    
    NSURLQueryItem *destination = [[NSURLQueryItem alloc] initWithName:@"destination" value:request.destination];
    [queryItems addObject:destination];
    
    if (request.departDate && request.returnDate) {
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy-MM";
        
        NSString *departDateString = [dateFormatter stringFromDate:request.departDate];
        NSURLQueryItem *departDate = [[NSURLQueryItem alloc] initWithName:@"depart_date" value:departDateString];
        [queryItems addObject:departDate];
        
        NSString *returnDateString = [dateFormatter stringFromDate:request.returnDate];
        NSURLQueryItem *returnDate = [[NSURLQueryItem alloc] initWithName:@"return_date" value:returnDateString];
        [queryItems addObject:returnDate];
    }
    
    components.queryItems = queryItems;
    
    return [components URL];
}

- (NSURL *)urlWithAirlineLogoForIATACode:(NSString *)code {
    return [NSURL URLWithString:[NSString stringWithFormat:@ "https://pics.avs.io/200/200/%@.png", code]];
}

- (void)mapPricesFor:(City *)origin withCompletion:(void (^)(NSArray *prices))completion {
    NSLog(@"%@ %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
    static BOOL isLoading;
    if (isLoading) {return;}
    isLoading = YES;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", API_URL_MAP_PRICE, origin.code];
    [self loadWithURLString:urlString completion:^(id _Nullable result) {
        
        NSDictionary *dictionary = result;
        if ([result isKindOfClass:NSDictionary.class]) {
            if (dictionary[@"errors"]) {
                NSLog(@"Error received from server: %@", dictionary[@"errors"]);
                return;
            }
        }
        
        NSArray *array = result;
        NSMutableArray *prices = [NSMutableArray new];
        if (array) {
            for (NSDictionary *mapPriceDictionary in array) {
                MapPrice *mapPrice = [[MapPrice alloc] initWithDictionary:mapPriceDictionary withOrigin:origin];
                [prices addObject:mapPrice];
            }
            isLoading = NO;
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(prices);
            });
        }
    }];
}


@end

