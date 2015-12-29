//
//  MainTableViewCell.h
//  VNGFresher_Nearby_Search
//
//  Created by NhanVo on 12/27/15.
//  Copyright © 2015 NhanVo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lbl_place_name;

@property (strong, nonatomic) NSString *place_name;
@property (strong, nonatomic) NSString *place_id;

@property (strong, nonatomic) IBOutlet UIImageView *img_icon;

@property (strong, nonatomic) IBOutlet UIImageView *img_location;

@property (strong, nonatomic) IBOutlet UILabel *img_distance;

@property (strong, nonatomic) IBOutlet UILabel *lbl_type;

@property (strong, nonatomic) IBOutlet UIImageView *img_type;
-(void)load_cell_data;


@end
