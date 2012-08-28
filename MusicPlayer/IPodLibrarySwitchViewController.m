//
//  IPodLibrarySwitchViewController.m
//  iPodLibraryViews
//
//  Created by Bill on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "IPodLibrarySwitchViewController.h"
#import "DFMusicQuery.h"

@implementation IPodLibrarySwitchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view setFrame:CGRectMake(0, 0, 320, 480)];
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mainViewController = [[IPodLibraryMainViewController alloc] init];
        musicSynced=NO;
    
    [self.view addSubview:mainViewController.view];

}

-(void)startMoveWithViewController:(UIViewController*)controller PointStart:(CGPoint)pointStart PointTo:(CGPoint)pointTo UseSelector:(BOOL)useSelector{
    //被这个推动动画整了好久，最先用UINavigationController，但是这个东东实在是太难用了而且老出问题，坑爹的苹果库害的我换成了CoreAnimation，但是kCATransitionPush会画蛇添足的在头尾加入了渐变动画，看着极度别扭，为了追求完美还是自己写动画。。。。。
    
    controller.view.frame = CGRectMake(pointStart.x,pointStart.y,320,480);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4f];
    controller.view.frame = CGRectMake(pointTo.x,pointTo.y,320,480);
    if(useSelector){
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationEnd)];
    }
    [UIView commitAnimations];
}

-(void)pushViewControllerWithLeftController:(UIViewController*)leftController RightController:(UIViewController*)rightController PushWay:(ViewPushWay)pushWay{
    if(pushWay==ViewPushWayLeft){
        //如果界面往左推(进入)那么把左边的界面移走，右边的界面初始化
        self.view.userInteractionEnabled=NO;
        [self startMoveWithViewController:leftController PointStart:CGPointMake(0, 0) PointTo:CGPointMake(-320, 0) UseSelector:NO];
        [self.view insertSubview:rightController.view atIndex:0];
        [self startMoveWithViewController:rightController PointStart:CGPointMake(320, 0) PointTo:CGPointMake(0, 0) UseSelector:YES];
        viewToRemove=leftController;
    }else if(pushWay==ViewPushWayRight){
        //如果界面往右推(推出)那么把右边的界面移走，左边的界面初始化
        self.view.userInteractionEnabled=NO;
        [self startMoveWithViewController:rightController PointStart:CGPointMake(0, 0) PointTo:CGPointMake(320, 0) UseSelector:NO];
        [self.view insertSubview:leftController.view atIndex:0];
        [self startMoveWithViewController:leftController PointStart:CGPointMake(-320, 0) PointTo:CGPointMake(0, 0) UseSelector:YES];
        viewToRemove=rightController;
    }
}

-(void)changeToAllSongsView{
    if(!allSongsViewController){
        allSongsViewController=[[AllSongsViewController alloc]initWithNibName:@"AllSongsViewController" bundle:nil];
    }
    [self pushViewControllerWithLeftController:mainViewController RightController:allSongsViewController PushWay:ViewPushWayLeft];
}

-(void)changeToArtistView{
    if(artistViewController==nil){
        artistViewController=[[ArtistViewController alloc]initWithNibName:@"ArtistViewController" bundle:nil];
        [artistViewController setTableViewWithMusicArray:musicByArtist];
    }
    [self pushViewControllerWithLeftController:mainViewController RightController:artistViewController PushWay:ViewPushWayLeft];
}

-(void)changeToAlbumController{
    if(albumController==nil){
        albumController=[[AlbumViewController alloc]initWithNibName:@"AlbumViewController" bundle:nil];
        [albumController setTableViewWithMusicArray:musicByAlbum];
    }
    [self pushViewControllerWithLeftController:mainViewController RightController:albumController PushWay:ViewPushWayLeft];
}

-(void)changeBackToAlbumController{
    if(albumController==nil){
        albumController=[[AlbumViewController alloc]initWithNibName:@"AlbumViewController" bundle:nil];
    }
    [self pushViewControllerWithLeftController:albumController RightController:albumSongsViewController PushWay:ViewPushWayRight];
}

-(void)changeToAlbumSongsViewWithIndex:(int)index{
    
    if(albumSongsViewController==nil){
        albumSongsViewController=[[AlbumSongsViewController alloc]initWithNibName:@"AlbumSongsViewController" bundle:nil];
        [albumSongsViewController setItemsWithIndex:index];
    }
    [self pushViewControllerWithLeftController:albumController RightController:albumSongsViewController PushWay:ViewPushWayLeft];
    
}

-(void)changeToIPodLibraryMainViewWithNowController:(NSString*)controller{
    
    UIViewController *usingController=nil;
    
    if([controller isEqualToString:@"MusicSelectView"]){
        usingController=allSongsViewController;
    }else if([controller isEqualToString:@"CoverflowView"]){
        usingController=coverFlowViewController;
    }else if([controller isEqualToString:@"AlbumView"]){
        usingController=albumController;
    }else if([controller isEqualToString:@"ArtistView"]){
        usingController=artistViewController;
    }
    [self pushViewControllerWithLeftController:mainViewController RightController:usingController PushWay:ViewPushWayRight];
}

-(void)changeToCoverFlowView{
    if(coverFlowViewController==nil){
        coverFlowViewController=[[CoverFlowViewController alloc]init];
        [coverFlowViewController.coverFlowView setUserInteractionEnabled:YES];
    }
    [coverFlowViewController.view setUserInteractionEnabled:YES];
    [self pushViewControllerWithLeftController:mainViewController RightController:coverFlowViewController PushWay:ViewPushWayLeft];
}

-(void)changeBackToArtistController{
    if(artistViewController==nil){
        artistViewController=[[ArtistViewController alloc]initWithNibName:@"ArtistViewController" bundle:nil];
    }
    [self pushViewControllerWithLeftController:artistViewController RightController:artistSongViewController PushWay:ViewPushWayRight];
}

-(void)changeToArtistSongsViewWithIndex:(int)index{
    if(artistSongViewController==nil){
        artistSongViewController=[[ArtistSongsViewController alloc]initWithNibName:@"ArtistSongsViewController" bundle:nil];
        [artistSongViewController setItemsWithIndex:index];
    }
    [self pushViewControllerWithLeftController:artistViewController RightController:artistSongViewController PushWay:ViewPushWayLeft];
}

-(void)animationEnd{
    self.view.userInteractionEnabled=YES;
    if(viewToRemove){
        [viewToRemove.view removeFromSuperview];
        if(viewToRemove==albumSongsViewController){
            [albumSongsViewController release];
            albumSongsViewController=nil;
        }
        if(viewToRemove==artistSongViewController){
            [artistSongViewController release];
            artistSongViewController=nil;
        }
        viewToRemove=nil;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
