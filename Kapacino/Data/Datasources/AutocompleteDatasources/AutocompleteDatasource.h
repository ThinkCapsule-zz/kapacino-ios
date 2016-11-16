//
//  AutocompleteDatasource.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-27.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLPAutoCompleteTextFieldDatasource.h"
#import "JsonDatasource.h"

@interface AutocompleteDatasource : JsonDatasource <MLPAutoCompleteTextFieldDataSource>
    @property (strong, nonatomic) NSPredicate* predicate;
@end
