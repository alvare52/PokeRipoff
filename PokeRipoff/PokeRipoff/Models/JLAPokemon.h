//
//  JLAPokemon.h
//  PokeRipoff
//
//  Created by Jorge Alvarez on 4/11/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JLAMove;

@interface JLAPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, copy) NSURL *sprite;
@property (nonatomic, copy, nullable) NSURL *backSprite;
@property (nonatomic, copy) NSArray *abilities;
@property (nonatomic, copy) NSArray *moves;
@property (nonatomic, copy) NSArray *stats;
@property (nonatomic, copy) NSArray *types;
@property (nonatomic, nullable) UIImage *frontImage; // should both start as null
@property (nonatomic, nullable) UIImage *backImage;
@property (nonatomic) JLAMove *move1;
@property (nonatomic) JLAMove *move2;
@property (nonatomic) JLAMove *move3;
@property (nonatomic) JLAMove *move4;

- (instancetype)initWithName:(NSString *)name
                  identifier:(NSNumber *)identifier
                      sprite:(NSURL *)sprite
                  backSprite:(NSURL *)backSprite
                   abilities:(NSArray *)abilities
                       moves:(NSArray *)moves
                       stats:(NSArray *)stats
                       types:(NSArray *)types;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
