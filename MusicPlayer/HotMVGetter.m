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
            
            /*
            NSArray *mainActor=[t2 componentsSeparatedByString:@"<main_actor>"];
            if([mainActor count]>1){
                t4=[mainActor objectAtIndex:1];
                NSArray *temp=[t4 componentsSeparatedByString:@"</main_actor>"];
                if([temp count]>0){
                    t4=[temp objectAtIndex:0];
                }
                
            }else{
                NSArray *actor=[t2 componentsSeparatedByString:@"<actor>"];
                if([actor count]>1){
                    t4=[actor objectAtIndex:1];
                    NSArray *temp=[t4 componentsSeparatedByString:@"</actor>"];
                    if([temp count]>0){
                        t4=[temp objectAtIndex:0];
                    }
                }
            }
             */
            information.information=t4;
            
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

@end
