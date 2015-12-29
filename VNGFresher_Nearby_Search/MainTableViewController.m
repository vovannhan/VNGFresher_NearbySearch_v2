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
#import <CoreLocation/CoreLocation.h>

#define API_KEY @"AIzaSyCy3zsPTh8UfIkq5gHYtPXGc0f-w7Nzfmc"
#define getDataURL @"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=5000&key=AIzaSyCy3zsPTh8UfIkq5gHYtPXGc0f-w7Nzfmc"

@interface MainTableViewController ()<CLLocationManagerDelegate> {
    
    NSMutableArray *arr_Photo_link;
    CLLocationManager *location_manager;
    CLGeocoder *geocoder;
    
    //Array for load icon.
    NSArray *iconarr_car;
    NSArray *iconarr_money;
    NSArray *iconarr_air;
    NSArray *iconarr_store;
    NSArray *iconarr_movie;
    NSArray *iconarr_church;
    NSArray *iconarr_station;
    NSArray *iconarr_food;
    NSArray *iconarr_edu;
    NSArray *iconarr_heal;
    NSArray *iconarr_hotel;
    NSArray *iconarr_zoo;
    NSArray *iconarr_spa;
    NSArray *iconarr_funeral;
    NSArray *iconarr_toy;
    NSArray *iconarr_museum;
    NSArray *iconarr_liquor;
    NSArray *iconarr_machine;
    NSArray *iconarr_book;
    NSArray *iconarr_job;
    NSArray *iconarr_bank;
    NSArray *iconarr_hall;
    NSArray *iconarr_police;
    
    
    CLLocation *current_location;
    
    int num_of_page;//Kiem tra so page
}

@end

@implementation MainTableViewController

#pragma mark Synthesize
@synthesize arr_Json, arr_Name, arr_Result, arr_Photo, arr_Place_ID,arr_Detail_link,arr_distance,arr_type,arr_nextpage;

