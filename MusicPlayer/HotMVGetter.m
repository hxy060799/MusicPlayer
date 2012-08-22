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

-(NSMutableArray*)getHotMV{
    NSMutableArray *resultArray=[NSMutableArray array];
    
    NSString *urlString=@"http://api.tv.sohu.com/music/top50/views/weekly.xml?api_key=258715608945d9f401d8607e181dc7c3";
    NSURL *url=[NSURL URLWithString:urlString];
    NSString *result=[[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    //NSLog(@"%@",result);
    
    NSString *t1=[[result componentsSeparatedByString:@"<status>"] objectAtIndex:1];
    t1=[[t1 componentsSeparatedByString:@"</status>"] objectAtIndex:0];
    NSLog(@"%@",t1);
    
    if([t1 isEqualToString:@"200"]){
        
        NSArray *r=[result componentsSeparatedByString:@"<item><MODERATOR/>"];
        
        for(int i=1;i<[r count];i++){
            
            MVInformation *information=[[MVInformation alloc]init];
            
            NSString *t2=[r objectAtIndex:i];
            t2=[[t2 componentsSeparatedByString:@"</voters></item>"]objectAtIndex:0];
            //NSLog(@"%@",t2);
            
            NSString *t3=[[t2 componentsSeparatedByString:@"<tv_name>"]objectAtIndex:1];
            t3=[[t3 componentsSeparatedByString:@"</tv_name>"]objectAtIndex:0];
            information.title=t3;
            
            NSString *t4=[NSString string];
            t4=[[t2 componentsSeparatedByString:@"<tv_desc>"]objectAtIndex:1];
            t4=[[t4 componentsSeparatedByString:@"</tv_desc>"]objectAtIndex:0];
            
            t4=[t4 stringByReplacingOccurrencesOfString:@"&#" withString:@""];
            t4=[t4 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            t4=[t4 stringByReplacingOccurrencesOfString:@"&lt" withString:@""];
            t4=[t4 stringByReplacingOccurrencesOfString:@"&gt" withString:@""];
            t4=[t4 stringByReplacingOccurrencesOfString:@"x0D" withString:@""];
            t4=[t4 stringByReplacingOccurrencesOfString:@"  " withString:@""];
            t4=[NSString stringWithFormat:@"    %@",t4];
            information.information=t4;
            
            NSString *t5=[[t2 componentsSeparatedByString:@"<tv_big_pic>"]objectAtIndex:1];
            t5=[[t5 componentsSeparatedByString:@"</tv_big_pic>"]objectAtIndex:0];
            if(![t5 isEqualToString:@""]){
                UIImage *horBigPic=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:t5]]];
                information.picture=horBigPic;
            }
            
            NSString *t6=[[t2 componentsSeparatedByString:@"<vid>"]objectAtIndex:1];
            t6=[[t6 componentsSeparatedByString:@"</vid>"]objectAtIndex:0];
            NSString *theUrl=[NSString stringWithFormat:@"http://share.vrs.sohu.com/%@/v.m3u8&api_key=258715608945d9f401d8607e181dc7c3",t6];
            information.playURL=theUrl;
            
            
            [resultArray addObject:[information autorelease]];
        }
    }
    
    [result release];
    
    /*
    for(int i=0;i<[resultArray count];i++){
        MVInformation *information=[resultArray objectAtIndex:i];
        NSLog(@"%@-%@",information.title,information.information);
    }
    */
    return resultArray;
    
}

-(NSMutableArray*)searchByString:(NSString *)theString{
    NSMutableArray *resultArray=[NSMutableArray array];
    
    NSString *urlString=[NSString stringWithFormat:@"http://api.tv.sohu.com/search.xml?key=%@&page=1&pageSize=10&api_key=258715608945d9f401d8607e181dc7c3&c=24&tvType=-2&o=1",theString];
    urlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; 
    NSURL *url=[NSURL URLWithString:urlString];
    NSString *result=[[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    //NSLog(@"%@",result);
    
    NSString *t1=[[result componentsSeparatedByString:@"<status>"] objectAtIndex:1];
    t1=[[t1 componentsSeparatedByString:@"</status>"] objectAtIndex:0];
    NSLog(@"%@",t1);
    
    NSArray *r=[result componentsSeparatedByString:@"<item>"];
    for(int i=1;i<[r count];i++){
        
        MVInformation *information=[[MVInformation alloc]init];
        
        NSString *t2=[r objectAtIndex:i];
        t2=[[t2 componentsSeparatedByString:@"</item>"]objectAtIndex:0];
        //NSLog(@"%@",t2);
        
        NSString *t3=[[t2 componentsSeparatedByString:@"<tv_name>"]objectAtIndex:1];
        t3=[[t3 componentsSeparatedByString:@"</tv_name>"]objectAtIndex:0];
        information.title=t3;
        
        NSString *t4=[NSString string];
        t4=[[t2 componentsSeparatedByString:@"<tv_desc>"]objectAtIndex:1];
        t4=[[t4 componentsSeparatedByString:@"</tv_desc>"]objectAtIndex:0];
        
        t4=[t4 stringByReplacingOccurrencesOfString:@"&#" withString:@""];
        t4=[t4 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        t4=[t4 stringByReplacingOccurrencesOfString:@"&lt" withString:@""];
        t4=[t4 stringByReplacingOccurrencesOfString:@"&gt" withString:@""];
        t4=[t4 stringByReplacingOccurrencesOfString:@"x0D" withString:@""];
        t4=[t4 stringByReplacingOccurrencesOfString:@"  " withString:@""];
        t4=[NSString stringWithFormat:@"    %@",t4];
        information.information=t4;
        /*
        NSString *t5=[[t2 componentsSeparatedByString:@"<tv_big_pic>"]objectAtIndex:1];
        t5=[[t5 componentsSeparatedByString:@"</tv_big_pic>"]objectAtIndex:0];
        if(![t5 isEqualToString:@""]){
            UIImage *horBigPic=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:t5]]];
            information.picture=horBigPic;
        }
        */
        NSString *t6=[[t2 componentsSeparatedByString:@"<vid>"]objectAtIndex:1];
        t6=[[t6 componentsSeparatedByString:@"</vid>"]objectAtIndex:0];
        NSString *theUrl=[NSString stringWithFormat:@"http://share.vrs.sohu.com/%@/v.m3u8&api_key=258715608945d9f401d8607e181dc7c3",t6];
        information.playURL=theUrl;
        
        
        [resultArray addObject:[information autorelease]];
    }
    
    [result release];
    
    /*
     for(int i=0;i<[resultArray count];i++){
     MVInformation *information=[resultArray objectAtIndex:i];
     NSLog(@"%@-%@",information.title,information.information);
     }
     */
    return resultArray;
}

@end
