//
//  NSDate+HHChat.m
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "NSDate+HHChat.h"

@implementation NSDate (HHChat)

- (NSString *)shortTimeMessageString {
    
    NSCalendar *calendar = [ NSCalendar currentCalendar ];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear ;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[ NSDate date ]];
    NSDateComponents *myCmps = [calendar components:unit fromDate:self];
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc ] init ];

    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:self];

    if (nowCmps.year != myCmps.year) {
        dateFmt.dateFormat = @"yy-M-d";
    } else {
        if (nowCmps.day == myCmps.day) {
            dateFmt.dateFormat = @"a HH:mm";
            dateFmt.AMSymbol = @"上午";
            dateFmt.PMSymbol = @"下午";
        } else if ((nowCmps.day-myCmps.day) == 1) {
            dateFmt.dateFormat = @"昨天 HH:mm";
        } else if ((nowCmps.day-myCmps.day) == 2) {
            dateFmt.dateFormat = @"前天 HH:mm";

        } else {
            
            dateFmt.dateFormat = @"M-d";

//            if ((nowCmps.day-myCmps.day) <=7) {
//                switch (comp.weekday) {
//                    case 1:
//                        dateFmt.dateFormat = @"星期日";
//                        break;
//                    case 2:
//                        dateFmt.dateFormat = @"星期一";
//                        break;
//                    case 3:
//                        dateFmt.dateFormat = @"星期二";
//                        break;
//                    case 4:
//                        dateFmt.dateFormat = @"星期三";
//                        break;
//                    case 5:
//                        dateFmt.dateFormat = @"星期四";
//                        break;
//                    case 6:
//                        dateFmt.dateFormat = @"星期五";
//                        break;
//                    case 7:
//                        dateFmt.dateFormat = @"星期六";
//                        break;
//                    default:
//                        break;
//                }
//            } else {
//                dateFmt.dateFormat = @"yyyy-MM-dd";
//            }
        }
    }
    return [dateFmt stringFromDate:self];
}

- (NSString *)timeMessageString {
    NSCalendar *calendar = [ NSCalendar currentCalendar ];
        int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear ;
        NSDateComponents *nowCmps = [calendar components:unit fromDate:[ NSDate date ]];
        NSDateComponents *myCmps = [calendar components:unit fromDate:self];
        NSDateFormatter *dateFmt = [[NSDateFormatter alloc ] init ];

        NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:self];

        if (nowCmps.year != myCmps.year) {
            dateFmt.dateFormat = @"yyyy-MM-dd HH:mm";
        } else {
            if (nowCmps.day == myCmps.day) {
                dateFmt.dateFormat = @"HH:mm";
            } else if ((nowCmps.day-myCmps.day) == 1) {
                dateFmt.dateFormat = @"昨天 HH:mm";
            } else if ((nowCmps.day-myCmps.day) == 2) {
                dateFmt.dateFormat = @"前天 HH:mm";

            } else {
                
                dateFmt.dateFormat = @"MM-dd HH:mm";

    //            if ((nowCmps.day-myCmps.day) <=7) {
    //                switch (comp.weekday) {
    //                    case 1:
    //                        dateFmt.dateFormat = @"星期日";
    //                        break;
    //                    case 2:
    //                        dateFmt.dateFormat = @"星期一";
    //                        break;
    //                    case 3:
    //                        dateFmt.dateFormat = @"星期二";
    //                        break;
    //                    case 4:
    //                        dateFmt.dateFormat = @"星期三";
    //                        break;
    //                    case 5:
    //                        dateFmt.dateFormat = @"星期四";
    //                        break;
    //                    case 6:
    //                        dateFmt.dateFormat = @"星期五";
    //                        break;
    //                    case 7:
    //                        dateFmt.dateFormat = @"星期六";
    //                        break;
    //                    default:
    //                        break;
    //                }
    //            } else {
    //                dateFmt.dateFormat = @"yyyy-MM-dd";
    //            }
            }
        }
        return [dateFmt stringFromDate:self];
}

+ (NSDate *)dateForTimestamp:(NSString *)timestamp {
    long long tt = [timestamp longLongValue];

    if (timestamp.length == 13) {
        tt = tt / 1000;
    }
    
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:tt]; // 毫秒 /1000
    return timeDate;
}

+ (NSString *)timestamp:(NSDate *)date {
    if (!date) {
        date = [NSDate date];
    }
    NSTimeInterval time = [date timeIntervalSince1970]; // *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

@end
