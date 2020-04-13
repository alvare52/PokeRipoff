//
//  JLAStatsViewController.m
//  PokeRipoff
//
//  Created by Jorge Alvarez on 4/12/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

#import "JLAStatsViewController.h"
#import "JLABattleViewController.h"
#import "JLAPokemon.h"

@interface JLAStatsViewController ()

@end

@implementation JLAStatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", MYGlobalVariable);

    NSLog(@"%@", MYEnemyGlobal.name);
    NSLog(@"%@", MYEnemyGlobal.identifier);
    NSLog(@"%@", MYEnemyGlobal.sprite);
    NSLog(@"%@", MYEnemyGlobal.backSprite);
    NSLog(@"%@", MYEnemyGlobal.abilities);
    NSLog(@"%@", MYEnemyGlobal.moves);
    NSLog(@"%@", MYEnemyGlobal.stats);
    NSLog(@"%@", MYEnemyGlobal.types);

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
