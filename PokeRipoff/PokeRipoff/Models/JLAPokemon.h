//
//  JLAPokemon.h
//  PokeRipoff
//
//  Created by Jorge Alvarez on 4/11/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JLAPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, copy) NSURL *sprite;
@property (nonatomic, copy) NSURL *backSprite;
@property (nonatomic, copy) NSArray *abilities;
@property (nonatomic, copy) NSArray *moves;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
