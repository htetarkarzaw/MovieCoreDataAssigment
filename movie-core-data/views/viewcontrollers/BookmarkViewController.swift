//
//  BookmarkViewController.swift
//  movie-core-data
//
//  Created by Htet Arkar Zaw on 9/26/19.
//  Copyright © 2019 padc. All rights reserved.
//

import UIKit
import CoreData

class BookmarkViewController: UIViewController {

    var mBookmarkedList : [BookmarkVO]?
    var fetchResultController : NSFetchedResultsController<BookmarkVO>!
    @IBOutlet weak var collectionViewBookmark: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        // Do any additional setup after loading the view.
    }
    
    func initView() {
        
        collectionViewBookmark.delegate = self
        collectionViewBookmark.dataSource = self
        collectionViewBookmark.backgroundColor = Theme.background

        initBookMarkListFetchRequest()

    }
    
    fileprivate func initBookMarkListFetchRequest() {
            
            let fetchRequest : NSFetchRequest<BookmarkVO> = BookmarkVO.fetchRequest();
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            
            fetchResultController.delegate = self
            do {
                try fetchResultController.performFetch()
                if let result = fetchResultController.fetchedObjects {
                    if result.isEmpty {
                        self.mBookmarkedList = result
                        collectionViewBookmark.reloadData()
                    }
                }
            } catch {
                
                print("TAG: \(error.localizedDescription)")
                
            }
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "Bookmarked List"
    }

}

extension BookmarkViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        collectionViewBookmark.reloadData()
    }
}

extension BookmarkViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieDetailsViewController = segue.destination as? MovieDetailsViewController {
            
            if let indexPaths = collectionViewBookmark.indexPathsForSelectedItems, indexPaths.count > 0 {
                let selectedIndexPath = indexPaths[0]
                let movieId = Int(fetchResultController.object(at: selectedIndexPath).id)
                let movie = MovieVO.getMovieById(movieId: movieId)
                
                movieDetailsViewController.movieId = movieId
                
                self.navigationItem.title = movie?.original_title ?? ""
            }
            
        }
    }
    
}

extension BookmarkViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchResultController.sections?.count ?? 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //        return movieVO.count
        return fetchResultController.sections![section].numberOfObjects
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        let movie = movieVO[indexPath.row]
        let bookedmarkedVO = fetchResultController.object(at: indexPath)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BookmarkCollectionViewCell.self), for: indexPath) as? BookmarkCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        //        print("Genre Count : \(movie.genres?.count ?? 0)")
        let movie = MovieVO.getMovieById(movieId: Int(bookedmarkedVO.id))
        cell.data = movie
        return cell
    }
}

extension BookmarkViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / 3) - 10;
        return CGSize(width: width, height: width * 1.45)
    }
}
