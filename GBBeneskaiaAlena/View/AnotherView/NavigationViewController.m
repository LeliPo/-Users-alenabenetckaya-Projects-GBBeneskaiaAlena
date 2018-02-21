//
//  NavigationViewController.m
//  GBBeneskaiaAlena
//
//  Created by  Алёна Бенецкая on 03.02.2018.
//  Copyright © 2018  Алёна Бенецкая. All rights reserved.
//

#import "NavigationViewController.h"
#import "AnotherViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openAnotherViewController
{
    AnotherViewController *anotherViewController = [[AnotherViewController alloc] init];
    // Используя контроллер навигации
    [self.navigationController showViewController:anotherViewController sender:self];
    // или
    [self.navigationController pushViewController:anotherViewController animated:YES];
    // Модально
    [self presentViewController:anotherViewController animated:YES completion:nil];
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
