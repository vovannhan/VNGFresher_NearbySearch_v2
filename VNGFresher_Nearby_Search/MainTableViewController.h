//
//  MainTableViewController.h
//  VNGFresher_Nearby_Search
//
//  Created by NhanVo on 12/27/15.
//  Copyright © 2015 NhanVo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewController : UITableViewController
@property (nonatomic, strong) NSArray *test_arr;
@property (nonatomic, strong) NSMutableDictionary *arr_Json;
@property (nonatomic, strong) NSMutableArray *arr_Result;
@property (nonatomic, strong) NSMutableArray *arr_Name;
@property (nonatomic, strong) NSMutableArray *arr_Photo;
@property (nonatomic, strong) NSMutableArray *arr_Place_ID;
@property (nonatomic, strong) NSMutableArray *arr_Detail_link;
@property (nonatomic, strong) NSMutableDictionary *test_detail;

-(void)retrive_Data;
@end
