//
//  CoreDataModel.swift
//  BOZ
//
//  Created by user134028 on 2/24/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct ProductModel {
   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func insertNewProduct(qr: String, title: String) {
        let product = Product(context: context)// create new person and insert it to CoreData
        //edit
        product.qr = qr
        product.title = title
        
        try! context.save()
    }
    func productQueryAll() -> [Product]{
        let req: NSFetchRequest<Product> = Product.fetchRequest()
        let products = try! context.fetch(req)
        return products
    }
}
