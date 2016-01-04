//
//  infoViewController.h
//  VNGFresher_Nearby_Search
//
//  Created by NhanVo on 1/2/16.
//  Copyright © 2016 NhanVo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface infoViewController : UIViewController<UITabBarControllerDelegate,UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *setting_tableview;


@property (strong, nonatomic) IBOutlet UIButton *btn_update;
@property (strong, nonatomic) NSNumber *radius_value;
@property (strong, nonatomic) NSString *current_type;
@property (strong, nonatomic) NSArray *arr_types;
@property (strong, nonatomic) NSArray *arr_radius;
@property (strong, nonatomic) NSString *current_radius;
@property (strong, nonatomic) NSDictionary *dic_chose_type;

@end
