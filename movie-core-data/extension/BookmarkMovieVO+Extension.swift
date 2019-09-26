//
//  BookmarkVO+Extension.swift
//  movie-core-data
//
//  Created by Htet Arkar Zaw on 9/26/19.
//  Copyright © 2019 padc. All rights reserved.
//

import Foundation
import CoreData

class BookmarkMovieVO {
    
    static func getBookmarkList() -> [BookmarkVO]? {
        let fetchRequest : NSFetchRequest<BookmarkVO> = BookmarkVO.fetchRequest()
        
        do {
            let data = try CoreDataStack.shared.viewContext.fetch(fetchRequest)
            if data.isEmpty {
                return nil
            }
            return data
        } catch {
            print("failed to fetch bookmarked list: \(error.localizedDescription)")
            return nil
        }
        
    }
    
    static func getBookmarkListWithId(movieId : Int) -> [BookmarkVO]? {
        
        let fetchRequest: NSFetchRequest<BookmarkVO> = BookmarkVO.fetchRequest()
        let predicate = NSPredicate(format: "id == %d", movieId)
        fetchRequest.predicate = predicate
        
        do {
            let data = try CoreDataStack.shared.viewContext.fetch(fetchRequest)
            
            print(data.count)
            if data.isEmpty {
                return nil
            }
            return data
        } catch {
            print("failed to fetch bookmark")
            return nil
        }
        
    }
    
    static func getIsBookmark(movieId: Int) -> Bool {
        
        let fetchRequest : NSFetchRequest<BookmarkVO> = BookmarkVO.fetchRequest()
        let predicate = NSPredicate(format: "id == %d", movieId)
        fetchRequest.predicate = predicate
        
        do {
            let data = try CoreDataStack.shared.viewContext.fetch(fetchRequest)
            
            print(data.count)
            if data.isEmpty {
                return false
            }
            return true
        } catch {
            print("failed to fetch bookmark")
            return false
        }
        
    }
    
}
