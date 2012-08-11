//
//  DFDownloader.m
//  MusicPlayer
//
//  Created by Bill on 12-7-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DFDownloader.h"

@implementation DFDownloader

@synthesize receivedData;
@synthesize downloadConnection;
@synthesize key;
@synthesize delegate;

-(id)init{
    if(self=[super init]){
        
    }
    return self;
}

-(void)dealloc{
    [super dealloc];
}

-(void)startDownloadWithURLString:(NSString *)urlString Key:(NSString*)theKey{
    if(self.downloadConnection==nil){
        self.receivedData=[NSMutableData data];
        self.key=[NSString stringWithString:theKey];
        
        
        NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] delegate:self];
        self.downloadConnection=connection;
        [connection release];
    
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
}

-(void)cancelDownload{
    [self.downloadConnection cancel];
    self.downloadConnection=nil;
    self.receivedData=nil;
    self.key=nil;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    self.receivedData=nil;
    self.downloadConnection=nil;
    self.key=nil;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSLog(@"%@",[error description]);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *string=[[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding];
    

    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
    
    //NSLog(@"%@",string);
    if(self.delegate){
        [delegate downloadFinishedWithResult:[string autorelease] Key:key];
    }else {
        NSLog(@"Nil");
        [string autorelease];
    }
    
    self.receivedData=nil;
    self.downloadConnection=nil;
    self.key=nil;
}

@end
