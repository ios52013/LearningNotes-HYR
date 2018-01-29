//
//  ModelFactory.m
//  PACDMS_ipad
//
//  Created by yangfeiyue on 11-9-3.
//  Copyright 2011年 zbkc. All rights reserved.
//

#import "ModelFactory.h"
#import "Global.h"
#import "Schedule.h"

@interface ModelFactory (private) 
/**
 *	@brief	根据dataSource数组返回封装好的user对象数组
 *
 *	@param 	dataSource 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	user对象数组
 */
+ (NSArray *)usersProductsByDataSourceArray:(NSArray *)dataSource;

/**
 *	@brief	根据dataSource数组返回封装好的会议对象数组
 *
 *	@param 	dataSource{ 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	会议对象数组
 */
+ (NSArray *)conferencesProductsByDataSourceArray:(NSArray *)dataSource;

/**
 *	@brief	根据dataSource数组返回封装好的通知对象数组
 *
 *	@param 	dataSource{ 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	通知对象数组
 */
+ (NSArray *)noticesProductsByDataSourceArray:(NSArray *)dataSource;

//// 生成议程对象数组
//+ (NSArray *)agendaProductsByDataSourceArray:(NSArray *)dataSource;

/**
 *	@brief	根据dataSource数组返回封装好的文件对象数组
 *
 *	@param 	dataSource	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	文件对象数组
 */
+ (NSArray *)materialsProductsByDataSourceArray:(NSArray *)dataSource;

/**
 *	@brief	根据dataSource数组返回封装好的秘书对象数组
 *
 *	@param 	dataSource 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	秘书对象数组
 */
+ (NSArray *)secretariesProductsByDataSourceArray:(NSArray *)dataSource;

/**
 *	@brief	根据dataSource数组返回封装好的议程对象数组
 *
 *	@param 	dataSource 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	议程对象数组
 */
+ (NSArray *)agendasAndMaterialsProductsByDataSourceArray:(NSArray *)dataSource;

/**
 *	@brief	根据dataSource数组返回封装好的个人文件对象数组
 *
 *	@param 	dataSource 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	个人文件对象数组
 */
+ (NSArray *)personalDocProductsByDataSourceArray:(NSArray *)dataSource;

/**
 *	@brief	根据dataSource数组返回封装好的日常文件对象数组
 *
 *	@param 	dataSource 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	日常文件对象数组
 */
+ (NSArray *)dailyDocProductsByDataSourceArray:(NSArray *)dataSource;

/**
 *	@brief	根据dataSource数组返回封装好的文件url地址对象数组
 *
 *	@param 	dataSource 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	文件url地址对象数组
 */
+ (NSArray *)materialURLArrayByDataSourceArray:(NSArray *)dataSource;

/**
 *	@brief	根据dataSource数组返回封装好的历史会议类型对象数组
 *
 *	@param 	dataSource 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	历史会议类型对象数组
 */
+ (NSArray *)councilsArrayByDataSourceArray:(NSArray *)dataSource;

/**
 *	@brief	根据dataSource数组返回封装好的组织机构对象数组
 *
 *	@param 	dataSource 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	组织机构对象数组
 */
+ (NSArray *)groupsArrayByDataSourceArray:(NSArray *)dataSource;

/**
 *	@brief	根据dataSource数组返回封装好的组织机构对象数组
 *
 *	@param 	dataSource 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	删除的文件信息对象数组
 */
+ (NSArray *)deletedInfosArrayByDataSourceArray:(NSArray *)dataSource;

/**
 *	@brief	根据dataSource数组返回封装好的投票议案对象数组
 *
 *	@param 	dataSource 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	投票议案对象数组
 */
+ (NSArray *)votingProposalsArrayByDataSourceArray:(NSArray *)dataSource;

/**
 *	@brief	根据dataSource数组返回封装好的目录对象数组
 *
 *	@param 	dataSource 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	目录对象数组
 */
+ (NSArray *)directoriesArrayByDataSourceArray:(NSArray *)dataSource;

/**
 *	@brief	根据dataSource数组返回封装好的会议排期对象数组
 *
 *	@param 	dataSourec 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	会议排期对象数组
 */
+ (NSArray *)scheduleArrayByDataSourceArray:(NSArray *)dataSource;

@end

@implementation ModelFactory

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}



