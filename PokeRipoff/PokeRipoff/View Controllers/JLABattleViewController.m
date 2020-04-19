//
//  JLABattleViewController.m
//  PokeRipoff
//
//  Created by Jorge Alvarez on 4/11/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

#import "JLABattleViewController.h"
#import "PokeRipoff-Swift.h"
#import "JLAPokemon.h"
#import "JLAStatsViewController.h"

NSString *MYGlobalVariable = @"Hello";
JLAPokemon *MYEnemyGlobal = nil;

@interface JLABattleViewController ()

// MARK: - Outlets
@property (strong, nonatomic) IBOutlet UIImageView *enemyImageView;
- (IBAction)changeEnemy:(UIBarButtonItem *)sender;


@property (nonatomic) JLAPokemon *enemy;
@property (nonatomic) JLAPokemon *ally;

@end

@implementation JLABattleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    JLAPokemon *testGlobal = [[JLAPokemon alloc] initWithName:@"Gengar"
                                                   identifier:@94
                                                       sprite:@"spriteURL"
                                                   backSprite:@"backSpriteURL"
                                                    abilities:@[@1]
                                                        moves:@[@2]
                                                        stats: @[@3]
                                                        types:@[@4]];
    MYEnemyGlobal = testGlobal;
    NSLog(@"%@", MYGlobalVariable);
    
    NSLog(@"%@", MYEnemyGlobal.name);
    NSLog(@"%@", MYEnemyGlobal.identifier);
    NSLog(@"%@", MYEnemyGlobal.sprite);
    NSLog(@"%@", MYEnemyGlobal.backSprite);
    NSLog(@"%@", MYEnemyGlobal.abilities);
    NSLog(@"%@", MYEnemyGlobal.moves);
    NSLog(@"%@", MYEnemyGlobal.stats);
    NSLog(@"%@", MYEnemyGlobal.types);
    
    //[self fetchEnemy];
}

- (void)fetchEnemy {
    
    NSLog(@"called fetchEnemy in battleVC");
    
    [[APIController sharedController] fetchRandomPokemonWithCompletion:^(JLAPokemon *result, NSError *error) {
        
        self.enemy = result;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", self.enemy);
            //[self.tableView reloadData];
            [self fetchEnemyImage];
        });
    }];
}

- (void)fetchEnemyImage {
    
    NSLog(@"called fetchEnemyImage in battleVC");
    
    [[APIController sharedController] fetchImageAt:self.enemy.sprite completion:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"frontImage BEFORE = %@", MYEnemyGlobal.frontImage);
            [MYEnemyGlobal setFrontImage:image];
            self.enemyImageView.image = MYEnemyGlobal.frontImage;
            NSLog(@"frontImage AFTER = %@", MYEnemyGlobal.frontImage);
            NSLog(@"backImage = %@", MYEnemyGlobal.backImage);
        });
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// MARK: - Actions

- (IBAction)changeEnemy:(UIBarButtonItem *)sender {
    [self fetchEnemy];
}
@end
