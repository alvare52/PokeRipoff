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
        
        _name = name;
        _power = power;
        _accuracy = accuracy;
        _damageClass = damageClass;
        _type = type;
    }
    return self;
}

@end
