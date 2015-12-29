//
//  MainTableViewCell.m
//  VNGFresher_Nearby_Search
//
//  Created by NhanVo on 12/27/15.
//  Copyright © 2015 NhanVo. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)load_cell_data {
    self.lbl_place_name.text = self.place_name;
    //self.lbl_place_id.text = self.place_id;
}

@end
