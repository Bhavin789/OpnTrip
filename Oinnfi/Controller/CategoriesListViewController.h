//
//  CategoriesListViewController.h
//  OpenTrip
//
//  Created by Neha Jain on 10/09/15.
//  Copyright (c) 2015 Parvendra Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVPlayer.h>

@interface CategoriesListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *catTable;
    NSMutableArray *catArray;
    
    NSMutableArray *dataArray;
    NSMutableArray *allAudioInArray;
    AVPlayer *player;
    int audioIndex;
    UIButton *playBtn;
    NSArray *showArray;
    
    UIImageView *onlineOfflineImage;
    
    UIImageView *searchImg;
}
@property(nonatomic) id cat_id;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSDictionary *dataDic;
@property(nonatomic,retain) NSString *fromView;
@end
