//
//  Album+CoreDataAttributes.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/18/22.
//

import Foundation
import CoreData

/** Core Data class for the Album object */
class AlbumEntity: NSManagedObject {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<AlbumEntity> {
        NSFetchRequest<AlbumEntity>(entityName: "Album")
    }

    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var userId: Int16
}
