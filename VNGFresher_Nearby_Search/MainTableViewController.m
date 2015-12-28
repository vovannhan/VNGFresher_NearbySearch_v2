//
//  MainTableViewController.m
//  VNGFresher_Nearby_Search
//
//  Created by NhanVo on 12/27/15.
//  Copyright © 2015 NhanVo. All rights reserved.
//

#import "MainTableViewController.h"
#import "DetailViewController.h"
#import "MainTableViewCell.h"

#define API_KEY @"AIzaSyCy3zsPTh8UfIkq5gHYtPXGc0f-w7Nzfmc"
#define getDataURL @"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=5000&types=food&key=AIzaSyCy3zsPTh8UfIkq5gHYtPXGc0f-w7Nzfmc"

@interface MainTableViewController () {
    NSMutableArray *arr_Photo_link;
}

@end

@implementation MainTableViewController

#pragma mark Synthesize
@synthesize arr_Json, arr_Name, arr_Result, arr_Photo, arr_Place_ID,arr_Detail_link,test_detail;

- (void)viewDidLoad {
    [super viewDidLoad];
    //arr_Photo = [[NSMutableArray alloc] init];
    self.navigationItem.title = @"Tìm kiếm quanh đây";
    [self retrive_Data];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arr_Name.count ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    NSString *identifier = @"Cell";
//    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    
//    cell = [[MainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        
//        
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.place_name = arr_Name[indexPath.row];
        cell.place_id = arr_Place_ID[indexPath.row];
        [cell load_cell_data];
    //NSString *temp = [NSString stringWithFormat:@"%@\n---%@",arr_Name[indexPath.row],arr_Place_ID[indexPath.row]];
    // Configure the cell...

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Data handle Methods

-(void)retrive_Data {
    NSURL *url = [NSURL URLWithString:getDataURL];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    arr_Json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    arr_Result = [arr_Json objectForKey:@"results"];
    
    arr_Name  = [[NSMutableArray alloc] init];
    
    arr_Photo = [[NSMutableArray alloc] init ];
    
    arr_Place_ID = [[NSMutableArray alloc] init];
    arr_Detail_link = [[NSMutableArray alloc] init];
    
    for (int i = 0 ; i < arr_Result.count; i++) {
        NSString * p_Name = [[arr_Result objectAtIndex:i] objectForKey:@"name"];
        NSString * p_NameOfList = [NSString stringWithFormat:@"%i----%@", i,p_Name];
        [arr_Name addObject:p_NameOfList];
        
    }
    
    for (int i = 0; i < arr_Result.count; i++) {
        NSArray* arr_Photo_info = [[arr_Result objectAtIndex:i] objectForKey:@"photos"];
        
        NSDictionary *dic_photo_info = [arr_Photo_info objectAtIndex:0];
        
        NSString *link_photo = [dic_photo_info objectForKey:@"photo_reference"];
        
        NSLog(@"%@",link_photo);
        
        if (link_photo != nil) {
            [arr_Photo addObject:link_photo];
        } else {
            [arr_Photo addObject:@"unknown"];
        }
    }
    
    for (int i = 0; i< arr_Result.count; i++) {
        NSString *place_id = [[arr_Result objectAtIndex:i] objectForKey:@"place_id"];
        [arr_Place_ID addObject:place_id];
        
        NSString *detail_link = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=%@",place_id,API_KEY];
        [arr_Detail_link addObject:detail_link];
    }
    
    NSURL *url2 = [NSURL URLWithString:arr_Detail_link[1]];
    
    NSData *data2 = [NSData dataWithContentsOfURL:url2];
    
    test_detail= [NSJSONSerialization JSONObjectWithData:data2 options:kNilOptions error:nil];

    
    [self.tableView reloadData];
    
    

}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"pushDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        DetailViewController *push_view = segue.destinationViewController;
        push_view.photo_reference = arr_Photo[indexPath.row];
        push_view.link_detail = arr_Detail_link[indexPath.row];
        //push_view.lbl_test.text = self.test_arr[indexPath.row];
    }
    
}










@end
