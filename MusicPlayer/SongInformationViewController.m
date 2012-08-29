//
//  SongInformationViewController.m
//  iPodLibraryViews
//
//  Created by Bill on 12-7-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SongInformationViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation SongInformationViewController

@synthesize artworkView;
@synthesize songTitle;
@synthesize songArtist;
@synthesize songAlbum;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    songTitle=[[UILabel alloc]init];
    songAlbum=[[UILabel alloc]init];
    songArtist=[[UILabel alloc]init];
    artworkView=[[UIImageView alloc]init];
}

-(void)setInformationWithItem:(MPMediaItem*)theItem{
    NSLog(@"%@",[theItem valueForProperty:MPMediaItemPropertyTitle]);

    [songTitle setText:[theItem valueForProperty:MPMediaItemPropertyTitle]];
    [songArtist setText:[theItem valueForProperty:MPMediaItemPropertyArtist]];
    [songAlbum setText:[theItem valueForProperty:MPMediaItemPropertyAlbumTitle]];
    
    MPMediaItemArtwork *artWork=[theItem valueForProperty:MPMediaItemPropertyArtwork];
    UIImage *artworkImage=[artWork imageWithSize:CGSizeMake(135, 135)];
    if(artworkImage){
        [artworkView setImage:artworkImage];
    }else{
        [artworkView setImage:[UIImage imageNamed:@"no_album.png"]];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)dealloc{
    [songTitle release];
    [songArtist release];
    [songAlbum release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
