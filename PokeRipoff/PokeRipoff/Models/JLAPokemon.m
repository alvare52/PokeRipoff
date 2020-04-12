//
//  JLAPokemon.m
//  PokeRipoff
//
//  Created by Jorge Alvarez on 4/11/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

#import "JLAPokemon.h"

@implementation JLAPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if (self = [super init]) {
        
        NSString *name = dictionary[@"name"];
        
        NSNumber *identifier = dictionary[@"id"];
        
        // { [{}] }
        NSDictionary *sprites = dictionary[@"sprites"];
        NSString *spriteString = sprites[@"front_default"];
        NSURL *sprite = [NSURL URLWithString:spriteString];
        
        NSString *backSpriteString = sprites[@"back_default"];
        NSURL *backSprite = [NSURL URLWithString:backSpriteString];
    
        // abilites [@"ability"] / ability @["name"]
        NSMutableArray *abilitiesArray = [[NSMutableArray alloc] init];
        NSArray *abilitiesDictionary = dictionary[@"abilities"];
        for (NSDictionary *abilityDictionary in abilitiesDictionary) {
            
            NSDictionary *abilityDict = abilityDictionary[@"ability"];
            NSString *abilityName = [abilityDict[@"name"] capitalizedString];
            
            [abilitiesArray addObject:abilityName];
        }
        
        // abilites [@"ability"] / ability @["name"]
        NSMutableArray *movesArray = [[NSMutableArray alloc] init];
        NSArray *movesDictionary = dictionary[@"moves"];
        for (NSDictionary *moveDictionary in movesDictionary) {
            
            NSDictionary *moveDict = moveDictionary[@"move"];
            NSString *moveURL = moveDict[@"url"];
            
            [movesArray addObject:moveURL];
        }
        
        _name = name;
        _identifier = identifier;
        _sprite = sprite;
        _backSprite = backSprite;
        _abilities = abilitiesArray;
        _moves = movesArray;
    }
    return self;
}

@end
