//
//  MainTableViewCell.h
//  VNGFresher_Nearby_Search
//
//  Created by NhanVo on 12/27/15.
//  Copyright © 2015 NhanVo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lbl_place_id;

@property (strong, nonatomic) IBOutlet UILabel *lbl_place_name;

@property (strong, nonatomic) NSString *place_name;
@property (strong, nonatomic) NSString *place_id;
-(void)load_cell_data;


@end
