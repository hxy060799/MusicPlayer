//
//  POAPinyin.h
//  POA
//
//  Created by haung he on 11-7-18.
//  Copyright 2011年 huanghe. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface POAPinyin : NSObject {
    
}

+ (NSString*) convert:(NSString *) hzString WithFirstLetter:(NSString*)firstLetter;

//  added by setimouse ( setimouse@gmail.com )
+ (NSString *)quickConvert:(NSString *)hzString;
+ (void)clearCache;
//  ------------------

@end
