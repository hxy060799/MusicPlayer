//
//  HotMVGetter.m
//  MusicPlayer
//
//  Created by Bill on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotMVGetter.h"
#import "MVInformation.h"

@implementation HotMVGetter
@synthesize delegate;

-(void)getHotMVWithPage:(int)page{
    NSString *urlString=[NSString stringWithFormat:@"http://api.tudou.com/v3/gw?method=item.ranking&format=xml&appKey=1952e9844c5283d5&pageNo=%i&pageSize=20&channelId=14&sort=v",page];
    
    DFDownloader *downloader=[[DFDownloader alloc]init];
    downloader.delegate=self;
    [downloader startDownloadWithURLString:urlString Key:@"hotMVXML"];
    [downloader release];
}

-(void)downloadFinishedWithResult:(NSString *)result Key:(NSString *)theKey{
    NSMutableArray *resultArray=[NSMutableArray array];
    NSArray *r=[result componentsSeparatedByString:@"<ItemInfo>"];
    for(int i=1;i<[r count];i++){
        MVInformation *information=[[MVInformation alloc]init];
        //视频信息
        NSString *itemInformation=[r objectAtIndex:i];
        itemInformation=[[itemInformation componentsSeparatedByString:@"</ItemInfo>"]objectAtIndex:0];
        //视频标题
        NSString *title=[[itemInformation componentsSeparatedByString:@"<title>"]objectAtIndex:1];
        title=[[title componentsSeparatedByString:@"</title>"]objectAtIndex:0];
        information.title=title;
        //视频描述
        NSString *description=nil;
        description=[[itemInformation componentsSeparatedByString:@"<description>"]objectAtIndex:1];
        description=[[description componentsSeparatedByString:@"</description>"]objectAtIndex:0];
        description=[description stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if(!description||[description isEqualToString:@""]){
            description=@"没有描述";
        }else{
            description=[NSString stringWithFormat:@"    %@",description];
        }
        information.information=description;
        //图片URL
        NSString *picURL=[[itemInformation componentsSeparatedByString:@"<picUrl>"]objectAtIndex:1];
        picURL=[[picURL componentsSeparatedByString:@"</picUrl>"]objectAtIndex:0];
        //UIImage图片
        NSURL *picDownloadURL=[[NSURL alloc]initWithString:picURL];
        NSData *imageData=[[NSData alloc] initWithContentsOfURL:picDownloadURL];
        UIImage *horBigPic=[UIImage imageWithData:imageData];
        [picDownloadURL release];
        [imageData release];
        information.picture=horBigPic;
        //播放URL
        //土豆视频的m3u8播放URL要从图片URL中提取
        NSArray *playURLArray=[picURL componentsSeparatedByString:@"/"];
        NSString *playURl=[NSString string];
        for(int i=3;i<[playURLArray count]-1;i++){
            playURl=[playURl stringByAppendingFormat:@"%@/",[playURLArray objectAtIndex:i]];
        }
        playURl=[NSString stringWithFormat:@"http://m3u8.tdimg.com/%@2.m3u8",playURl];
        information.playURL=playURl;
        //储存结果
        [resultArray addObject:[information autorelease]];
    }
    
    if(delegate){
        [delegate downloadFinishedWithResult:resultArray];
    }
}


-(NSMutableArray*)searchByString:(NSString *)theString{
    NSMutableArray *resultArray=[NSMutableArray array];
    
    NSString *urlString=[NSString stringWithFormat:@"http://api.tudou.com/v3/gw?method=item.search&appKey=1952e9844c5283d5&format=xml&kw=%@&pageNo=1&pageSize=20&channelId=14&sort=v",theString];
    urlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlString];
    NSString *result=[[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    //NSLog(@"%@",result);
    
    NSArray *r=[result componentsSeparatedByString:@"<ItemInfo>"];
    
    for(int i=1;i<[r count];i++){
        
        MVInformation *information=[[MVInformation alloc]init];
        
        NSString *t2=[r objectAtIndex:i];
        t2=[[t2 componentsSeparatedByString:@"</ItemInfo>"]objectAtIndex:0];
        //NSLog(@"%@",t2);
        
        NSString *t3=[[t2 componentsSeparatedByString:@"<title>"]objectAtIndex:1];
        t3=[[t3 componentsSeparatedByString:@"</title>"]objectAtIndex:0];
        information.title=t3;
        
        NSString *t4=nil;
        t4=[[t2 componentsSeparatedByString:@"<description>"]objectAtIndex:1];
        t4=[[t4 componentsSeparatedByString:@"</description>"]objectAtIndex:0];
        
        t4=[t4 stringByReplacingOccurrencesOfString:@"&#" withString:@""];
        t4=[t4 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        t4=[t4 stringByReplacingOccurrencesOfString:@"&lt" withString:@""];
        t4=[t4 stringByReplacingOccurrencesOfString:@"&gt" withString:@""];
        t4=[t4 stringByReplacingOccurrencesOfString:@"x0D" withString:@""];
        t4=[t4 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if(t4==nil||[t4 isEqualToString:@""]){
            t4=@"暂无相关介绍";
        }else{
            t4=[t4 stringByReplacingOccurrencesOfString:@"  " withString:@""];
        }
        
        //NSLog(@"%@",t4);
        
        information.information=t4;
        
        NSString *t5=[[t2 componentsSeparatedByString:@"<picUrl>"]objectAtIndex:1];
        t5=[[t5 componentsSeparatedByString:@"</picUrl>"]objectAtIndex:0];
        //NSLog(@"%@",t5);
        if(![t5 isEqualToString:@""]){
            NSURL *picDownloadURL=[[NSURL alloc]initWithString:t5];
            UIImage *horBigPic=[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:picDownloadURL]];
            [picDownloadURL release];
            
            information.picture=[horBigPic autorelease];

        }
        
        
        NSArray *t6Array=[t5 componentsSeparatedByString:@"/"];
        NSString *t6=[NSString string];
        for(int i=3;i<[t6Array count]-1;i++){
            t6=[t6 stringByAppendingFormat:@"%@/",[t6Array objectAtIndex:i]];
        }
        
        t6=[NSString stringWithFormat:@"http://m3u8.tdimg.com/%@2.m3u8",t6];
        information.playURL=t6;
        
        [resultArray addObject:[information autorelease]];
    }
    
    [result release];
    
     for(int i=0;i<[resultArray count];i++){
     MVInformation *information=[resultArray objectAtIndex:i];
     NSLog(@"%@-%@",information.title,information.information);
     }
     return resultArray;
}

@end