/**
 *	@brief	模型加工厂的主要方法，每一个从网络响应的json对象都通过这个方法，进入到不同的生产流水线（不同的转换方法）转换为包含不同类型对象的对象数组
 *
 *	@param 	networkInterface 	表示响应数据为哪种类型的对象
 *	@param 	dataSource 	表示响应的json字典
 *
 *	@return	一个包含了productType描述的对象类型的对象数组，但是该数组的第0和1位置存放的是网络响应是否成功的标记，第2位置存放的是服务器返回对象的总数，从第3位置开始存放网络返回的对象
                  格式：     index --->    |        0        |          1          |          2          |          3         | ...
                                 value --->    |     result    |    errorCode  |        total       |     object_1   | ...
 */
+ (NSArray *)productsOfNetworkInterface:(NetworkInterface)networkInterface withDataSource:(NSDictionary *)dataSource {
//  objectsArray      --    在进入流水线之前初步加工后的对象源
//  productsArray    --    经过流水线加工之后的最终对象数组
  NSArray *objectsArray = nil;
  NSMutableArray *productsArray = [[NSMutableArray alloc] init];
//  errorCode     --    网络响应的表示请求异常的响应码，具体一一对应参照响应码表
//  result            --    网络响应的表示请求结果的 BOOL 值
  NSInteger errorCode = [[dataSource objectForKey:@"errorCode"] intValue];
  BOOL result = [[dataSource objectForKey:@"result"] boolValue];
  [productsArray addObject:[dataSource objectForKey:@"result"]];
  [productsArray addObject:[NSString stringWithFormat:@"%d", errorCode]];

//  在确认响应无异常后，根据 productType 将初步加工后的 objectsArray 交由不同流水线处理
  if (result) {
    switch (networkInterface) {
      case NetworkInterfaceGetAESKey:
        [productsArray addObject:[dataSource objectForKey:@"data"]];
      case NetworkInterfaceLogin:
      case NetworkInterfaceResetPassword:
        objectsArray = [NSArray arrayWithObject:[dataSource objectForKey:@"data"]];
        break;
      case NetworkInterfaceAgendasAndMaterials:
#pragma mark - add by lc20140325
        {
            [productsArray addObject:[[[dataSource objectForKey:@"data"] objectForKey:@"agendaList"]objectForKey:@"total"]];
            objectsArray = [NSArray arrayWithArray:[[[dataSource objectForKey:@"data"] objectForKey:@"agendaList"] objectForKey:@"rows"]];
            
            NSString * strss = [[dataSource objectForKey:@"data"] objectForKey:@"isVote"];
            
            NSString * ooo = [NSString stringWithFormat:@"是否有isVote %@",strss];
            
            NSLog(@" ******************************************************************** 是否有isVote ******* %@",strss);
            //UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:ooo delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
            //[alertView show];
            
            [[NSUserDefaults standardUserDefaults] setObject:strss forKey:kkIsVote];
            [[NSUserDefaults standardUserDefaults] synchronize];
            break;
        }
#pragma mark - end
      case NetworkInterfaceConferences:
      case NetworkInterfaceNotices:
      case NetworkInterfaceNoticeAttachments:
      case NetworkInterfaceMaterials:
      case NetworkInterfaceSecretaries:

      case NetworkInterfaceDailyDoc:
      case NetworkInterfacePersonalDoc:
      case NetworkInterfaceMaterialURL:
      case NetworkInterfaceCouncils:
      case NetworkInterfaceGroups:
      case NetworkInterfaceVotingProposals:
      case NetworkInterfaceDeletedInfos:
      case NetworkInterfaceDirectories:
      case NetworkInterfaceSchedule:
        [productsArray addObject:[[dataSource objectForKey:@"data"] objectForKey:@"total"]];
        objectsArray = [NSArray arrayWithArray:[[dataSource objectForKey:@"data"] objectForKey:@"rows"]];
            
            
        break;

      default:
        break;
    }
    if ([objectsArray count] > 0) {
      switch (networkInterface) {
        case NetworkInterfaceLogin:
        case NetworkInterfaceResetPassword:
          [productsArray addObjectsFromArray:[self usersProductsByDataSourceArray:objectsArray]];
          break;
        case NetworkInterfaceConferences:
          [productsArray addObjectsFromArray:[self conferencesProductsByDataSourceArray:objectsArray]];
          break;
        case NetworkInterfaceNotices:
          [productsArray addObjectsFromArray:[self noticesProductsByDataSourceArray:objectsArray]];
          break;
        case NetworkInterfaceNoticeAttachments:
        case NetworkInterfaceMaterials:
          [productsArray addObjectsFromArray:[self materialsProductsByDataSourceArray:objectsArray]];
          break;
        case NetworkInterfaceSecretaries:
          [productsArray addObjectsFromArray:[self secretariesProductsByDataSourceArray:objectsArray]];
          break;
#pragma mark - 20140324
        case NetworkInterfaceAgendasAndMaterials:
              NSLog(@"%@",productsArray);
              NSLog(@"%@",objectsArray);
          [productsArray addObjectsFromArray:[self agendasAndMaterialsProductsByDataSourceArray:objectsArray]];
              NSLog(@"%@",productsArray);

          break;
        case NetworkInterfacePersonalDoc:
          [productsArray addObjectsFromArray:[self personalDocProductsByDataSourceArray:objectsArray]];
          break;
        case NetworkInterfaceDailyDoc:
          [productsArray addObjectsFromArray:[self dailyDocProductsByDataSourceArray:objectsArray]];
          break;
        case NetworkInterfaceMaterialURL:
          [productsArray addObjectsFromArray:[self materialURLArrayByDataSourceArray:objectsArray]];
          break;
        case NetworkInterfaceCouncils:
          [productsArray addObjectsFromArray:[self councilsArrayByDataSourceArray:objectsArray]];
          break;
        case NetworkInterfaceGroups:
          [productsArray addObjectsFromArray:[self groupsArrayByDataSourceArray:objectsArray]];
          break;
        case NetworkInterfaceDeletedInfos:
          [productsArray addObjectsFromArray:[self deletedInfosArrayByDataSourceArray:objectsArray]];
          break;
        case NetworkInterfaceVotingProposals:
          [productsArray addObjectsFromArray:[self votingProposalsArrayByDataSourceArray:objectsArray]];
          break;
        case NetworkInterfaceDirectories:
          [productsArray addObjectsFromArray:[self directoriesArrayByDataSourceArray:objectsArray]];
        break;
        case NetworkInterfaceSchedule:
          [productsArray addObjectsFromArray:[self scheduleArrayByDataSourceArray:objectsArray]];
          break;
        default:
          break;
      }
    }
  }
  return productsArray;
}


