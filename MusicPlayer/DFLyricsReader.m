//
//  DFLyricsReader.m
//  MusicPlayer
//
//  Created by Bill on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DFLyricsReader.h"
#import "LyricsRow.h"

@implementation DFLyricsReader
@synthesize delegate;

-(void)readLyricsWithLyricsString:(NSString*)lyricsString{
    
    NSLog(@"%@",lyricsString);
    
    //读取歌词所附带的ti、ar、al、by信息
    NSString *title=[self getInf:@"ti" AndLyrics:lyricsString];
    NSString *artist=[self getInf:@"ar" AndLyrics:lyricsString];
    NSString *album=[self getInf:@"al" AndLyrics:lyricsString];
    NSString *from=[self getInf:@"by" AndLyrics:lyricsString];
    
    //附加信息读过来以后，把包含附加信息的内容从待处理的歌词中删去以免后面发生错误
    lyricsString=[lyricsString stringByReplacingOccurrencesOfString:title withString:@""];
    lyricsString=[lyricsString stringByReplacingOccurrencesOfString:artist withString:@""];
    lyricsString=[lyricsString stringByReplacingOccurrencesOfString:album withString:@""];
    lyricsString=[lyricsString stringByReplacingOccurrencesOfString:from withString:@""];
    
    
    //将歌词按每一行分隔到数组里面
    NSMutableArray *lyricsRows=[NSMutableArray arrayWithArray:[lyricsString componentsSeparatedByString:@"\n"]];
    
    //将分割后的歌词中的不是空行的内容存储到新的数组里面
    NSMutableArray *lyricsRowsToUse=[[NSMutableArray alloc] init];
    for(int i=0;i<[lyricsRows count];i++){
        NSString *nowAt=[lyricsRows objectAtIndex:i];
        if(!([nowAt isEqualToString:@"\r"]||[nowAt isEqualToString:@"\n"]||[nowAt isEqualToString:@""])){
            [lyricsRowsToUse addObject:[lyricsRows objectAtIndex:i]];
        }
    }
    
    //将待处理的歌词中的时间和内容分离开来，放到LyricsRow对象中，再把LyricsRow集合到一个数组里面
    NSMutableArray *complateLyrics=[[NSMutableArray alloc]init];
    for(int i=0;i<[lyricsRowsToUse count];i++){
        NSString *nowAt=[lyricsRowsToUse objectAtIndex:i];
        nowAt=[nowAt stringByReplacingOccurrencesOfString:@"[" withString:@""];
        NSArray *temp=[nowAt componentsSeparatedByString:@"]"];
        for(int i=0;i<[temp count]-1;i++){
            
            NSString *tTime=[temp objectAtIndex:i];
            //部分歌词会有t_time:(xx:xx)的标记导致程序出错，这里要处理掉
            if(![tTime rangeOfString:@"t_time"].length>0){
                LyricsRow *row=[[LyricsRow alloc]init];
                row.time=tTime;
                NSString *tContent=[temp objectAtIndex:[temp count]-1];
                tContent=[tContent stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                row.content=tContent;
                [complateLyrics addObject:[row autorelease]];
            }

        }
    }
    
    //为了显示的时候方便，把这堆歌词按时间排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES]];
    [complateLyrics sortUsingDescriptors:sortDescriptors];
    
    [lyricsRowsToUse release];
    
    if(delegate){
        [delegate readingFinishedWithLyrics:[complateLyrics autorelease]];
    }else{
        [complateLyrics autorelease];
        NSLog(@"Delegate is nil");
    }
}

-(NSString*)getInf:(NSString*)inf AndLyrics:(NSString*)lyrics{
    
    if([lyrics rangeOfString:inf].length>0){
    
        NSString *temp=[[lyrics componentsSeparatedByString:[NSString stringWithFormat:@"[%@:",inf]]objectAtIndex:1];
        temp=[[temp componentsSeparatedByString:@"]"] objectAtIndex:0];
        NSString *result=[NSString stringWithFormat:@"[%@:%@]",inf,temp];
        return result;
    }
    return @"";
}
@end
