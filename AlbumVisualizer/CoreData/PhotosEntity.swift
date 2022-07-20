//
//  Photos+CoreDataAttributes.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/18/22.
//

import Foundation

import CoreData

/** Core Data class for the Photo object */
class PhotoEntity: NSManagedObject {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<PhotoEntity> {
        NSFetchRequest<PhotoEntity>(entityName: "Photo")
    }

    @NSManaged public var id: Int16
    @NSManaged public var albumId: Int16
    @NSManaged public var thumbnailUrl: String?
    @NSManaged public var url: String?
    @NSManaged public var title: String?
}
