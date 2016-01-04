//
//  infoViewController.m
//  VNGFresher_Nearby_Search
//
//  Created by NhanVo on 1/2/16.
//  Copyright © 2016 NhanVo. All rights reserved.
//

#import "infoViewController.h"
#import "MMPickerView.h"
#import "SettingTableViewCell.h"
#import "MainTableViewController.h"

@interface infoViewController ()

@end

@implementation infoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btn_update.layer.cornerRadius = 10;
    self.radius_value = [NSNumber numberWithInt:500];
    self.arr_radius = @[@"500",@"1000",@"2000",@"3000",@"5000"];
    self.arr_types = @[@"All",@"Bus",@"Food",@"Drink",@"Hotel",@"Bank",@"ATM",@"Police",@"Health"];
    
    self.dic_chose_type = @{
                            @"Food" : @"food",
                            @"ATM"  : @"atm",
                            @"Hotel": @"lodging",
                            @"Bank" : @"bank",
                            @"Drink": @"cafe",
                            @"Bus"  : @"bus_station",
                            @"Police": @"police",
                            @"Health" : @"health"
                            };
    
    CGRect tableviewFrame = CGRectMake(0.0, 30, self.setting_tableview.frame.size.width ,self.setting_tableview.frame.size.height);
    
//    UIView *tableView_view = [[UIView alloc] initWithFrame:tableviewFrame];
    self.setting_tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.setting_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.setting_tableview.frame = tableviewFrame;
    self.setting_tableview.backgroundColor = [UIColor colorWithRed:242./255 green:234./255 blue:220./255 alpha:1];
    //[tableView_view addSubview:self.setting_tableview];
    
//    UIView *backgroundView = [[UIView alloc] initWithFrame:frame];
//    [backgroundView setBackgroundColor:[[UIColor alloc] initWithRed:204./255 green:0./255 blue:216./255 alpha:0.5]];
    //[backgroundView addSubview:tableView_view];
    
    //[self.view addSubview:backgroundView];
    self.setting_tableview.scrollEnabled = NO;
    
    [self.view addSubview:self.setting_tableview];
    [self.view setBackgroundColor:[UIColor colorWithRed:242./255 green:234./255 blue:220./255 alpha:1.0]];
    //[self.view setBackgroundColor:[UIColor redColor]];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"Chọn bán kính tìm kiếm";
    } else {
        return @"Chọn loại cần tìm kiếm";
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    NSString *SimpleIdentifier = @"SimpleIdentifer";
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleIdentifier];
    
    if (cell == nil) {
        cell = [[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleIdentifier];
    }

    if (indexPath.section == 0) {
        //cell.textLabel.text = @"Ban kinh tim kiem cua ban la ";
        cell.lbl_leftvalue.text = @"Bán kính";
        cell.lbl_rightvalue.text = [NSString stringWithFormat:@"%@ m",self.current_radius];
    } else {
        cell.lbl_leftvalue.text = @"Loại";
        cell.lbl_rightvalue.text = self.current_type;
    }

    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 20)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    /* Section header is in 0th index... */
    NSString *string1 = @"Lựa chọn bán kính tìm kiếm";
    NSString *string2 = @"Lựa chọn loại vị trí tìm kiếm";
    if (section == 0) {
        [label setText:string1];
    } else {
        [label setText:string2];
    }
    
    [view addSubview:label];
    //[view setBackgroundColor:[UIColor colorWithRed:0/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger sectionindex = indexPath.section;    
    if (sectionindex == 1) {
        [MMPickerView showPickerViewInView:self.view
                               withStrings:self.arr_types
                               withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                             MMtextColor: [UIColor blackColor],
                                             MMtoolbarColor: [UIColor whiteColor],
                                             MMbuttonColor: [UIColor blueColor],
                                             MMfont: [UIFont systemFontOfSize:18],
                                             MMvalueY: @3,
                                             MMselectedObject:self.current_type,
                                             MMtextAlignment:@1}
                                completion:^(NSString *selectedString) {
                                    
                                    //self.selected_string.text = selectedString;
                                    self.current_type = selectedString;
                                    [self.setting_tableview reloadData];
                                }];
        
        
    }
    
    if (sectionindex == 0) {
        [MMPickerView showPickerViewInView:self.view
                               withStrings:self.arr_radius
                               withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                             MMtextColor: [UIColor blackColor],
                                             MMtoolbarColor: [UIColor whiteColor],
                                             MMbuttonColor: [UIColor blueColor],
                                             MMfont: [UIFont systemFontOfSize:18],
                                             MMvalueY: @3,
                                             MMselectedObject:self.current_radius,
                                             MMtextAlignment:@1}
                                completion:^(NSString *selectedString) {
                                    
                                    //self.selected_string.text = selectedString;
                                    self.current_radius = selectedString;
                                    [self.setting_tableview reloadData];
                                }];
        
        
    }
}



- (IBAction)btn_update:(id)sender {
    
    
    MainTableViewController * custom =
    self.navigationController.viewControllers[self.navigationController.viewControllers.count - 2] ;
    
    custom.cur_radius = self.current_radius;
    custom.cur_types = self.current_type;
    [custom retrive_Data];
    [custom.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
