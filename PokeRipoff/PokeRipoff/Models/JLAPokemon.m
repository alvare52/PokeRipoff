//
//  JLAPokemon.m
//  PokeRipoff
//
//  Created by Jorge Alvarez on 4/11/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

#import "JLAPokemon.h"
#import "JLAMove.h"

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
            
            // FIXME: should not have duplicates
            NSURL *url = [NSURL URLWithString:moveURL];
            if ([self ignoreUrl:url.lastPathComponent]) {
//                NSLog(@"url to ignore: %@", moveURL);
                continue;
            }
            
            // array of urls now
            [movesArray addObject:url];
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

/// Contains an array of move numbers that should be ignored (status moves = no damage)
- (bool)ignoreUrl:(NSString *)urlToIgnore {
    NSArray *urls = @[@"14", @"18", @"28", @"39", @"43", @"45", @"46", @"47", @"48", @"50",
                      @"54", @"73", @"74", @"77", @"78", @"79", @"81", @"86", @"92", @"95",
                      @"96", @"97", @"100", @"102", @"103", @"104", @"105", @"106", @"107", @"108",
                      @"109", @"110", @"111", @"112", @"113", @"114", @"115", @"116", @"118", @"119",
                      @"133", @"134", @"135", @"137", @"139", @"142", @"144", @"147", @"148", @"150",
                      @"151", @"156", @"159", @"160", @"164", @"166", @"169", @"170", @"171", @"174",
                      @"176", @"178", @"180", @"182", @"184", @"186", @"187", @"191", @"193", @"194",
                      @"195", @"197", @"199", @"201", @"203", @"204", @"207", @"208", @"212", @"213",
                      @"214", @"215", @"219", @"220", @"226", @"227", @"230", @"234", @"235", @"236",
                      @"240", @"241", @"244", @"254", @"256", @"258", @"259", @"260", @"261", @"262",
                      @"266", @"267", @"268", @"269", @"270", @"271", @"272", @"273", @"274", @"275",
                      @"277", @"278", @"281", @"285", @"286", @"287", @"288", @"289", @"293", @"294",
                      @"297", @"298", @"300", @"303", @"312", @"313", @"316", @"319", @"320", @"321",
                      @"322", @"334", @"335", @"336", @"339", @"346", @"347", @"349", @"355", @"356",
                      @"357", @"361", @"366", @"367", @"373", @"375", @"377", @"379", @"380", @"381",
                      @"382", @"383", @"384", @"385", @"388", @"390", @"391", @"392", @"393", @"397",
                      @"415", @"417", @"432", @"433", @"445", @"446", @"455", @"456", @"461", @"464",
                      @"468", @"469", @"470", @"471", @"472", @"475", @"476", @"477", @"478", @"483",
                      @"487", @"489", @"493", @"494", @"495", @"501", @"502", @"504", @"505", @"508",
                      @"511", @"513", @"516", @"526", @"538", @"561", @"563", @"564", @"567", @"568",
                      @"568", @"569", @"571", @"575", @"576", @"578", @"579", @"580", @"581", @"582",
                      @"587", @"588", @"589", @"590", @"596", @"597", @"598", @"599", @"600", @"601",
                      @"602", @"603", @"604", @"606", @"607", @"608", @"659", @"661", @"666", @"668",
                      @"671", @"672", @"673", @"674", @"678", @"683", @"685", @"689", @"694", @"702",
                      @"715", @"743", @"747", @"748", @"749", @"750", @"752", @"753", @"756", @"775",
                      @"777", @"791", @"792"];
    
    
    if ([urls containsObject:urlToIgnore]) {
        return YES;
    } else {
        return NO;
    }
}

@end
