//
//  MADetailsViewController.m
//  MesActivites
//
//  Created by m2sar on 23/11/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import "MADetailsViewController.h"


@interface MADetailsViewController ()

@property (nonatomic, assign)MPMusicPlayerController* myPlayer;

@end

#define STOPPED_STATE_STR @"À l'arrêt"
#define PLAYING_STATE_STR @"En lecture"
#define PAUSED_STATE_STR @"En Pause"
#define NEXT_STATE_STR @"Suivant"
#define PREVIOUS_STATE_STR @"Précédent"
#define LOADING_STATE_STR @"Chargement"

@implementation MADetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.actionLabel = [[UILabel alloc] init];
    self.actionLabel.text = STOPPED_STATE_STR;
    self.actionLabel.textAlignment=NSTextAlignmentCenter;
    
    self.songName = [[UILabel alloc] init];
    self.songName.text =nil;
    self.songName.textAlignment=NSTextAlignmentCenter;

    self.songPV = [[UIProgressView alloc]init];
    [self.songPV setProgress:0];
    
    
    self.progressLabel = [[UILabel alloc]init];
    [self.progressLabel setText:[NSString stringWithFormat:@"0/%lu",(unsigned long)[[[[MPMediaQuery alloc] init]items] count]]];
    self.progressLabel.textAlignment=NSTextAlignmentCenter;

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playStopSongOnDoubleTap:)];
    [singleTap setNumberOfTapsRequired:2];
    [singleTap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:singleTap];
    [singleTap release];
    
    UISwipeGestureRecognizer * swipeRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(previousSongOnSwipeRight:)];
    swipeRight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer * swipeLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(nextSongOnSwipeLeft:)];
    swipeLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];

    /* view's Background */
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"fond-alu"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    [self drawSubviews:self.view.frame.size];
    

    self.myPlayer = [MPMusicPlayerController systemMusicPlayer];
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    
    
    [notificationCenter addObserver: self
                           selector:@selector (currentSongChanged)
                               name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                             object:self.myPlayer
     ];
    
    [notificationCenter addObserver: self
                                  selector:@selector (currentSongPlaybackChanged)
                                      name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                    object:self.myPlayer
    ];
    [self.myPlayer beginGeneratingPlaybackNotifications];
    
    /* adding subviews */
    [self.view addSubview:self.actionLabel];
    [self.view addSubview:self.songPV];
    [self.view addSubview:self.songName];
    [self.view addSubview:self.progressLabel];
    
    /* releasing stuff */
    [self.actionLabel release];
    [self.songName release];
    [self.songPV release];
    [self.progressLabel release];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define V_BORDERLINE 20
#define H_BORDERLINE 90
#define DFLT_PADDING 20
#define DFLT_ELT_SIZE 50

- (void)drawSubviews:(CGSize)frame
{
    self.view.frame = CGRectMake(0, 0, frame.width, frame.height);

    self.actionLabel.frame = CGRectMake(V_BORDERLINE, H_BORDERLINE, frame.width - (2*V_BORDERLINE), DFLT_ELT_SIZE);
    self.songName.frame = CGRectMake(V_BORDERLINE, self.actionLabel.frame.origin.y+ DFLT_ELT_SIZE+ DFLT_PADDING, frame.width - (2*V_BORDERLINE), DFLT_ELT_SIZE);
    self.songPV.frame = CGRectMake(V_BORDERLINE, self.songName.frame.origin.y+ DFLT_ELT_SIZE+ DFLT_PADDING, frame.width - (2*V_BORDERLINE), DFLT_ELT_SIZE);
    self.progressLabel.frame = CGRectMake(V_BORDERLINE, self.songPV.frame.origin.y+ DFLT_ELT_SIZE+ DFLT_PADDING, frame.width - (2*V_BORDERLINE), DFLT_ELT_SIZE);
    
}

- (void) playStopSongOnDoubleTap: (UITapGestureRecognizer *)recognizer{
    NSArray*all;
    MPMediaItemCollection*mic;
    
    switch ([self.myPlayer playbackState]) {
        case MPMusicPlaybackStatePaused:
            [self.myPlayer play];
            break;
            
        case MPMusicPlaybackStatePlaying:
            [self.myPlayer pause];
            break;
            
        case MPMusicPlaybackStateStopped:
            all=[[[MPMediaQuery alloc] init]items];
            mic=[[MPMediaItemCollection alloc]initWithItems:all];
            [self.myPlayer setQueueWithItemCollection:mic];
            [self.myPlayer play];
            break;
            
        default:
            break;
    }

    [self updateLabelsCurSong];

}

-(void)playCurrentSong{
    
}

-(void)nextSongOnSwipeLeft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self.actionLabel setText:NEXT_STATE_STR];
    [self.myPlayer skipToNextItem];
    [self updateLabelsCurSong];
   }

-(void)previousSongOnSwipeRight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self.actionLabel setText:PREVIOUS_STATE_STR];
    [self.myPlayer skipToPreviousItem];
    [self updateLabelsCurSong];
}

-(void)updateLabelsCurSong
{
    if(((int)[self.myPlayer indexOfNowPlayingItem])!=-1){
        [self.progressLabel setText: [[NSString alloc]initWithFormat:@"%lu/%lu", (unsigned long)[self.myPlayer indexOfNowPlayingItem]+1, (unsigned long)[[[[MPMediaQuery alloc] init]items] count]]];
    }
}

-(void)currentSongChanged{
    
    [self.songName setText:[[self.myPlayer nowPlayingItem]valueForProperty:MPMediaItemPropertyTitle]];
    [self sendHistory];
}

-(void)currentSongPlaybackChanged{
    [self.songName setText:[[self.myPlayer nowPlayingItem]valueForProperty:MPMediaItemPropertyTitle]];

    [self sendHistory];

    switch ([self.myPlayer playbackState]) {
        case MPMusicPlaybackStatePaused:
            [self.actionLabel setText:PAUSED_STATE_STR];
            break;
            
        case MPMusicPlaybackStatePlaying:
            [self.actionLabel setText:PLAYING_STATE_STR];
            break;
            
        case MPMusicPlaybackStateStopped:
            [self.actionLabel setText:STOPPED_STATE_STR];
            break;
            
        default:
            break;
    }
}

-(void)sendHistory
{
    if([self.myPlayer playbackState]==MPMusicPlaybackStatePlaying){
        [_delegate retain];
        if([_delegate respondsToSelector:@selector(addSongToHistory:)] && ((int)[self.myPlayer indexOfNowPlayingItem])!=-1){
            [_delegate addSongToHistory:[self.myPlayer nowPlayingItem]];
        }
        [_delegate release];
    }

}

-(void) playHistoryEntry:(MPMediaItem*)curSong
{
    [self.myPlayer setNowPlayingItem:curSong];
}


- (void)viewDidLayoutSubviews
{
    [self drawSubviews:[[[[self navigationController] topViewController] view] frame].size];
}

- (void)dealloc
{
    [_splitVC release];    
    [super dealloc];
}

@end
