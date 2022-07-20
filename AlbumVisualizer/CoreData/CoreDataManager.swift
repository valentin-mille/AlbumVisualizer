//
//  CoreDataManager.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/18/22.
//

import CoreData
import Foundation

class CoreDataManager {
    static let shared = CoreDataManager()

    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AlbumVisualizer")

        container.loadPersistentStores(completionHandler: { [unowned container] _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func fetchAlbums() -> [AlbumEntity]? {
        let request: NSFetchRequest<AlbumEntity> = AlbumEntity.fetchRequest()

        do {
            let albums = try viewContext.fetch(request)
            return albums.sorted(by: { $0.id < $1.id })
        } catch {
            print(error)
            return nil
        }
    }

    func fetchAlbumsConverted() -> [Album] {
        var albums: [Album] = []
        let albumEntities = fetchAlbums()

        if let albumEntities = albumEntities {
            for entity in albumEntities {
                if let title = entity.title {
                    albums.append(Album(id: Int(entity.id), userId: Int(entity.userId), title: title))
                }
            }
        }
        return albums
    }

    func fetchPhotoConverted(album: Album) -> [Photo] {
        var photos: [Photo] = []
        let photoEntities = fetchPhotosByAlbum(album: album)

        if let photoEntities = photoEntities {
            for entity in photoEntities {
                if let title = entity.title, let url = entity.url, let thumbnailUrl = entity.thumbnailUrl {
                    photos.append(Photo(id: Int(entity.id), albumId: Int(entity.albumId), title: title, url: url, thumbnailUrl: thumbnailUrl))
                }
            }
        }
        return photos
    }

    func fetchPhotos() -> [PhotoEntity]? {
        let request: NSFetchRequest<PhotoEntity> = PhotoEntity.fetchRequest()

        do {
            let photos = try viewContext.fetch(request)
            return photos.sorted(by: { $0.id < $1.id })
        } catch {
            print(error)
            return nil
        }
    }

    func fetchPhotosByAlbum(album: Album) -> [PhotoEntity]? {
        let photos = fetchPhotos()
        return photos?.filter({ $0.albumId == album.id })
    }

    func insertPhoto(toInsert: Photo) {
        let new = PhotoEntity(context: viewContext)
        let photoEntities = fetchPhotos()
        if !(photoEntities?.contains(where: { $0.id == toInsert.id }) ?? false) {
            new.id = Int16(toInsert.id)
            new.title = toInsert.title
            new.thumbnailUrl = toInsert.thumbnailUrl
            new.url = toInsert.url
            new.albumId = Int16(toInsert.albumId)

            viewContext.insert(new)
            updateContext()
        }
    }

    func insertAlbum(toInsert: Album) {
        let albumEntities = fetchAlbums()

        if !(albumEntities?.contains(where: { $0.id == toInsert.id }) ?? false) {
            let new = AlbumEntity(context: viewContext)
            new.id = Int16(toInsert.id)
            new.title = toInsert.title
            new.userId = Int16(toInsert.userId)

            viewContext.insert(new)
            updateContext()
        }
    }

    func updateContext() {
        guard viewContext.hasChanges else {
            return
        }
        do {
            try viewContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
}
