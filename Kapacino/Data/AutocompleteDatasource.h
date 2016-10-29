//
//  AutocompleteDatasource.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-27.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLPAutoCompleteTextFieldDatasource.h"
#import "DOSingleton.h"

@interface AutocompleteDatasource : DOSingleton <MLPAutoCompleteTextFieldDataSource>
//    -(AutocompleteDatasource*) sharedInstance;
    -(NSString*) getDataFilename;
    -(Class) getDataClass;
@end
