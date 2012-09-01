//
//  QQMusicSearcher.m
//  MusicPlayer
//
//  Created by Bill on 12-8-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QQMusicSearcher.h"
#import "CJSONDeserializer.h"

@implementation QQMusicSearcher

-(void)searchMusicWithTitle:(NSString*)title Artist:(NSString*)artist{
    NSString *searchURL=[NSString stringWithFormat:@"http://shopcgi.qqmusic.qq.com/fcgi-bin/shopsearch.fcg?out=json&value=%@=qry_song&page_no=1&page_record_num=10&uin=0&artist=%@",title,artist];
    searchURL=[searchURL stringByAddingPercentEscapesUsingEncoding:NSGB2312StringEncoding];
    
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:searchURL]];
    request.delegate=self;
    [request addRequestHeader:@"RequestType" value:@"search"];
    [request startAsynchronous];
}

-(void)getLyricsWithMusicID:(NSInteger)songID{
    NSString *lyricsURL=[NSString stringWithFormat:@"http://music.qq.com/miniportal/static/lyric/%i/%i.xml",songID%100,songID];
    
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:lyricsURL]];
    request.delegate=self;
    [request addRequestHeader:@"RequestType" value:@"getLyrics"];
    [request startAsynchronous];
}

-(void)getAlbumArtworkWithMusicId:(NSInteger)songID{
    NSString *albumArtworkURL=[NSString stringWithFormat:@"http://imgcache.qq.com/music/photo/album/%i/albumpic_%i_0.jpg",songID%100,songID];
    
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:albumArtworkURL]];
    request.delegate=self;
    [request addRequestHeader:@"RequestType" value:@"getAlbumArtwork"];
    [request startAsynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    if([[request.requestHeaders valueForKey:@"RequestType"] isEqualToString:@"search"]){
        NSData *responseData=[request responseData];
        NSString *result=[[[NSString alloc] initWithData:responseData encoding:NSGB2312StringEncoding]autorelease];
        result=[self formatJsonWithJsonString:result];
        
        NSMutableDictionary *jsonResult=[[CJSONDeserializer deserializer]deserialize:[result dataUsingEncoding:NSUTF8StringEncoding] error:nil];
        NSArray *songsArray=[jsonResult objectForKey:@"songlist"];
        
        NSLog(@"SongsCount:%i",[songsArray count]);
        for(int i=0;i<[songsArray count];i++){
            NSLog(@"-----------------");
            NSDictionary *songDictrionary=[songsArray objectAtIndex:i];
            NSLog(@"SongName:%@",[songDictrionary objectForKey:@"song_name"]);
            NSLog(@"SingerName:%@",[songDictrionary objectForKey:@"singer_name"]);
            NSLog(@"AlbumName:%@",[songDictrionary objectForKey:@"album_name"]);
        }
        
    }else if([[request.requestHeaders valueForKey:@"RequestType"] isEqualToString:@"getLyrics"]){
        NSData *responseData=[request responseData];
        NSString *result=[[NSString alloc] initWithData:responseData encoding:NSGB2312StringEncoding];
        NSLog(@"%@",result);
        //[result autorelease];
    }else if([[request.requestHeaders valueForKey:@"RequstType"] isEqualToString:@"getArtwork"]){
        NSData *responseData=[request responseData];
        UIImage *result=[[UIImage alloc] initWithData:responseData];
        NSLog(@"插图下载完成");
        //[result autorelease];
    }
    [self autorelease];
}
                                          
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSError *error=[request error];
    NSLog(@"%@",error.description);
}

-(NSString*)formatJsonWithJsonString:(NSString *)jsonString{
    jsonString=[jsonString stringByReplacingOccurrencesOfString:@"JsonCallback(" withString:@""];
    jsonString=[jsonString stringByReplacingOccurrencesOfString:@"searchCallBack(" withString:@""];
    jsonString=[[jsonString componentsSeparatedByString:@"\n"] objectAtIndex:0];
    jsonString=[jsonString substringToIndex:jsonString.length-1];
    jsonString=[jsonString stringByReplacingOccurrencesOfString:@"{" withString:@"{\""];
    jsonString=[jsonString stringByReplacingOccurrencesOfString:@"\"," withString:@"\",\""];
    jsonString=[jsonString stringByReplacingOccurrencesOfString:@":\"" withString:@"\":\""];
    jsonString=[jsonString stringByReplacingOccurrencesOfString:@":[" withString:@"\":["];
    return jsonString;
}

@end
