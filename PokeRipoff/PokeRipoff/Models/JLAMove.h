//
//  JLAMove.h
//  PokeRipoff
//
//  Created by Jorge Alvarez on 4/19/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JLAMove : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *power;
@property (nonatomic, copy) NSNumber *accuracy;
@property (nonatomic, copy) NSString *damageClass;
@property (nonatomic, copy, nullable) NSString *type; // TODO: attacks with unknown type?

- (instancetype)initWithName:(NSString *)name
                       power:(NSNumber *)power
                    accuracy:(NSNumber *)accuracy
                 damageClass:(NSString *)damageClass
                        type:(NSString *)type;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
