//
//  GBBeneskaiaAlena
//
//  Created by  Алёна Бенецкая on 08.02.2018.
//  Copyright © 2018  Алёна Бенецкая. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UILabel (Style)

+ (instancetype _Nonnull)newWithFrame:(CGRect)frame usingTitle:(NSString *__nullable)title alignment:(NSTextAlignment)alignment;

+ (instancetype _Nonnull)newWithFrame:(CGRect)frame usingTitle:(NSString *__nullable)title;

@end
