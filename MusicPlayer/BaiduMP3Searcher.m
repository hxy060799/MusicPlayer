//
//  BaiduMP3Searcher.m
//  MusicPlayer
//
//  Created by Bill on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaiduMP3Searcher.h"

@implementation BaiduMP3Searcher
@synthesize delegate;

-(void)downloadFinishedWithResult:(NSString *)result Key:(NSString *)theKey{
    NSMutableArray *resultArray=[NSMutableArray array];
    NSArray *r=[result componentsSeparatedByString:@"<url>"];
    for(int i=1;i<[r count];i++){
        //音乐
        NSString *itemInformation=[r objectAtIndex:i];
        itemInformation=[[itemInformation componentsSeparatedByString:@"</url>"]objectAtIndex:0];
        //Encode URL
        NSString *encode=[[itemInformation componentsSeparatedByString:@"<encode><![CDATA["]objectAtIndex:1];
        encode=[[encode componentsSeparatedByString:@"]]></encode>"]objectAtIndex:0];
        //Decode URL
        NSString *decode=[[itemInformation componentsSeparatedByString:@"<decode><![CDATA["]objectAtIndex:1];
        decode=[[decode componentsSeparatedByString:@"]]></decode>"]objectAtIndex:0];
        
        NSArray *encodeTemp=[encode componentsSeparatedByString:@"/"];
        NSString *result=[NSString string];
        for(int i=0;i<encodeTemp.count-1;i++){
            result=[result stringByAppendingFormat:@"%@/",[encodeTemp objectAtIndex:i]];
        }
        result=[result stringByAppendingString:decode];
        [resultArray addObject:result];
    }
    if(delegate){
        [delegate searchFinishedWithResult:resultArray];
    }
    [self autorelease];
}

-(void)searchByString:(NSString *)theString{
    NSString *urlString=[NSString stringWithFormat:@"http://box.zhangmen.baidu.com/x?op=12&count=1&title=最炫名族风$$"];
    urlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; 
    
    DFDownloader *downloader=[[DFDownloader alloc]init];
    downloader.delegate=self;
    [downloader startDownloadWithURLString:urlString Key:@"MusicSearchXML"];
    [downloader release];
}

@end