/**
 *	@brief	根据dataSource数组返回封装好的user对象数组
 *
 *	@param 	dataSource 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	user对象数组
 */
+ (NSArray *)usersProductsByDataSourceArray:(NSArray *)dataSource {
  NSMutableArray *productsArray = [[NSMutableArray alloc] init];
//  User *user = nil;
//  for (int i = 0; i < [dataSource count]; i++) {
//    user = [User userByDictionary:[dataSource objectAtIndex:i]];
//    [productsArray addObject:user];
//    user = nil;
//  }
  return productsArray;
}


/**
 *	@brief	根据dataSource数组返回封装好的会议对象数组
 *
 *	@param 	dataSource{ 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	会议对象数组
 */
+ (NSArray *)conferencesProductsByDataSourceArray:(NSArray *)dataSource {
    NSMutableArray *productsArray = [[NSMutableArray alloc] init];
//    Conference *conference = nil;
//    for(int i = 0; i < [dataSource count]; i++) {
//        conference = [Conference conferenceByDictionary:[dataSource objectAtIndex:i]];
//        [productsArray addObject:conference];
//        conference = nil;
//    }
    return productsArray;
}


/**
 *	@brief	根据dataSource数组返回封装好的通知对象数组
 *
 *	@param 	dataSource{ 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	通知对象数组
 */
+ (NSArray *)noticesProductsByDataSourceArray:(NSArray *)dataSource {
    NSMutableArray *productsArray = [[NSMutableArray alloc] init];
//    Notice *notice = nil;
//    for(int i = 0;i < [dataSource count]; i++)
//    {
//        notice = [Notice noticeByDictionary:[dataSource objectAtIndex:i]];
//        [productsArray addObject:notice];
//        notice = nil;
//    }
    return productsArray;
}



