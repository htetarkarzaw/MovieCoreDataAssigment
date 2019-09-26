//
//  GenreVO+Extension.swift
//  movie-core-data
//
//  Created by Thet Htun on 9/20/19.
//  Copyright © 2019 padc. All rights reserved.
//

import Foundation
import CoreData

extension MovieGenreVO {
    
    static func saveMovieGenreVO(data : [MovieGenreResponse],context : NSManagedObjectContext){
        data.forEach{item in
            let genre = MovieGenreVO(context: context)
            genre.id = Int32(item.id)
            genre.name = item.name
            do{
                try context.save()
            }catch {
                print ("Failed to save genre: \(error.localizedDescription)")
            }
        }
    }
    static func getMovieGenreVOById(genreId : Int) -> MovieGenreVO? {
        let fetchRequest : NSFetchRequest<MovieGenreVO> = MovieGenreVO.fetchRequest()
        let predicate = NSPredicate(format: "id == %d", genreId)
        fetchRequest.predicate = predicate
        
        do {
            let data = try CoreDataStack.shared.viewContext.fetch(fetchRequest)
            if data.isEmpty {
                return nil
            }
            return data[0]
        } catch {
            print("failed to fetch movie genre vo \(error.localizedDescription)")
            return nil
        }
        
    }
    
    static func getFetchRequest() -> NSFetchRequest<MovieGenreVO> {
        let fetchRequest : NSFetchRequest<MovieGenreVO> = MovieGenreVO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
}
