//  GBBeneskaiaAlena
//
//  Created by  Алёна Бенецкая on 08.02.2018.
//  Copyright © 2018  Алёна Бенецкая. All rights reserved.
//

#import "UILabel+Style.h"

@implementation UILabel (Style)

+ (instancetype)newWithFrame:(CGRect)frame usingTitle:(NSString *__nullable)title alignment:(NSTextAlignment)alignment {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:19];
    label.textColor = UIColor.blackColor;
    if (alignment) {
        label.textAlignment = alignment;
    } else {
        label.textAlignment = NSTextAlignmentCenter;
    }
    label.text = title;
    return label;
}

+ (instancetype)newWithFrame:(CGRect)frame usingTitle:(NSString *__nullable)title {
    return [UILabel newWithFrame:frame usingTitle:title alignment:(NSTextAlignmentCenter)];
}

@end
