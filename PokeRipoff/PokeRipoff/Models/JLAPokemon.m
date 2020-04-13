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
        
        // name
        NSString *name = dictionary[@"name"];
        
        // identifier
        NSNumber *identifier = dictionary[@"id"];
        
        // sprite
        NSDictionary *sprites = dictionary[@"sprites"];
        NSString *spriteString = sprites[@"front_default"];
        NSURL *sprite = [NSURL URLWithString:spriteString];
        
        // backSprite
        NSString *backSpriteString = sprites[@"back_default"];
        NSURL *backSprite = [NSURL URLWithString:backSpriteString];
    
        // abilites
        NSMutableArray *abilitiesArray = [[NSMutableArray alloc] init];
        NSArray *abilitiesDictionary = dictionary[@"abilities"];
        for (NSDictionary *abilityDictionary in abilitiesDictionary) {
            
            NSDictionary *abilityDict = abilityDictionary[@"ability"];
            NSString *abilityName = [abilityDict[@"name"] capitalizedString];
            
            [abilitiesArray addObject:abilityName];
        }
        
        // moves
        NSMutableArray *movesArray = [[NSMutableArray alloc] init];
        NSArray *movesDictionary = dictionary[@"moves"];
        for (NSDictionary *moveDictionary in movesDictionary) {
            
            NSDictionary *moveDict = moveDictionary[@"move"];
            NSString *moveURL = moveDict[@"url"];
            
            [movesArray addObject:moveURL];
        }
        
        // stats (might need to change later because I'm assigning based on order, not stat.name)
        NSMutableArray *statsArray = [[NSMutableArray alloc] init];
        NSArray *statsDictionary = dictionary[@"stats"];
        for (NSDictionary *statDictionary in statsDictionary) {
            
            NSNumber *statNumber = statDictionary[@"base_stat"];
            
            [statsArray addObject:statNumber];
        }
        
        // types
        NSMutableArray *typesArray = [[NSMutableArray alloc] init];
        NSArray *typesDictionary = dictionary[@"types"];
        for (NSDictionary *typeDictionary in typesDictionary) {
            
            NSDictionary *typeDict = typeDictionary[@"type"];
            NSString *typeName = [typeDict[@"name"] capitalizedString];
            
            [typesArray addObject:typeName];
        }
        
        _name = name;
        _identifier = identifier;
        _sprite = sprite;
        _backSprite = backSprite;
        _abilities = abilitiesArray;
        _moves = movesArray;
        _stats = statsArray;
        _types = typesArray;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name
                  identifier:(NSNumber *)identifier
                      sprite:(NSURL *)sprite
                  backSprite:(NSURL *)backSprite
                   abilities:(NSArray *)abilities
                       moves:(NSArray *)moves
                       stats:(NSArray *)stats
                       types:(NSArray *)types {
    
    if (self = [super init]) {
        _name = [name copy];
        _identifier = identifier;
        _sprite = [sprite copy];
        _backSprite = [backSprite copy];
        _abilities = [abilities copy];
        _moves = [moves copy];
        _stats = [stats copy];
        _types = [types copy];
    }
    return self;
}

@end
