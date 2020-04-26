//
//  JLAMove.m
//  PokeRipoff
//
//  Created by Jorge Alvarez on 4/19/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

#import "JLAMove.h"

@implementation JLAMove

- (instancetype)initWithName:(NSString *)name
                       power:(NSNumber *)power
                    accuracy:(NSNumber *)accuracy
                 damageClass:(NSString *)damageClass
                        type:(NSString *)type {
    
    if (self = [super init]) {
        _name = [name copy];
        _power = power;
        _accuracy = accuracy;
        _damageClass = [damageClass copy];
        _type = [type copy];
    }
    return self;
}


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if (self = [super init]) {
        
        // name
        NSString *name = dictionary[@"name"];
        
        // power
        NSNumber *power = dictionary[@"power"];
        
        // accuracy
        NSNumber *accuracy = dictionary[@"accuracy"];
        
        // damageClass
        NSDictionary *damageClassDictionary = dictionary[@"damage_class"];
        NSString *damageClass = damageClassDictionary[@"name"];
        
        // type
        NSDictionary *typeDictionary = dictionary[@"type"];
        NSString *type = typeDictionary[@"name"];
        
        // TODO: if power/accuracy == NULL, then assign it a default of 50/100?
        
        // Moves with "no" accuracy because they always hit
        if ([accuracy isKindOfClass:[NSNull class]]) {
            NSLog(@" \n NULL accuracy \n");
            accuracy = @100; // default of perfect accuracy
        }
        // Moves that have no set damage, so based on other stuff
        if ([power isKindOfClass:[NSNull class]]) {
            NSLog(@"\n NULL power \n");
            power = @55; // default damage
        }
        
        _name = name;
        _power = power;
        _accuracy = accuracy;
        _damageClass = damageClass;
        _type = type;
    }
    return self;
}

@end
