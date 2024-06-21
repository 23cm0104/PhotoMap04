//
//  MarkerItem+CoreDataProperties.swift
//  PhotoMap04
//
//  Created by cmStudent on 2024/06/16.
//
//

import Foundation
import CoreData


extension MarkerItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MarkerItem> {
        return NSFetchRequest<MarkerItem>(entityName: "MarkerItem")
    }

    @NSManaged public var address: String?
    @NSManaged public var comment: String?
    @NSManaged public var createdTime: Date?
    @NSManaged public var imageData: Data?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var title: String?
    @NSManaged public var updateTime: Date?
    @NSManaged public var red: Float
    @NSManaged public var green: Float
    @NSManaged public var blue: Float

}

extension MarkerItem : Identifiable {
    public var stringUpdatedTime: String {dateFormatter(date: updateTime ?? Date())}
    
    func dateFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyou")
        
        return dateFormatter.string(from: date)
    }
}