- (void)viewDidLoad {
    [super viewDidLoad];
    //arr_Photo = [[NSMutableArray alloc] init];
    iconarr_car = @[@"car_dealer",@"car_rental",@"car_repair",@"car_wash"];
    iconarr_money = @[@"acounting",@"atm",@"casino",@"finance"];
    iconarr_air = @[@"airport"];
    iconarr_store = @[@"bicycle_store",@"book_store",@"store",@"shoe_store",@"furniture_store",@"department_store",@"clothing_store",@"convenience_store",@"hardware_store",@"home_goods_store",@"jewelry_store"];
    iconarr_movie = @[@"movie_rental",@"movie_theater",@"moving_company"];
    iconarr_church = @[@"mosque",@"church",@"hindu_temple",@"synagogue"];
    iconarr_station = @[@"bus_station",@"gas_station",@"subway_station",@"train_station",@"travel_agency",@"taxi_stand"];
    iconarr_food = @[@"bakery",@"food",@"restaurant",@"meal_delivery",@"meal_takeaway",@"cafe"];
    iconarr_edu = @[@"school",@"university"];
    iconarr_heal = @[@"dentist",@"doctor",@"health",@"hospital",@"gym",@"pharmacy",@"physiotherapist"];
    iconarr_hotel = @[@"lodging"];
    iconarr_zoo = @[@"zoo",@"veterinary_care",@"pet_store"];
    iconarr_spa = @[@"hair_care",@"spa",@"beauty_salon"];
    iconarr_funeral = @[@"funeral_home",@"cemetery"];
    iconarr_toy = @[@"amusement_park",@"campground",@"bowling_alley",@"point_of_interest"];
    iconarr_museum = @[@"art_gallery",@"museum",@"painter"];
    iconarr_liquor = @[@"liquor_store",@"night_club",@"bar"];
    iconarr_machine = @[@"plumber",@"storage",@"roofing_contractor",@"place_of_worship",@"locksmith",@"electrician",@"electronics_store"];
    iconarr_book = @[@"book",@"library"];
    iconarr_job = @[@"insurance_agency",@"laundry",@"lawyer",@"post_office",@"embass"];
    iconarr_air = @[@"bank"];
    iconarr_hall = @[@"city_hall",@"establishment",@"local_government_office",@"shopping_mall"];
    iconarr_police = @[@"police"];
    
    
    
    
    
    
    num_of_page = 0;
    
    
    arr_nextpage = [[NSMutableArray alloc] init];
    self.navigationItem.title = @"Tìm kiếm quanh đây";
    location_manager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    
    location_manager.delegate = self;
    location_manager.desiredAccuracy  = kCLLocationAccuracyBest;
    [location_manager requestWhenInUseAuthorization];
    
    [location_manager startUpdatingLocation];
//    NSLog(@"%@",self.longtude);
//    
//    [self retrive_Data];
    
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
//    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    
//    cell = [[MainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        
//        
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.place_name = arr_Name[indexPath.row];
    //cell.place_id = arr_Place_ID[indexPath.row];
    
    cell.img_location.image = [UIImage imageNamed:@"location2.png"];
    cell.img_distance.text = arr_distance[indexPath.row];
    cell.lbl_type.text = arr_type[indexPath.row];
    cell.img_type.image = [UIImage imageNamed:@"info.png"];
    [cell load_cell_data];
    
    NSString *type = arr_type[indexPath.row];
    
    if ([iconarr_car containsObject:type]) {
        cell.img_icon.image = [UIImage imageNamed:@"car_icon.png"];
    } else if ([iconarr_edu containsObject:type]) {
        cell.img_icon.image = [UIImage imageNamed:@"education.png"];
    }else if ([iconarr_store containsObject:type]) {
        cell.img_icon.image = [UIImage imageNamed:@"store.png"];
    }else if ([iconarr_food containsObject:type]) {
        cell.img_icon.image = [UIImage imageNamed:@"food.png"];
    }else if ([iconarr_money containsObject:type]) {
        cell.img_icon.image = [UIImage imageNamed:@"dola.png"];
    }else if ([iconarr_hotel containsObject:type]) {
        cell.img_icon.image = [UIImage imageNamed:@"hotel.png"];
    }else if ([iconarr_bank containsObject:type]) {
        cell.img_icon.image = [UIImage imageNamed:@"bank.png"];
    }else if ([iconarr_heal containsObject:type]) {
        cell.img_icon.image = [UIImage imageNamed:@"health.jpg"];
    }else if ([iconarr_station containsObject:type]) {
        cell.img_icon.image = [UIImage imageNamed:@"station.jpg"];
    }else if ([iconarr_liquor containsObject:type]) {
        cell.img_icon.image = [UIImage imageNamed:@"liquor.png"];
    }else if ([iconarr_movie containsObject:type]) {
        cell.img_icon.image = [UIImage imageNamed:@"movie.png"];
    }else if ([iconarr_toy containsObject:type]) {
        cell.img_icon.image = [UIImage imageNamed:@"toy.png"];
    }else if ([iconarr_spa containsObject:type]) {
        cell.img_icon.image = [UIImage imageNamed:@"spa.png"];
    }else if ([iconarr_church containsObject:type]) {
        cell.img_icon.image = [UIImage imageNamed:@"church.png"];
    }else if ([iconarr_book containsObject:type]) {
        cell.img_icon.image = [UIImage imageNamed:@"book.png"];
    }else if ([iconarr_funeral containsObject:type]) {
        cell.img_icon.image = [UIImage imageNamed:@"cemetery.png"];
    }else if ([iconarr_zoo containsObject:type]) {
        cell.img_icon.image = [UIImage imageNamed:@"zoo.jpg"];
    }else if ([iconarr_job containsObject:type]) {
        cell.img_icon.image = [UIImage imageNamed:@"job.png"];
    }else if ([iconarr_machine containsObject:type]) {
        cell.img_icon.image = [UIImage imageNamed:@"machine.png"];
    }else if ([iconarr_air containsObject:type]) {
        cell.img_icon.image = [UIImage imageNamed:@"airport.jpg"];
    }else if ([iconarr_hall containsObject:type]) {
        cell.img_icon.image = [UIImage imageNamed:@"building.png"];
    }else if ([iconarr_police containsObject:type]) {
        cell.img_icon.image = [UIImage imageNamed:@"police.png"];
    }else {
        cell.img_icon.image = [UIImage imageNamed:@"defaul.png"];
    }
    
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:arr_icon_link[indexPath.row]]];
//        
//        if (data == nil) {
//            return;
//        }
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            cell.img_icon.image = [UIImage imageWithData:data];
//        });
//    });

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
    NSString *str_tempurl = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@,%@&radius=5000&key=AIzaSyCy3zsPTh8UfIkq5gHYtPXGc0f-w7Nzfmc",[self.lattude stringValue],[self.longtude stringValue]];
    NSURL *url = [NSURL URLWithString:str_tempurl];
    
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    current_location = [[CLLocation alloc] initWithLatitude:[self.lattude floatValue]longitude:[self.longtude floatValue]];
    
    arr_Json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    arr_Result      = [arr_Json objectForKey:@"results"];
    
    arr_Name        = [[NSMutableArray alloc] init];
    
    arr_Photo       = [[NSMutableArray alloc] init ];
    
    arr_Place_ID    = [[NSMutableArray alloc] init];
    arr_Detail_link = [[NSMutableArray alloc] init];
    arr_distance    = [[NSMutableArray alloc] init];
    arr_type        = [[NSMutableArray alloc] init];
    
    NSString *temp_nextpage_token = [arr_Json objectForKey:@"next_page_token"];
    
    [arr_nextpage addObject:temp_nextpage_token];
    
    
    
    for (int i = 0 ; i < arr_Result.count; i++) {
        NSString * p_Name = [[arr_Result objectAtIndex:i] objectForKey:@"name"];
        NSMutableArray *list_types = [[arr_Result objectAtIndex:i] objectForKey:@"types"];
        NSString *temp_type = list_types[0];
        //NSString * p_NameOfList = [NSString stringWithFormat:@"%i----%@", i,p_Name];
        [arr_Name addObject:p_Name];
        [arr_type addObject:temp_type];
    }
    
    for (int i = 0; i < arr_Result.count; i++) {
        NSArray* arr_Photo_info = [[arr_Result objectAtIndex:i] objectForKey:@"photos"];
        
        NSDictionary *dic_photo_info = [arr_Photo_info objectAtIndex:0];
        
        NSString *link_photo = [dic_photo_info objectForKey:@"photo_reference"];
        
        if (link_photo != nil) {
            [arr_Photo addObject:link_photo];
        } else {
            [arr_Photo addObject:@"unknown"];
        }
        
        NSString *place_id = [[arr_Result objectAtIndex:i] objectForKey:@"place_id"];
        [arr_Place_ID addObject:place_id];
        
        
        NSString *detail_link = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=%@",place_id,API_KEY];
        [arr_Detail_link addObject:detail_link];
        
        NSDictionary *dic_temp_location = [[[arr_Result objectAtIndex:i] objectForKey:@"geometry"]objectForKey:@"location"];
        NSString *temp_lat = [dic_temp_location objectForKey:@"lat"];
        NSString *temp_lng = [dic_temp_location objectForKey:@"lng"];
        
        CLLocation *temp_location = [[CLLocation alloc] initWithLatitude:[temp_lat floatValue]longitude:[temp_lng floatValue]];
        
        CLLocationDistance distance = [current_location distanceFromLocation:temp_location];
        NSString *cur_distance = [NSString stringWithFormat:@"%.2f",distance/1000.0f];
        [arr_distance addObject:cur_distance];
        
    }
    
