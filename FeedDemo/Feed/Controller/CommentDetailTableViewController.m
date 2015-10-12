//
//  CommentDetailTableViewController.m
//  FeedDemo
//
//  Created by 吴启飞 on 15/10/12.
//  Copyright © 2015年 吴启飞. All rights reserved.
//

#import "CommentDetailTableViewController.h"
#import "FeedTopicTableViewCell.h"
#import "CommentHeaderFeedTableViewCell.h"
#import "CommentDetailWithCommentTableViewController.h"
#import "TopicModel.h"
#import "AddComment2TopicViewController.h"


@interface CommentDetailTableViewController ()

@end

@implementation CommentDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section ==0 )
    {
        return 1;
    }
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    if(section==0)
    {
        return 10;
    }
    else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        FeedTopicTableViewCell *cell = (FeedTopicTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"FeedTopicTableViewCell" forIndexPath:indexPath];
        if(!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FeedTopicTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        TopicModel *topicModel = [TopicModel new];
        topicModel.topicCreater = [FeedUser new];
        topicModel.topicCreater.username = @"话题";
        topicModel.topicCreater.avatarUrl = @"https://www.baidu.com/img/bdlogo.png";
        topicModel.topicContent = @"百度自2014年底起，开始对部分地区开放了HTTPS加密搜索服务。直到上周，百度表示全站开启了HTTPS安全加密搜索。那么，该如何看待“百度全站采用HTTPS加密搜索”呢？ \n\r 以下为来自知乎网友雷志兴-Berg的看法： \n\r 百度在工程开发上几乎不做没有性价比的事情。所以我们先看看https这个事情在技术上的投入在哪里。我没有参与此方面任何工作，都是根据我临时推想得到，比较乱，回头";
        topicModel.topicCreateTime = [NSDate date];
        [cell setTopicModel:topicModel];
        return cell;
    }else
    {
        
        CommentHeaderFeedTableViewCell *cell = (CommentHeaderFeedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CommentHeaderFeedTableViewCell" forIndexPath:indexPath];
        if(!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentHeaderFeedTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        FeedModel *feedModel = [FeedModel new];
        feedModel.creater = [FeedUser new];
        feedModel.creater.username = @"评论";
        feedModel.creater.avatarUrl = @"https://www.baidu.com/img/bdlogo.png";
        
        feedModel.feedCreateTime = [NSDate date];
        feedModel.content = @"百度自2014年底起，开始对部分地区开放了HTTPS加密搜索服务。直到上周，百度表示全站开启了HTTPS安全加密搜索。那么，该如何看待“百度全站采用HTTPS加密搜索”呢？ /n/r 以下为来自知乎网友雷志兴-Berg的看法： \n\r 百度在工程开发上几乎不做没有性价比的事情。所以我们先看看https这个事情在技术上的投入在哪里。我没有参与此方面任何工作，都是根据我临时推想得到，比较乱，回头";
        feedModel.albums = @[@"https://www.baidu.com/img/bdlogo.png",@"https://www.baidu.com/img/bdlogo.png",@"https://www.baidu.com/img/bdlogo.png",@"https://www.baidu.com/img/bdlogo.png",@"https://www.baidu.com/img/bdlogo.png",];
        
        [cell setFeedModel:feedModel];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section >0 ) {
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"Comment" bundle:nil] instantiateViewControllerWithIdentifier:@"CommentDetailWithCommentTableViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"Comment" bundle:nil] instantiateViewControllerWithIdentifier:@"AddComment2TopicViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
