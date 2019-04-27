//
//  FMDBUtility.h
//  DataBaseDemo
//
//  Created by Prashant Prajapati on 30/06/17.
//  Copyright © 2017 Prashant Prajapati. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface FMDBUtility : NSObject

+(void)createTableExecuteQuery:(NSString *)query;
+(void)DMLOperationExecuteQuery:(NSString *)query;
+(NSMutableArray *)executeQueryFetchData:(NSString *)query;

@end
