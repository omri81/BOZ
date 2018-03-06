//
//  LoginExtension.swift
//  BOZ
//
//  Created by user134028 on 3/6/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import Foundation
import BMSCore
import BMSPush

extension LoginVC {

func pushInit(){
    BMSClient.sharedInstance.initialize(bluemixRegion: "BMSClient.Region.usSouth")
    BMSPushClient.sharedInstance.initializeWithAppGUID(appGUID: "0eb65464-5f7b-4e14-b204-cbc95c81a3e3", clientSecret:"0ac425da-f293-4228-ac3a-75200e391602")
}
/*
 //To register without userId use the following pattern:
 func application (_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
 
 BMSPushClient.sharedInstance.registerWithDeviceToken(deviceToken: deviceToken) { (response, statusCode, error) -> Void in
 
 if error.isEmpty {
 print( "Response during device registration: \(response) and status code is:\(statusCode)")
 } else{
 print( "Error during device registration: \(error) and status code is: \(statusCode)")
 }
 }
 }
 */

//Register with UserId
//The userId can be specified while registering the device with Push Notifications service. The register method will accept one more parameter - userId
func application (_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
    
    BMSPushClient.sharedInstance.registerWithDeviceToken(deviceToken: deviceToken, WithUserId: "your userId") { (response, statusCode, error) -> Void in
        
        if error.isEmpty {
            print( "Response during device registration : \(response) and status code is:\(statusCode)")
        } else{
            print( "Error during device registration \(error) and status code is:\(statusCode) ")
        }
    }
}
//Unregister device from notifications
//Note:To unregister from the UserId based registration, you have to call the registration method without userId.
func unRegisterPush() {
    BMSPushClient.sharedInstance.unregisterDevice(completionHandler: { (response, statusCode, error) -> Void in
        
        if error.isEmpty {
            print( "Response during unregistering device : \(response)  and status code is:\(statusCode)")
        }else{
            print( "Error during unregistering device \(error) and status code is:\(statusCode)")
        }
    })
}

//get a list of tags to which the device can subscribe
func getListTagsPush (){
    BMSPushClient.sharedInstance.retrieveAvailableTagsWithCompletionHandler(completionHandler: { (response, statusCode, error) -> Void in
        
        if error.isEmpty {
            print( "Response during retrieve tags : \(response)  and status code is:\(statusCode)")
        }else{
            print( "Error during retrieve tags \n  - status code: \(statusCode) \n Error :\(error) \n")
        }
    } )
}
/*
 //----Subscribe to tags
 //The subscribeToTags API will subscribe the iOS device for the list of given tags. After the device is subscribed to a particular tag, the device can receive any push notifications that are sent for that tag.
 func subscribeToTagPush(){
 BMSPushClient.sharedInstance.subscribeToTags(tagsArray: response!, completionHandler: { (response, statusCode, error) -> Void in
 
 if error.isEmpty {
 print( "Response during Subscribing to tags : \(response?.description) and status code is:\(statusCode)")
 }else{
 print( "Error during subscribing tags \n  - status code: \(statusCode) \n Error :\(error) \n")
 }
 })
 }
 */
//------Retrieve subscribed tags
//The retrieveSubscriptionsWithCompletionHandler API will return the list of tags to which the device is subscribed
func retriveSubscribedTagsPush(){
    BMSPushClient.sharedInstance.retrieveSubscriptionsWithCompletionHandler(completionHandler: { (response, statusCode, error) -> Void in
        
        if error.isEmpty {
            print( "Response during retrieving subscribed tags : \(response?.description) and status code is:\(statusCode)")
        } else{
            print( "Error during retrieving subscribed tags \n  - status code: \(statusCode) \n Error :\(error) \n")
        }
    })
}
}








