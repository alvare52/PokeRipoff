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
#import "JLAMove.h"

NSString *MYGlobalVariable = @"Hello";
JLAPokemon *MYEnemyGlobal = nil;
JLAPokemon *MYAllyGlobal = nil;

@interface JLABattleViewController ()

// MARK: - Outlets
@property (strong, nonatomic) IBOutlet UIImageView *enemyImageView;
@property (strong, nonatomic) IBOutlet UIImageView *allyImageView;

- (IBAction)changeEnemy:(UIBarButtonItem *)sender;

@property (strong, nonatomic) IBOutlet UILabel *enemyNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *allyNameLabel;

@property (strong, nonatomic) IBOutlet UIProgressView *enemyHpProgressView;
@property (strong, nonatomic) IBOutlet UIProgressView *allyHpProgressView;

@property (strong, nonatomic) IBOutlet UIButton *move1ButtonLabel;

@property (strong, nonatomic) IBOutlet UIButton *move2ButtonLabel;

@property (strong, nonatomic) IBOutlet UIButton *move3ButtonLabel;

@property (strong, nonatomic) IBOutlet UIButton *move4ButtonLabel;

@property (strong, nonatomic) IBOutlet UITextView *descriptionBoxLabel;

- (IBAction)healButtonTapped:(UIButton *)sender;

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
    MYAllyGlobal = testGlobal;
    
    NSLog(@"%@", MYGlobalVariable);
    [[self.descriptionBoxLabel layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.descriptionBoxLabel layer] setBorderWidth:1.0];
//    NSLog(@"%@", MYEnemyGlobal.name);
//    NSLog(@"%@", MYEnemyGlobal.identifier);
//    NSLog(@"%@", MYEnemyGlobal.sprite);
//    NSLog(@"%@", MYEnemyGlobal.backSprite);
//    NSLog(@"%@", MYEnemyGlobal.abilities);
//    NSLog(@"%@", MYEnemyGlobal.moves);
//    NSLog(@"%@", MYEnemyGlobal.stats);
//    NSLog(@"%@", MYEnemyGlobal.types);
    
    //[self fetchEnemy];
}

- (void)fetchEnemy {
    
    NSLog(@"called fetchEnemy in battleVC");
    
    // TODO: Disable buttons here, then enable again when all are ready
    
    [[APIController sharedController] fetchRandomPokemonWithCompletion:^(JLAPokemon *result, NSError *error) {
        
        self.enemy = result;
        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"%@", self.enemy);
            //[self.tableView reloadData];
            [self setEnemyLabel];
//            [self setEnemyMoves];
            [self fetchEnemyImage];
        });
    }];
}

- (void)fetchAlly {
    
    NSLog(@"called fetchAlly in battleVC");
    
    // TODO: Disable buttons here, then enable again when all are ready
    
    [[APIController sharedController] fetchRandomPokemonWithCompletion:^(JLAPokemon *result, NSError *error) {
        
        self.ally = result;
        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"%@", self.enemy);
            //[self.tableView reloadData];
            [self setAllyLabel];
            [self setAllyMoves];
            [self fetchAllyImage];
        });
    }];
}

- (void)fetchAllyImage {
    
    NSLog(@"called fetchAllyImage in battleVC, spriteURL = %@", self.ally.sprite);

    // Check if below gen 5 (these have backSprites)
    NSURL *urlToFetch = nil;
    if (self.ally.identifier.intValue > 493) {
        NSLog(@"Newer Gen, using front sprite");
        // TODO: Flip image horizontally
        urlToFetch = self.ally.sprite;
    } else {
        urlToFetch = self.ally.backSprite;
    }
    
    [[APIController sharedController] fetchImageAt:urlToFetch completion:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"frontImage BEFORE = %@", MYEnemyGlobal.frontImage);
//            [MYEnemyGlobal setFrontImage:image];
            self.allyImageView.image = image;
//            NSLog(@"frontImage AFTER = %@", MYEnemyGlobal.frontImage);
//            NSLog(@"backImage = %@", MYEnemyGlobal.backImage);
        });
    }];
}

- (void)setEnemyLabel {
//    NSInteger intValue = (NSInteger) roundf();
    NSNumber *hp = self.enemy.stats[0];
//    NSString *descriptionBox = [NSString stringWithFormat:@"HP - %@, ATK - %@, DEF - %@, SPA - %@, SPD - %@, SPE - %@",
//                                self.enemy.stats[0],
//                                self.enemy.stats[1],
//                                self.enemy.stats[2],
//                                self.enemy.stats[3],
//                                self.enemy.stats[4],
//                                self.enemy.stats[5]];
    NSString *nameText = [[self.enemy.name uppercaseString] stringByAppendingFormat:@" - %.f", floor(hp.floatValue * 4.6)];
    self.enemyNameLabel.text = nameText;
//    self.descriptionBoxLabel.text = descriptionBox;
}

