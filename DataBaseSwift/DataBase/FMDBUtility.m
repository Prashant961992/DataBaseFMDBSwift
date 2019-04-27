//
//  FMDBUtility.m
//  DataBaseDemo
//
//  Created by Prashant Prajapati on 30/06/17.
//  Copyright © 2017 Prashant Prajapati. All rights reserved.
//

#import "FMDBUtility.h"


@implementation FMDBUtility

#define databasename @"pantherSwift.db"

+(NSString *)getDatabasePath{
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentDir stringByAppendingPathComponent:@"databasename.db"];
    
    return databasePath;
}
+(void)createTableExecuteQuery:(NSString *)query{
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    NSString *destinationPath = [documentDir stringByAppendingPathComponent:databasename];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath])
    {
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databasename];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        //  Check if any error occured during copying and display it.
        if (error != nil)
        {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
    FMDatabase *db = [FMDatabase databaseWithPath:destinationPath];
    [db open];
    [db executeUpdate:query];
    [db close];
}
+(void)DMLOperationExecuteQuery:(NSString *)query{
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    NSString *destinationPath = [documentDir stringByAppendingPathComponent:databasename];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]){
        //  The database file does not exist in the documents directory, so copy it form the main bundle now.
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databasename];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        //  Check if any error occured during copying and display it.
        if (error != nil)
        {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
    FMDatabase *db = [FMDatabase databaseWithPath:destinationPath];
    [db open];
    [db executeUpdate:query];
    [db close];
}

+(NSMutableArray *)executeQueryFetchData:(NSString *)query{
    NSMutableArray *arrFetchData = [[NSMutableArray alloc]init];
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    NSString *destinationPath = [documentDir stringByAppendingPathComponent:databasename];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]){
        //  The database file does not exist in the documents directory, so copy it form the main bundle now.
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databasename];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        //  Check if any error occured during copying and display it.
        if (error != nil)
        {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
    FMDatabase *db = [FMDatabase databaseWithPath:destinationPath];
    [db open];
    FMResultSet *results = [db executeQuery:query];
    while ([results next]) {
        [arrFetchData addObject:[results resultDictionary]];
    }
    [db close];
    return arrFetchData;
}
@end