///*--------------------------------------------------------------------------------------------------------------------
// 描述：    根据dataSource数组返回封装好的通议程对象数组
// 参数：    dataSource -- 从模型加工中心返回的数据对象属性字典的数组
// 返回值： 议程对象数组
// --------------------------------------------------------------------------------------------------------------------*/
//+ (NSArray *)agendaProductsByDataSourceArray:(NSArray *)dataSource {
//    NSMutableArray *productsArray = [[[NSMutableArray alloc]init]autorelease];
//    Agenda *agenda = nil;
//    for(int i = 0; i < [dataSource count]; i++)
//    {
//        agenda = [Agenda agendaByDictionary:[dataSource objectAtIndex:i]];
//        [productsArray addObject:agenda];
//        agenda = nil;
//    }
//    return productsArray;
//}



/**
 *	@brief	根据dataSource数组返回封装好的文件对象数组
 *
 *	@param 	dataSource	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	文件对象数组
 */
+ (NSArray *)materialsProductsByDataSourceArray:(NSArray *)dataSource {
    NSMutableArray *productsArray = [[NSMutableArray alloc] init];
//    Material *material = nil;
//    for(int i = 0; i < [dataSource count]; i++) {
//        material = [Material materialByDictionary:[dataSource objectAtIndex:i]];
//        [productsArray addObject:material];
//        material = nil;
//    }
    return productsArray;
}


/**
 *	@brief	根据dataSource数组返回封装好的议程对象数组
 *
 *	@param 	dataSource 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	议程对象数组
 */
+ (NSArray *)agendasAndMaterialsProductsByDataSourceArray:(NSArray *)dataSource {
  NSMutableArray *productsArray = [[NSMutableArray alloc]init];
//  Agenda *agenda = nil;
//  for(int i = 0; i < [dataSource count]; i++)
//    {
//    agenda = [Agenda agendaByDictionary:[dataSource objectAtIndex:i]];
//    [productsArray addObject:agenda];
//    agenda = nil;
//    }
  return productsArray;
}


/**
 *	@brief	根据dataSource数组返回封装好的个人文件对象数组
 *
 *	@param 	dataSource 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	个人文件对象数组
 */
+ (NSArray *)personalDocProductsByDataSourceArray:(NSArray *)dataSource {
    NSMutableArray *productsArray = [[NSMutableArray alloc]init];
//    Material *material = nil;
//    for(int i = 0; i < [dataSource count]; i++) {
//        material = [Material materialByDictionary:[dataSource objectAtIndex:i]];
//        [productsArray addObject:material];
//        material = nil;
//    }
    return productsArray;
}


/**
 *	@brief	根据dataSource数组返回封装好的日常文件对象数组
 *
 *	@param 	dataSource 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	日常文件对象数组
 */
+ (NSArray *)dailyDocProductsByDataSourceArray:(NSArray *)dataSource {
    NSMutableArray *productsArray = [[NSMutableArray alloc]init];
//    Material *material = nil;
//    for(int i = 0; i < [dataSource count]; i++) {
//        material = [Material materialByDictionary:[dataSource objectAtIndex:i]];
//        [productsArray addObject:material];
//        material = nil;
//    }
    return productsArray;
}


/**
 *	@brief	根据dataSource数组返回封装好的秘书对象数组
 *
 *	@param 	dataSource 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	秘书对象数组
 */
+ (NSArray *)secretariesProductsByDataSourceArray:(NSArray *)dataSource {
    NSMutableArray *productsArray = [[NSMutableArray alloc] init];
//    Secretary *secretary = nil;
//    for(int i = 0;i < [dataSource count] ; i++) {
//        secretary = [Secretary secretaryByDictionary:[dataSource objectAtIndex:i]];
//        [productsArray addObject:secretary];
//        secretary = nil;
//    }
    return productsArray;
}


/**
 *	@brief	根据dataSource数组返回封装好的文件url地址对象数组
 *
 *	@param 	dataSource 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	文件url地址对象数组
 */
+ (NSArray *)materialURLArrayByDataSourceArray:(NSArray *)dataSource {
  NSMutableArray *productsArray = [[NSMutableArray alloc] init];
//  MaterialURL *materialURl = nil;
//  for (int i = 0; i < [dataSource count]; i++) {
//    materialURl = [MaterialURL materialURLByDictionary:[dataSource objectAtIndex:i]];
//    [productsArray addObject:materialURl];
//    materialURl = nil;
//  }
  return productsArray;
}


/**
 *	@brief	根据dataSource数组返回封装好的历史会议委员会对象数组
 *
 *	@param 	dataSource 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	历史会议委员会对象数组
 */
