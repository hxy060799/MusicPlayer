//
//  DFQianQianLyricsDownloader.m
//  MusicPlayer
//
//  Created by Bill on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DFQianQianLyricsDownloader.h"

@implementation DFQianQianLyricsDownloader

@synthesize delegate;

-(id)init{
    if(self=[super init]){
        artistToUse=[NSString string];
        titleToUse=[NSString string];
    }
    return self;
}

-(void)downLoadLyricsByArtist:(NSString*)theArtist AndTitle:(NSString*)theTitle{
    NSString *urlS=[NSString stringWithFormat:@"http://ttlrccnc.qianqian.com/dll/lyricsvr.dll?sh?Artist=%@&Title=%@&Flags=0",[self stringToUnicode:theArtist],[self stringToUnicode:theTitle]];
    
    
    
    artistToUse=[NSString stringWithString:artistToUse];
    titleToUse=[NSString stringWithString:artistToUse];
    
    NSLog(@"%@",artistToUse);
    
    DFDownloader *downloader=[[DFDownloader alloc]init];
    downloader.delegate=self;
    [downloader startDownloadWithURLString:urlS Key:@"Search" Encoding:NSUTF8StringEncoding];
    //[downloader autrelease];
}

-(void)searchFinishedWithResult:(NSString*)result{
    NSLog(@"%@",artistToUse);

    NSArray *tempArray = [result componentsSeparatedByString:@"<lrc"];
    
    NSString *lrcID=[NSString string],*firstId=[NSString string];
    NSString *finalArtist=[NSString string],*firstArtist=[NSString string];
    NSString *finalTitle=[NSString string],*firstTitle=[NSString string];
    if([tempArray count]==1){
        if(delegate){
            [self.delegate downloadFinishedWithString:[NSString stringWithString:@"NoLyrics"]];
        }else{
            NSLog(@"Nil");
        }
        return;
    }
    for(int i=1;i<[tempArray count];i++){
        NSString *r = [NSString stringWithString:[tempArray objectAtIndex:i]];
        //NSLog(@"%@",r);
        lrcID = [[r componentsSeparatedByString:@"id=\""] objectAtIndex:1];
        lrcID = [[lrcID componentsSeparatedByString:@"\" arti"]objectAtIndex:0];
        
        finalArtist = [[r componentsSeparatedByString:@"artist=\""]objectAtIndex:1];
        finalArtist = [[finalArtist componentsSeparatedByString:@"\" title"]objectAtIndex:0];
        
        finalTitle = [[r componentsSeparatedByString:@"title=\""]objectAtIndex:1];
        finalTitle = [[finalTitle componentsSeparatedByString:@"\"></lrc"]objectAtIndex:0];
        
        NSLog(@"id:%@,Artist:%@,Title:%@",lrcID,finalArtist,finalTitle);
        
        
        
        if([finalArtist rangeOfString:artistToUse].length>0){
            NSLog(@"匹配成功，直接选择第%i条歌词",i);
            break;
        }else{
            
            if(i==1){
                firstId=[NSString stringWithString:lrcID];
                firstArtist=[NSString stringWithString:finalArtist];
                firstTitle=[NSString stringWithString:finalTitle];
            }else if(i==[tempArray count]-1){
                NSLog(@"没有匹配，自动选择第一条歌词!");     
                lrcID=[NSString stringWithString:firstId];
                finalArtist=[NSString stringWithString:firstArtist];
                finalTitle=[NSString stringWithString:firstTitle];
            }
        }
    }
    
    long finalId = [lrcID intValue];
    finalTitle = [finalTitle stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    finalArtist = [finalArtist stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    finalTitle = [finalTitle stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    finalArtist = [finalArtist stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    finalTitle = [finalTitle stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    finalArtist = [finalArtist stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    
    NSString *finalCode = [self ttpCode:finalArtist :finalTitle :finalId];
    NSString *finalUrl;
    
    finalUrl = [NSString stringWithFormat:@"http://ttlrccnc.qianqian.com/dll/lyricsvr.dll?dl?Id=%lu&Code=%@",finalId,finalCode];
    
    NSLog(@"%@",finalUrl);
    
    DFDownloader *downloader=[[DFDownloader alloc]init];
    downloader.delegate=self;
    [downloader startDownloadWithURLString:finalUrl Key:@"Download" Encoding:NSUTF8StringEncoding];
    //[downloader release];
}

-(void)downloadFinishedWithResult:(NSString *)result Key:(NSString *)theKey{
    NSLog(@"%@",theKey);
    if([theKey isEqualToString:@"Search"]){
        [self searchFinishedWithResult:result];
        [delegate searchFinished];
    }else if([theKey isEqualToString:@"Download"]){
        if(delegate){
            [delegate downloadFinishedWithString:result];
        }else{
            NSLog(@"Nil");
        }
    }
    
}

//下面是从Dynamic Lyrics源码中提取修改出来的十六进制转换算法和千千静听歌词下载验证Code的算法

-(long) conv:(long)i
{
    long r = i % 0x100000000;
    if (i >= 0 && r > 0x80000000)
        r = r - 0x100000000;
    
    if (i < 0 && r < 0x80000000)
        r = r + 0x100000000;
    return r;
}

-(NSString*) ttpCode:(NSString*)artist :(NSString*) title :(long)lrcId
{
    NSString *temp=[artist stringByAppendingString:title];
	const char *bytes=[temp cStringUsingEncoding:NSUTF8StringEncoding];
	long len= strlen(bytes);
	int *song = (int*)(malloc(sizeof(int)*len));  
	for (int i = 0; i < len; i++)  
		song[i] = bytes[i] & 0xff;  
	
	long intVal1 = 0, intVal2 = 0, intVal3 = 0;  
	intVal1 = (lrcId & 0x0000FF00) >> 8;  
	if ((lrcId & 0xFF0000) == 0) {  
		intVal3 = 0xFF & ~intVal1;  
	} else {  
		intVal3 = 0xFF & ((lrcId & 0x00FF0000) >> 16);  
	}  
	intVal3 = intVal3 | ((0xFF & lrcId) << 8);  
	intVal3 = intVal3 << 8;  
	intVal3 = intVal3 | (0xFF & intVal1);  
	intVal3 = intVal3 << 8;  
	if ((lrcId & 0xFF000000) == 0) {  
		intVal3 = intVal3 | (0xFF & (~lrcId));  
	} else {  
		intVal3 = intVal3 | (0xFF & (lrcId >> 24));  
	}  
	long uBound = len - 1;  
	while (uBound >= 0) {  
		int c = song[uBound];  
		if (c >= 0x80)  
			c = c - 0x100;  
		intVal1 = (c + intVal2) & 0x00000000FFFFFFFF;  
		intVal2 = (intVal2 << (uBound % 2 + 4)) & 0x00000000FFFFFFFF;  
		intVal2 = (intVal1 + intVal2) & 0x00000000FFFFFFFF;  
		uBound -= 1;  
	}  
	uBound = 0;  
	intVal1 = 0;  
	while (uBound <= len - 1) {  
		long c = song[uBound];  
		if (c >= 128)  
			c = c - 256;  
		long intVal4 = (c + intVal1) & 0x00000000FFFFFFFF;  
		intVal1 = (intVal1 << (uBound % 2 + 3)) & 0x00000000FFFFFFFF;  
		intVal1 = (intVal1 + intVal4) & 0x00000000FFFFFFFF;  
		uBound += 1;  
	}  
	long intVal5 = [self conv:intVal2 ^ intVal3];  
	intVal5 = [self conv:intVal5 + (intVal1 | lrcId)];  
	intVal5 = [self conv:intVal5 * (intVal1 | intVal3)];  
	intVal5 = [self conv:intVal5 * (intVal2 ^ lrcId)]; 
    
    long intVal6 = intVal5;
    if (intVal6 > 0x80000000) intVal5 = intVal6 - 0x100000000;
    
    free(song);
    
	return [NSString stringWithFormat:@"%ld",intVal5];  
}

-(NSString*)stringToUnicode:(NSString*)theString{
    const char *s = [theString cStringUsingEncoding:NSUnicodeStringEncoding];
    NSMutableString *result = [NSMutableString string];
    
	int n=[theString lengthOfBytesUsingEncoding:NSUnicodeStringEncoding];
    for(int i=0; i<n; i++)
    {
		unsigned ord=(unsigned)s[i];
        [result appendFormat:@"%c%c",[self SingleDecToHex:(ord-ord%16)/16],[self SingleDecToHex:ord%16]];
        
	}
    return result;
}
-(char)SingleDecToHex:(int)dec
{
	dec = dec % 16;
	if(dec < 10)
    {
		return (char)(dec+'0');
	}
	char arr[6]={'A','B','C','D','E','F'};
	return arr[dec-10];
}

@end
