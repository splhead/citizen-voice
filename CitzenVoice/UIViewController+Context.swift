//
//  UIViewController+Context.swift
//  CitzenVoice
//
//  Created by Splhead on 17/12/21.
//

import UIKit
import CoreData

extension UIViewController {
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
