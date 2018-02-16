//  GBBeneskaiaAlena
//
//  Created by  Алёна Бенецкая on 08.02.2018.
//  Copyright © 2018  Алёна Бенецкая. All rights reserved.
//

#import "UIView+GetController.h"

@implementation UIView (GetController)

- (UIViewController *)getViewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isMemberOfClass:[UIViewController class]]) {
            return (UIViewController *) nextResponder;
        }
    }
    return nil;
}

@end
