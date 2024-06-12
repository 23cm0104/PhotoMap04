//
//  Item+CoreDataProperties.swift
//  PhotoMap04
//
//  Created by cmStudent on 2024/06/12.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var address: String?
    @NSManaged public var comment: String?
    @NSManaged public var createdTime: Date?
    @NSManaged public var imageData: Data?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var title: String?
    @NSManaged public var updateTime: Date?

}

extension Item : Identifiable {
    public var stringUpdatedTime: String {dateFormatter(date: updateTime ?? Date())}
    
    func dateFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyou")
        
        return dateFormatter.string(from: date)
    }
}