//    for (int i = 0; i< arr_Result.count; i++) {
//        NSString *place_id = [[arr_Result objectAtIndex:i] objectForKey:@"place_id"];
//        [arr_Place_ID addObject:place_id];
//        
//        
//        
//        NSString *detail_link = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=%@",place_id,API_KEY];
//        [arr_Detail_link addObject:detail_link];
//        
//        
//    }
    
//    for (int i = 0; i < arr_Result.count; i++) {
//        NSDictionary *dic_temp_location = [[[arr_Result objectAtIndex:i] objectForKey:@"geometry"]objectForKey:@"location"];
//        NSString *temp_lat = [dic_temp_location objectForKey:@"lat"];
//        NSString *temp_lng = [dic_temp_location objectForKey:@"lng"];
//        
//        CLLocation *temp_location = [[CLLocation alloc] initWithLatitude:[temp_lat floatValue]longitude:[temp_lng floatValue]];
//        
//        CLLocationDistance distance = [current_location distanceFromLocation:temp_location];
//        NSString *cur_distance = [NSString stringWithFormat:@"%.2f",distance/1000.0f];
//        [arr_distance addObject:cur_distance];
//    } xxxx

    [self.tableView reloadData];
    
}

#pragma mark - CLLocationDelegate Methods

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Eror: %@",error);
    NSLog(@"Fail to get location!");
    NSString *tittle = @"Lỗi xác định vị trí";
    NSString *message = @"Khởi động lại ứng dụng";
    NSString *okText= @"OK";
    
    UIAlertController *alertview = [UIAlertController alertControllerWithTitle:tittle message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okText style:UIAlertActionStyleCancel handler:nil];
    [alertview addAction:okAction];
    [self presentViewController:alertview animated:YES completion:nil];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    CLLocation *current_currentlocation = newLocation;
    if (current_currentlocation != nil) {
        self.lattude = [NSNumber numberWithFloat:current_currentlocation.coordinate.latitude];
        self.longtude = [NSNumber numberWithFloat:current_currentlocation.coordinate.longitude];
        [location_manager stopUpdatingLocation];
        [self retrive_Data];
    }
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


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) && (![arr_nextpage[num_of_page] isEqualToString:@"end"]))
        {
            //NSLog(@"aasssssss");
            NSString *nextpage = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?pagetoken=%@&key=%@",arr_nextpage[num_of_page],API_KEY];


            NSURL *url2 = [NSURL URLWithString:nextpage];

            NSData *data2 = [NSData dataWithContentsOfURL:url2];

            NSMutableDictionary *jsonArray2 = [NSJSONSerialization JSONObjectWithData:data2 options:kNilOptions error:nil];
            
            //test_dic = [NSJSONSerialization JSONObjectWithData:data2 options:kNilOptions error:nil];


            NSMutableArray *place_arr2 = [jsonArray2 objectForKey:@"results"];
            NSString *nextpage_token_link = [jsonArray2 objectForKey:@"next_page_token"];
            //NSString *status = [jsonArray2 objectForKey:@"status"];
            //NSLog(@"%@",nextpage_token_link);
            //NSLog(@"%@",nextpage_token_link);
            if (nextpage_token_link != nil) {
                
                [arr_nextpage addObject:nextpage_token_link];
            } else {
                [arr_nextpage addObject:@"end"];
            }
            
            for (int i = 0; i < place_arr2.count; i++) {
                NSString * p_Name = [[place_arr2 objectAtIndex:i] objectForKey:@"name"];
                NSMutableArray *list_types = [[place_arr2 objectAtIndex:i] objectForKey:@"types"];
                NSString *temp_type = list_types[0];
                //NSString * p_NameOfList = [NSString stringWithFormat:@"%i----%@", i,p_Name];
                [arr_Name addObject:p_Name];
                [arr_type addObject:temp_type];
                
                
                NSArray* arr_Photo_info = [[place_arr2 objectAtIndex:i] objectForKey:@"photos"];
                
                NSDictionary *dic_photo_info = [arr_Photo_info objectAtIndex:0];
                
                NSString *link_photo = [dic_photo_info objectForKey:@"photo_reference"];
                
                if (link_photo != nil) {
                    [arr_Photo addObject:link_photo];
                } else {
                    [arr_Photo addObject:@"unknown"];
                }
                
                
                NSString *place_id = [[place_arr2 objectAtIndex:i] objectForKey:@"place_id"];
                [arr_Place_ID addObject:place_id];
                
                NSString *detail_link = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=%@",place_id,API_KEY];
                [arr_Detail_link addObject:detail_link];
                
                
                
                NSDictionary *dic_temp_location = [[[place_arr2 objectAtIndex:i] objectForKey:@"geometry"]objectForKey:@"location"];
                NSString *temp_lat = [dic_temp_location objectForKey:@"lat"];
                NSString *temp_lng = [dic_temp_location objectForKey:@"lng"];
                
                CLLocation *temp_location = [[CLLocation alloc] initWithLatitude:[temp_lat floatValue]longitude:[temp_lng floatValue]];
                
                CLLocationDistance distance = [current_location distanceFromLocation:temp_location];
                NSString *cur_distance = [NSString stringWithFormat:@"%.2f",distance/1000.0f];
                [arr_distance addObject:cur_distance];
                
                
                
                
            }
            
            num_of_page++;
            [self.tableView reloadData];
        }
}



@end
