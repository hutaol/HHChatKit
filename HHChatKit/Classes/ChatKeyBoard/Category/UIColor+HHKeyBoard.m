//
//  UIColor+HHKeyBoard.m
//  YYT
//
//  Created by Henry on 2020/8/7.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import "UIColor+HHKeyBoard.h"

CGFloat hh_colorComponentFrom(NSString *string, NSUInteger start, NSUInteger length) {
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}


@implementation UIColor (HHKeyBoard)

+ (UIColor *)hh_colorWithString:(NSString *)string {
    if (string == nil || string.length == 0) {
        return nil;
    }
    
    if ([string hasPrefix:@"rgb("] && [string hasSuffix:@")"]) {
        string = [string substringWithRange:NSMakeRange(4, string.length - 5)];
        if (string && string.length) {
            NSArray *elems = [string componentsSeparatedByString:@","];
            if (elems && elems.count == 3) {
                NSInteger r = [[elems objectAtIndex:0] integerValue];
                NSInteger g = [[elems objectAtIndex:1] integerValue];
                NSInteger b = [[elems objectAtIndex:2] integerValue];
                return [UIColor colorWithRed:(r * 1.0f / 255.0f) green:(g * 1.0f / 255.0f) blue:(b * 1.0f / 255.0f) alpha:1.0f];
            }

        }
    }
    
    if ([string hasPrefix:@"#"]) {
        CGFloat alpha, red, blue, green;

        NSString *colorString = [[string stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
        colorString = [[colorString stringByReplacingOccurrencesOfString:@"0x" withString:@""] uppercaseString];
        colorString = [[colorString stringByReplacingOccurrencesOfString:@"0X" withString:@""] uppercaseString];

        switch ([colorString length]) {
            case 3: // #RGB
                alpha = 1.0f;
                red   = hh_colorComponentFrom(colorString, 0, 1);
                green = hh_colorComponentFrom(colorString, 1, 1);
                blue  = hh_colorComponentFrom(colorString, 2, 1);
                break;
                
            case 4: // #ARGB
                alpha = hh_colorComponentFrom(colorString, 0, 1);
                red   = hh_colorComponentFrom(colorString, 1, 1);
                green = hh_colorComponentFrom(colorString, 2, 1);
                blue  = hh_colorComponentFrom(colorString, 3, 1);
                break;
                
            case 6: // #RRGGBB
                alpha = 1.0f;
                red   = hh_colorComponentFrom(colorString, 0, 2);
                green = hh_colorComponentFrom(colorString, 2, 2);
                blue  = hh_colorComponentFrom(colorString, 4, 2);
                break;
                
            case 8: // #AARRGGBB
                alpha = hh_colorComponentFrom(colorString, 0, 2);
                red   = hh_colorComponentFrom(colorString, 2, 2);
                green = hh_colorComponentFrom(colorString, 4, 2);
                blue  = hh_colorComponentFrom(colorString, 6, 2);
                break;
                
            default:
                return nil;
        }
        return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    }
    
    return nil;
}

@end