- (void)setAllyLabel {
//    NSInteger intValue = (NSInteger) roundf();
    NSNumber *hp = self.ally.stats[0];
    NSString *types = self.ally.types[0];
    if (self.ally.types.count == 2) {
        types = [NSString stringWithFormat:@"%@/%@", types, self.ally.types[1]];
    }
    NSString *descriptionBox = [NSString stringWithFormat:@"HP - %@, ATK - %@, DEF - %@, SPA - %@, SPD - %@, SPE - %@. - %@",
                                self.ally.stats[0],
                                self.ally.stats[1],
                                self.ally.stats[2],
                                self.ally.stats[3],
                                self.ally.stats[4],
                                self.ally.stats[5],
                                types];
    NSString *nameText = [[self.ally.name uppercaseString] stringByAppendingFormat:@" - %.f", floor(hp.floatValue * 4.6)];
    self.allyNameLabel.text = nameText;
    self.descriptionBoxLabel.text = descriptionBox;
}

- (void)setAllyMoves {
    // TODO: make moveSet array in model to hold all of these?
    NSLog(@"setAllyMoves");
    NSLog(@"called setAllyMoves in battleVC, moves.count = %lu", self.ally.moves.count);
    
    // move1
    int random1 = arc4random_uniform(self.ally.moves.count);
    [[APIController sharedController] fetchMoveAt:self.ally.moves[random1] completion:^(JLAMove *move) {
        dispatch_async(dispatch_get_main_queue(), ^{
    
            self.ally.move1 = move;
            
//            [self.move1ButtonLabel setTitle:[self.ally.move1.name uppercaseString] forState: normal];
            NSString *moveName = [self.ally.move1.name uppercaseString];
            NSString *detailed = [NSString stringWithFormat:@"%@ - %@", moveName, self.ally.move1.power];
            [self.move1ButtonLabel setTitle: detailed forState: normal];
//            NSLog(@"move1.name = %@", self.enemy.move1.name);
//            NSLog(@"move1.power = %@", self.enemy.move1.power);
//            NSLog(@"move1.accuracy = %@", self.enemy.move1.accuracy);
//            NSLog(@"move1.damageClass = %@", self.enemy.move1.damageClass);
//            NSLog(@"move1.type = %@", self.enemy.move1.type);
        });
    }];
    
    // move2
    // TODO: pick 4 random numbers that haven't been picked yet
    int random2 = arc4random_uniform(self.ally.moves.count);
    [[APIController sharedController] fetchMoveAt:self.ally.moves[random2] completion:^(JLAMove *move) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.ally.move2 = move;
            
            NSString *moveName = [self.ally.move2.name uppercaseString];
            NSString *detailed = [NSString stringWithFormat:@"%@ - %@", moveName, self.ally.move2.power];
            [self.move2ButtonLabel setTitle: detailed forState: normal];

//            NSLog(@"move2.name = %@", self.enemy.move2.name);
//            NSLog(@"move2.power = %@", self.enemy.move2.power);
//            NSLog(@"move2.accuracy = %@", self.enemy.move2.accuracy);
//            NSLog(@"move2.damageClass = %@", self.enemy.move2.damageClass);
//            NSLog(@"move2.type = %@", self.enemy.move2.type);
        });
    }];
    
    // move3
    int random3 = arc4random_uniform(self.ally.moves.count);
    [[APIController sharedController] fetchMoveAt:self.ally.moves[random3] completion:^(JLAMove *move) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.ally.move3 = move;
            
            NSString *moveName = [self.ally.move3.name uppercaseString];
            NSString *detailed = [NSString stringWithFormat:@"%@ - %@", moveName, self.ally.move3.power];
            [self.move3ButtonLabel setTitle: detailed forState: normal];
//            NSLog(@"move3.name = %@", self.enemy.move3.name);
//            NSLog(@"move3.power = %@", self.enemy.move3.power);
//            NSLog(@"move3.accuracy = %@", self.enemy.move3.accuracy);
//            NSLog(@"move3.damageClass = %@", self.enemy.move3.damageClass);
//            NSLog(@"move3.type = %@", self.enemy.move3.type);
        });
    }];
    
    // move4
    int random4 = arc4random_uniform(self.ally.moves.count);
    [[APIController sharedController] fetchMoveAt:self.ally.moves[random4] completion:^(JLAMove *move) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.ally.move4 = move;
            
            NSString *moveName = [self.ally.move4.name uppercaseString];
            NSString *detailed = [NSString stringWithFormat:@"%@ - %@", moveName, self.ally.move4.power];
            [self.move4ButtonLabel setTitle: detailed forState: normal];
//            NSLog(@"move4.name = %@", self.enemy.move4.name);
//            NSLog(@"move4.power = %@", self.enemy.move4.power);
//            NSLog(@"move4.accuracy = %@", self.enemy.move4.accuracy);
//            NSLog(@"move4.damageClass = %@", self.enemy.move4.damageClass);
//            NSLog(@"move4.type = %@", self.enemy.move4.type);
        });
    }];
    
}

- (void)fetchEnemyImage {
    
    NSLog(@"called fetchEnemyImage in battleVC, spriteURL = %@", self.enemy.sprite);
    
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
    // NEW
    [self fetchAlly];
}



- (IBAction)healButtonTapped:(UIButton *)sender {
    NSLog(@"Heal button tapped");
    self.enemyHpProgressView.progress = 1.0;
}

@end
