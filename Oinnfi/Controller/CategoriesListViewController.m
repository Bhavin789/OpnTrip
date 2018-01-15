//
//  CategoriesListViewController.m
//  OpenTrip
//
//  Created by Neha Jain on 10/09/15.
//  Copyright (c) 2015 Parvendra Singh. All rights reserved.
//

#import "CategoriesListViewController.h"
#import <AVFoundation/AVPlayer.h>
#import <AVFoundation/AVPlayerItem.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVPlayerLayer.h>
#import "ListForAudioViewController.h"
#import "ViewController.h"
#import "MainTabBarController.h"
#import "SWRevealViewController.h"


@interface CategoriesListViewController ()
@property (nonatomic) IBOutlet UIBarButtonItem *revealBtnItem;
@end

@implementation CategoriesListViewController

@synthesize cat_id,name,dataDic,fromView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.title=name;
       
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName: [UIFont fontWithName:@"Arial" size:18.0f]}];
    self.navigationController.navigationBar.barTintColor = UIColorFromRedGreenBlue(255,102,102);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    MainTabBarController *tabbarVC =[ self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBarController"];
    tabbarVC.tabBar.hidden = NO;
    
    SWRevealViewController *revealViewController = self.revealViewController;
   
    UIView *viewonnavigation=[[UIView alloc]init];
   viewonnavigation.frame=CGRectMake(-20, 0, 24, 24);
    viewonnavigation.backgroundColor = [UIColor redColor];
   
   
   onlineOfflineImage=[[UIImageView alloc]init];
   
   onlineOfflineImage.frame = CGRectMake(viewonnavigation.frame.origin.x,0, 20, 20);
   onlineOfflineImage.image = [UIImage imageNamed:@"search.png"];
   
   [viewonnavigation addSubview:onlineOfflineImage];
    [self.navigationController.navigationItem.titleView addSubview:viewonnavigation];
   
   self.navigationController.tabBarItem.image = [UIImage imageNamed:@"search.png"];
    
   
    
    if ([fromView isEqualToString:@"Rear"])
    {
       
        [Utility navigationItemForFirstCatList:self.navigationItem target:self target2:revealViewController];
    }
    else{
      [Utility navigationItem:self.navigationItem target:self target2:revealViewController];
    }
    audioIndex=0;
    catArray=[[NSMutableArray alloc]init];
    dataArray=[[NSMutableArray alloc]init];
    
    NSLog(@"this is data----%@",dataDic);
    
    showArray=[dataDic valueForKey:@"items"];
    
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"id" ascending:NO];
//    showArray=[[showArray sortedArrayUsingDescriptors:@[sort]] mutableCopy];
    
    [catTable reloadData];
    
   // [self getDataFromServer];
    
}


-(void)backbtnPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backbtnPressedForHome{
    
    SWRevealViewController *revealController = self.revealViewController;
    
    ViewController *catList=[self.storyboard instantiateViewControllerWithIdentifier:@"mainViewID"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:catList];
    [revealController pushFrontViewController:navigationController animated:YES];
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return  showArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    NSString *cellId=@"catListCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    UIImageView *imageView=(UIImageView *)[cell viewWithTag:100];
    
    NSString *imageUrl=[[showArray objectAtIndex:indexPath.row] valueForKey:@"image"];
    
    if (imageUrl.length>0) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:[[showArray objectAtIndex:indexPath.row] valueForKey:@"image"]] placeholderImage:nil];
    }
    else{
        [imageView setImage:[UIImage imageNamed:@"default.jpg"]];
    }
    
    UILabel *lblName=(UILabel *)[cell viewWithTag:101];
    lblName.text=[[showArray objectAtIndex:indexPath.row] valueForKey:@"text"];
    
    //UILabel *like=(UILabel *)[cell viewWithTag:102];
    
   // NSString *likeStr=[NSString stringWithFormat:@"%@ Likes",[[showArray objectAtIndex:indexPath.row] valueForKey:@"likes"]];
    
   // like.text=likeStr;
    
   // UILabel *download=(UILabel *)[cell viewWithTag:103];
    
   // NSString *downloadStr=[NSString stringWithFormat:@"%@ Downloads",[[showArray objectAtIndex:indexPath.row] valueForKey:@"download"]];
    
   // download.text=downloadStr;
    
   // [cell.contentView addSubview:like];
    [cell.contentView addSubview: playBtn];
   
    [cell.contentView addSubview:lblName];
    [cell.contentView addSubview:imageView];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    ListForAudioViewController *viewForList=[self.storyboard instantiateViewControllerWithIdentifier:@"listview"];
    viewForList.cat_id=[[showArray objectAtIndex:indexPath.row] valueForKey:@"id"];
    viewForList.name=[[showArray objectAtIndex:indexPath.row] valueForKey:@"text"];
    [self.navigationController pushViewController:viewForList animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
