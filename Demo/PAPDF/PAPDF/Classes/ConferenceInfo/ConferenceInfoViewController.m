//
//  ConferenceInfoViewController.m
//  PAPDF
//
//  Created by 钟文成(外包) on 2018/1/23.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "ConferenceInfoViewController.h"

@interface ConferenceInfoViewController ()

@end

@implementation ConferenceInfoViewController


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark =======    初始化  =======
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 *    @brief    初始化操作，请求通知附件信息，上传未上传阅读状态的通知状态，请求会议信息，请求通知信息
 */
- (void)initialization {
//    NSArray *localNoticeArray = [Notice arrayFromSqlite];
//    if (ServerLogin == [Global loginStatus]) {
//        for (Notice *notice in localNoticeArray) {
//            if (AttachmentsNotFetch == notice.attachmentsStatus)
//                [self requestAttachmentMaterialInfoWithNotice:notice];
//            if (IsRead ==  notice.isRead && isNotUpdated == notice.updatedStatus) {
//                PACDMS_ipadAppDelegate *delegate = (PACDMS_ipadAppDelegate *)[[UIApplication sharedApplication] delegate];
//                [delegate requestUpdateNoticeStatusWithNotice:notice];
//            }
//        }
//    }
//    _allNoticesDataSourceArray = [[NSMutableArray alloc] initWithArray:localNoticeArray];
//    [self updateNotReadNotices];
//    NSArray *localCurrentConferencesArray = [Conference arrayFromSqlite];
//    [self setCurrentConferencesDataSourceArray:localCurrentConferencesArray];
//    if (ServerLogin == [Global loginStatus]) {
//        [self requestConferencesInfo:self];
//        [self requestNoticesInfoFrom:self];
//    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
