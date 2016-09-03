//
//  ViewController.m
//  iSwingShip
//
//  Created by Bui Duc Khanh on 9/3/16.
//  Copyright © 2016 Bui Duc Khanh. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController
{
    UIImageView *sea1;
    UIImageView *sea2;
    
    UIImageView *ship;
    
    AVAudioPlayer *audioPlayer;
    
    CGSize screen;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    screen = self.view.frame.size;
    
    [self drawShipAndSea];
    
    [self playSong];
    
    [self animateShip];
    
    [self animateSea];
}

- (void) drawShipAndSea {
    // Tạo frame sea 1
    sea1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sea01.png"]];
    sea1.frame = self.view.frame;
    sea1.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view addSubview:sea1];
    
    
    // Tạo frame sea 2
    sea2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sea02.png"]];
    sea2.frame = CGRectMake(screen.width, 0, screen.width, screen.height);
    sea2.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view addSubview:sea2];
    
    
    // Tạo Ship
    ship = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ship"]];
    ship.center = CGPointMake(screen.width/2.0, screen.height/2.0 + 70);
    
    [self.view addSubview:ship];
}

-(void) animateShip {
    [UIView animateWithDuration:1 animations:^{
        ship.transform = CGAffineTransformMakeRotation(-0.08);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1
                         animations:^{
                             ship.transform = CGAffineTransformMakeRotation(0.08);
                         } completion:^(BOOL finished) {
                             [self animateShip];
                         }];
    }];
}

- (void) animateSea {
    [UIView animateWithDuration:10
                     animations:^{
                         sea1.frame = CGRectMake(-screen.width, 0, screen.width, screen.height);
                         sea2.frame = self.view.bounds;
                     } completion:^(BOOL finished) {
                         sea1.frame = CGRectMake(screen.width, 0, screen.width, screen.height);
                         [UIView animateWithDuration:10 animations:^{
                             sea1.frame = self.view.bounds;
                             sea2.frame = CGRectMake(-screen.width, 0, screen.width, screen.height);
                         } completion:^(BOOL finished) {
                             sea2.frame = CGRectMake(screen.width, 0, screen.width, screen.height);
                             [self animateSea];
                         }];
                         
                     }];
}


// Hàm tạo nhạc
- (void) playSong {
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"wave" ofType:@"mp3"]];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                         error:&error];
    [audioPlayer prepareToPlay];
    [audioPlayer play];
}


@end
