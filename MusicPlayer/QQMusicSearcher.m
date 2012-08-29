//
//  QQMusicSearcher.m
//  MusicPlayer
//
//  Created by Bill on 12-8-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QQMusicSearcher.h"

@implementation QQMusicSearcher

-(void)searchMusicWithTitle:(NSString*)title Artist:(NSString*)artist{
    NSString *searchURL=[NSString stringWithFormat:@"http://shopcgi.qqmusic.qq.com/fcgi-bin/shopsearch.fcg?out=xml&value=%@=qry_song&page_no=1&page_record_num=10&uin=0&artist=%@",title,artist];
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
        NSString *result=[[NSString alloc] initWithData:responseData encoding:NSGB2312StringEncoding];
        NSLog(@"%@",result);
        [result autorelease];
    }else if([[request.requestHeaders valueForKey:@"RequestType"] isEqualToString:@"getLyrics"]){
        NSData *responseData=[request responseData];
        NSString *result=[[NSString alloc] initWithData:responseData encoding:NSGB2312StringEncoding];
        NSLog(@"%@",result);
        [result autorelease];
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

@end
