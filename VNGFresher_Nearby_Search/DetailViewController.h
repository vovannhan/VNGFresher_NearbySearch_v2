//
//  DetailViewController.h
//  VNGFresher_Nearby_Search
//
//  Created by NhanVo on 12/27/15.
//  Copyright © 2015 NhanVo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSString *link_text;
@property (strong, nonatomic) NSString *photo_reference;
@property (strong, nonatomic) NSString *photo_link;
@property (strong, nonatomic) NSString *link_detail;
@property (strong, nonatomic) NSDictionary *json_detail;
@property (strong, nonatomic) NSDictionary *result_detail;

#pragma mark UI Element

@property (strong, nonatomic) IBOutlet UIImageView *img_Avar;

@property (strong, nonatomic) IBOutlet UILabel *lbl_name;

@property (strong, nonatomic) IBOutlet UILabel *lbl_website;

@property (strong, nonatomic) IBOutlet UILabel *lbl_phonenumber;

@end