+ (NSArray *)councilsArrayByDataSourceArray:(NSArray *)dataSource {
  NSMutableArray *productsArray = [[NSMutableArray alloc] init];
//  Council *council = nil;
//  for (int i = 0; i < [dataSource count]; i++) {
//    council = [Council councilByDictionary:[dataSource objectAtIndex:i]];
//    [productsArray addObject:council];
//    council = nil;
//  }
  return productsArray;
}


#pragma mark --- V2.0新增接口
/**
 *	@brief	根据dataSource数组返回封装好的组织机构对象数组
 *
 *	@param 	dataSource 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	组织机构对象数组
 */
+ (NSArray *)groupsArrayByDataSourceArray:(NSArray *)dataSource {
  NSMutableArray *productsArray = [[NSMutableArray alloc] init];
//  Group *group = nil;
//  for (int i = 0; i < [dataSource count]; i++) {
//    group = [Group groupByDictionary:[dataSource objectAtIndex:i]];
//    [productsArray addObject:group];
//    group = nil;
//  }
  return productsArray;
}

/**
 *	@brief	根据dataSource数组返回封装好的组织机构对象数组
 *
 *	@param 	dataSource 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	组织机构对象数组
 */
+ (NSArray *)deletedInfosArrayByDataSourceArray:(NSArray *)dataSource {
  NSMutableArray *productsArray = [[NSMutableArray alloc] init];
//  DeletedInfo *deletedInfo = nil;
//  for (int i = 0; i < [dataSource count]; i++) {
//    deletedInfo = [DeletedInfo deletedInfoByDictionary:[dataSource objectAtIndex:i]];
//    [productsArray addObject:deletedInfo];
//    deletedInfo = nil;
//  }
  return productsArray;
}

/**
 *	@brief	根据dataSource数组返回封装好的投票议案对象数组
 *
 *	@param 	dataSource 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	投票议案对象数组
 */
//+ (NSArray *)votingProposalsArrayByDataSourceArray:(NSArray *)dataSource {
//  NSMutableArray *productsArray = [[[NSMutableArray alloc] init] autorelease];
//
//  NSMutableArray *authorizedList = [[dataSource objectAtIndex:0] objectForKey:@"authorizedList"];
//  NSMutableArray *proposalList = [[dataSource objectAtIndex:0] objectForKey:@"proposalList"];
//
//  VotingProposal *votingProposal = nil;
//
//  if (![authorizedList isKindOfClass:[NSNull class]]) {
//    for (int i = 0; i < [authorizedList count]; i++) {
//      votingProposal = [VotingProposal votingProposalByDictionary:[authorizedList objectAtIndex:i]];
//      [productsArray addObject:votingProposal];
//      votingProposal = nil;
//    }
//  }
//  if (![proposalList isKindOfClass:[NSNull class]]) {
//    for (int i = 0; i < [proposalList count]; i++) {
//      votingProposal = [VotingProposal votingProposalByDictionary:[proposalList objectAtIndex:i]];
//      [productsArray addObject:votingProposal];
//      votingProposal = nil;
//    }
//  }
//  return productsArray;
//}

/**
 *	@brief	根据dataSource数组返回封装好的目录对象数组
 *
 *	@param 	dataSource 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	目录对象数组
 */
//+ (NSArray *)directoriesArrayByDataSourceArray:(NSArray *)dataSource {
//  NSMutableArray *productsArray = [[[NSMutableArray alloc] init] autorelease];
//  FileDirectory *directory = nil;
//  for (int i = 0; i < [dataSource count]; i++) {
//    directory = [FileDirectory directoryByDictionary:[dataSource objectAtIndex:i]];
//    [productsArray addObject:directory];
//    directory = nil;
//  }
//  return productsArray;
//}

/**
 *	@brief	根据dataSource数组返回封装好的会议排期对象数组
 *
 *	@param 	dataSourec 	从模型加工中心返回的数据对象属性字典的数组
 *
 *	@return	会议排期对象数组
 */
+ (NSArray *)scheduleArrayByDataSourceArray:(NSArray *)dataSource {
  NSMutableArray *productsArray = [[NSMutableArray alloc] init];
  Schedule *schedule = nil;
  for (int i = 0; i < [dataSource count]; i++) {
    schedule = [Schedule scheduleByDictionary:[dataSource objectAtIndex:i]];
    [productsArray addObject:schedule];
    schedule = nil;
  }
  NSLog(@"productsArray = %@",productsArray);
  return productsArray;
}



@end
