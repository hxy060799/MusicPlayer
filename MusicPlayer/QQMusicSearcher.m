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

@synthesize delegate;

-(void)searchMusicWithTitle:(NSString*)title Artist:(NSString*)artist{
    NSString *searchURL=[NSString stringWithFormat:@"http://shopcgi.qqmusic.qq.com/fcgi-bin/shopsearch.fcg?out=json&value=%@=qry_song&page_no=1&page_record_num=20&uin=0&artist=%@",title,artist];
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
        [self parseWithSearchResultRequest:request];
        
    }else if([[request.requestHeaders valueForKey:@"RequestType"] isEqualToString:@"getLyrics"]){
        [self parseWithLyricsGetRequest:request];
    }else if([[request.requestHeaders valueForKey:@"RequstType"] isEqualToString:@"getArtwork"]){
        NSData *responseData=[request responseData];
        UIImage *result=[[UIImage alloc] initWithData:responseData];
        NSLog(@"插图下载完成");
        [result autorelease];
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    NSError *error=[request error];
    NSLog(@"%@",error.description);
}

-(void)parseWithSearchResultRequest:(ASIHTTPRequest*)request{
    NSData *responseData=[request responseData];
    NSString *result=[[[NSString alloc] initWithData:responseData encoding:NSGB2312StringEncoding]autorelease];
    result=[self formatJsonWithJsonString:result];
    //NSLog(@"%@",result);
    
    NSMutableDictionary *jsonResult=[[CJSONDeserializer deserializer]deserialize:[result dataUsingEncoding:NSUTF8StringEncoding] error:nil];
    NSArray *songsArray=[jsonResult objectForKey:@"songlist"];
    
    NSMutableArray *resultArray=[NSMutableArray array];
    
    NSLog(@"SongsCount:%i",[songsArray count]);
    for(int i=0;i<[songsArray count];i++){
        NSDictionary *songDictrionary=[songsArray objectAtIndex:i];
        
        //发现返回的歌曲price属性如果是250就没有歌词
        if([[songDictrionary objectForKey:@"price"]intValue]!=250){
            NSMutableDictionary *songInformation=[[[NSMutableDictionary alloc]init]autorelease];
            [songInformation setObject:[songDictrionary objectForKey:@"song_name"] forKey:@"songName"];
            [songInformation setObject:[songDictrionary objectForKey:@"singer_name"] forKey:@"songArtist"];
            [songInformation setObject:[songDictrionary objectForKey:@"album_name"] forKey:@"songAlbum"];
            //[songInformation setObject:[songDictrionary objectForKey:@"price"] forKey:@"songPrice"];
            [songInformation setObject:[songDictrionary objectForKey:@"song_id"] forKey:@"songID"];
            
            //NSLog(@"%@",songDictrionary);
            
            [resultArray addObject:songInformation];
        }
        
    }
    if(self.delegate){
        [delegate searchFinishedWithResult:resultArray];
    }
}

-(void)parseWithLyricsGetRequest:(ASIHTTPRequest *)request{
    NSData *responseData=[request responseData];
    NSString *result=[[[NSString alloc] initWithData:responseData encoding:NSGB2312StringEncoding]autorelease];
    
    result=[[result componentsSeparatedByString:@"<![CDATA["]objectAtIndex:1];
    result=[[result componentsSeparatedByString:@"]]>"]objectAtIndex:0];
    
    if(delegate){
        [delegate getLyricsFinishedWithResult:result];
    }
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

+(NSInteger)chooseLyricsWithLyricsResult:(NSMutableArray *)result Artist:(NSString *)artist{
    if([result count]>0){
        for(NSDictionary *songInformation in result){
            NSString *songArtist=[songInformation valueForKey:@"songArtist"];
            NSInteger songID=[[songInformation valueForKey:@"songID"]intValue];
            NSLog(@"%@",[songInformation valueForKey:@"songName"]);
            NSLog(@"%@",songArtist);
            NSLog(@"%i",songID);
            if([songArtist rangeOfString:artist].length>0){
                return songID;
            }
        }
        return [[[result objectAtIndex:0]valueForKey:@"songID"]intValue];
    }
    return 0;
}

@end
