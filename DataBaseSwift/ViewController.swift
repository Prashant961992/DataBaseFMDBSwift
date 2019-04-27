//
//  ViewController.swift
//  DataBaseSwift
//
//  Created by Prashant Prajapati on 30/06/17.
//  Copyright © 2017 Prashant Prajapati. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        FMDBUtility.createTableExecuteQuery("CREATE TABLE IF NOT EXISTS CaseStageMaster ( `CaseStageID` INTEGER NOT NULL, `CaseStage` TEXT, `CreatedDate` TEXT, `CreateddateInt` INTEGER, `ActionType` TEXT, `IsActive` INTEGER NOT NULL, `IsDelete` INTEGER NOT NULL, `UpdateDate` TEXT, `UpdateDateInt` INTEGER )")
        FMDBUtility.createTableExecuteQuery("CREATE TABLE IF NOT EXISTS CaseType( CaseTypeID INTEGER NOT NULL, CaseTypeName TEXT NOT NULL, ActionType TEXT NULL, CreatedDate TEXT NULL, CreatedDateInt INTEGER NULL, UpdateDate TEXT NULL, UpdateDateInt INTEGER NULL, IsActive INTEGER Boolean NOT NULL DEFAULT ((1)), IsDelete INTEGER Boolean NOT NULL DEFAULT ((0)) )")
        FMDBUtility.createTableExecuteQuery("CREATE TABLE IF NOT EXISTS ColorRow (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,title TEXT,color TEXT)")
        FMDBUtility.createTableExecuteQuery("CREATE TABLE IF NOT EXISTS DistrictMaster( DistrictID INTEGER NOT NULL, DistrictName TEXT NOT NULL, StateID INTEGER NOT NULL, ActionType TEXT NULL, CreatedDate TEXT NULL, CreatedDateInt INTEGER NULL, UpdateDate TEXT NULL, UpdateDateInt INTEGER NULL, IsActive INTEGER NOT NULL DEFAULT ((1)) )")
        FMDBUtility.createTableExecuteQuery("CREATE TABLE IF NOT EXISTS DynamicPage( DynamicPageID INTEGER NOT NULL, PageName TEXT NOT NULL, PageTitle TEXT NOT NULL, ActionType TEXT NULL, Contents TEXT NOT NULL, IsVisible INTEGER NOT NULL DEFAULT ((1)), CreatedDate TEXT NULL, CreatedDateInt INTEGER NULL, UpdateDate TEXT NULL, UpdateDateInt INTEGER NULL, IsDelete INTEGER NOT NULL DEFAULT ((0)) )")
        FMDBUtility.createTableExecuteQuery("CREATE TABLE IF NOT EXISTS FAQ( FAQID INTEGER NOT NULL, QuestionEn TEXT NULL, AnswerEn TEXT NULL, QuestionHn TEXT NULL, AnswerHn TEXT NULL, DisplayRank INTEGER NULL, ActionType TEXT NULL, CreatedDate TEXT NULL, CreatedDateInt INTEGER NULL, UpdateDate TEXT NULL, UpdateDateInt INTEGER NULL, IsActive INTEGER NOT NULL DEFAULT ((1)), IsDelete INTEGER NOT NULL DEFAULT ((0)) )")
        FMDBUtility.createTableExecuteQuery("CREATE TABLE IF NOT EXISTS Holiday( HolidayID INTEGER NOT NULL, Title TEXT NOT NULL, StartDate TEXT NULL, ActionType TEXT NULL, StartDateInt INTEGER NULL, IsDelete INTEGER NOT NULL DEFAULT ((0)), CreatedDate TEXT NULL, CreatedDateInt INTEGER NULL, UpdateDate TEXT NULL, UpdateDateInt INTEGER NULL )")
        FMDBUtility.createTableExecuteQuery("CREATE TABLE IF NOT EXISTS Question( QuestionID INTEGER NOT NULL, UserID INTEGER NULL, Question1 TEXT NULL, Answer TEXT NULL, QuestionDate TEXT NULL, QuestionDateInt INTEGER NOT NULL, AnswerDate TEXT NULL, AnswerDateInt INTEGER NOT NULL, AnswerByID INTEGER NULL, ActionType TEXT NULL, CreatedDate TEXT NULL, CreatedDateInt INTEGER NULL, UpdateDate TEXT NULL, UpdateDateInt INTEGER NULL, IsActive INTEGER Boolean NOT NULL DEFAULT ((1)), IsDelete INTEGER Boolean NOT NULL DEFAULT ((0)) )")
        FMDBUtility.createTableExecuteQuery("CREATE TABLE IF NOT EXISTS `RoleMaster` ( `RoleID` INTEGER NOT NULL, `RoleName` TEXT NOT NULL, `IsActive` INTEGER NOT NULL )")
        FMDBUtility.createTableExecuteQuery("CREATE TABLE IF NOT EXISTS Settings ( id INTEGER NOT NULL, BackupTime TEXT, DateFormat TEXT, FontSize INTEGER, First TEXT, CaseNoYear TEXT, CaseNoType TEXT, JNBelow INTEGER Boolean )")
        FMDBUtility.createTableExecuteQuery("CREATE TABLE IF NOT EXISTS SpaceAllocated ( `SpaceAllocatedID` INTEGER NOT NULL, `UserID` INTEGER NOT NULL, `SpaceAllocatedSize` REAL NOT NULL, `PurchaseDate` TEXT NOT NULL, `PurchaseDateInt` INTEGER NOT NULL, `ServerSpaceID` INTEGER NOT NULL, `TransactionID` TEXT, `ActionType` TEXT, `CreatedDate` TEXT, `CreatedDateInt` INTEGER, `UpdateDate` TEXT, `UpdateDateInt` INTEGER )")
        FMDBUtility.createTableExecuteQuery("CREATE TABLE IF NOT EXISTS StateMaster( StateID INTEGER NOT NULL, StateName TEXT NOT NULL, CreatedDate TEXT NULL, ActionType TEXT NULL, CreatedDateInt INTEGER NULL, UpdateDate TEXT NULL, UpdateDateInt INTEGER NULL, IsActive INTEGER NOT NULL DEFAULT ((1)) )")
        FMDBUtility.createTableExecuteQuery("CREATE TABLE IF NOT EXISTS UserMaster ( `UserID` INTEGER NOT NULL, `HASH` TEXT, `SALT` TEXT, `Mobile` TEXT NOT NULL, `FullName` TEXT NOT NULL, `Email` TEXT NOT NULL, `Address` TEXT, `StateID` INTEGER, `DistrictID` INTEGER, `EnrollBarCouncil` TEXT, `EnrollBarAssociation` TEXT, `Age` INTEGER, `ProfilePic` TEXT, `ActionType` TEXT, `CreatedDate` TEXT, `CreatedDateInt` INTEGER, `UpdateDate` TEXT, `UpdateDateInt` INTEGER, `IsActive` INTEGER NOT NULL DEFAULT 1, `IsDelete` INTEGER NOT NULL DEFAULT 0, `RoleID` INTEGER NOT NULL, `AllocatedSpace` REAL NOT NULL, `RemainingSpace` REAL NOT NULL, `EnrollBarCouncilNo` TEXT, `EnrollBarAssociationNo` TEXT )")
        
        self.getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getData()  {
        let url: String = "http://209.126.235.28:1116/Services/StartUp.svc/json/StartUpServiceAD"
        let params: [AnyHashable: Any] = ["UpdateDate": ""]
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.post(url, parameters: params, progress: nil, success: {(_ task: URLSessionDataTask, _ responseObject: Any?) -> Void in
            
            let dic = responseObject as! NSDictionary
            
            let  arr = dic.value(forKeyPath: "ResponseData.Data.CaseStageList") as! NSArray
            
            for i in 0..<arr.count{
                let ArrayV = arr[i] as! [AnyHashable : Any]
                for k in 0..<ArrayV.count {
                    let object = ArrayV[k] as! [AnyHashable : Any]
                    let query: String = "insert into CaseStageMaster values (\(String(describing: object["CaseStageID"])),'\(String(describing: object["CaseStage"]))','\(String(describing: object["CreatedDate"]))',\(String(describing: object["CreateddateInt"])),'\(String(describing: object["ActionType"]))',\(String(describing: object["IsActive"])),\(String(describing: object["IsDelete"])),'\(String(describing: object["UpdateDate"]))',\(String(describing: object["UpdateDateInt"])))"
                    //        NSLog(@"The query is: %@",query);
                    print("\(query)")
                    FMDBUtility.dmlOperationExecuteQuery(query)
                }
            }

            
        }, failure: {(_ task: URLSessionDataTask?, _ error: Error?) -> Void in
            //        [hud hideAnimated:YES];
            print("Error: \(String(describing: error))")
        })
    }

    func insertCaseStageList(_ ArrayV: [Any]) {
        for k in 0..<ArrayV.count {
            let object = ArrayV[k] as! [AnyHashable : Any]
            let query: String = "insert into CaseStageMaster values (\(String(describing: object["CaseStageID"])),'\(String(describing: object["CaseStage"]))','\(String(describing: object["CreatedDate"]))',\(String(describing: object["CreateddateInt"])),'\(String(describing: object["ActionType"]))',\(String(describing: object["IsActive"])),\(String(describing: object["IsDelete"])),'\(String(describing: object["UpdateDate"]))',\(String(describing: object["UpdateDateInt"])))"
            //        NSLog(@"The query is: %@",query);
            print("\(query)")
            FMDBUtility.dmlOperationExecuteQuery(query)
        }
    }
}

