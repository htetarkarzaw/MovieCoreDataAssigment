//
//  MovieBookmarkResponse.swift
//  movie-core-data
//
//  Created by Htet Arkar Zaw on 9/26/19.
//  Copyright © 2019 padc. All rights reserved.
//

import Foundation
import CoreData

class MovieBookmarkResponse {
    
    static func saveBookmark(data : Int, context : NSManagedObjectContext) {
        
        var id = 0
        
        if data>0 {
            id = data
        } else {
            print("failed to save Bookmark")
            return
        }
     
        let bookMarked = BookmarkVO(context: context)
        bookMarked.id = Int32(id)
         
        do {
            try context.save()
        } catch {
            print("failed to save bookmark \(id) : \(error.localizedDescription)")
        }
        
        
    }
    
    static func deleteBookmark(data : Int , context : NSManagedObjectContext) {
    
        var id = 0
        
        if data>0 {
            id = data
        } else {
            print("failed to save Bookmark")
            return
        }
        
        if let bookMarked = BookmarkMovieVO.getBookmarkListWithId(movieId: id) {
        
            do {
                print("deleting... \(bookMarked[0].id)")
                try context.delete(bookMarked[0])
                
                do {
                    try context.save()
                } catch {
                    print("failed to save deleted bookmark")
                }
                
            } catch {
                print("failed to delete bookmark")
            }
        }
        
    }
}
