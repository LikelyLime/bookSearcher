//
//  CoreDataManager.swift
//  bookSearcher
//
//  Created by 백시훈 on 8/6/24.
//

import Foundation
import CoreData
import UIKit
class CoreDataManager{
    static let shared = CoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    /// 데이터 저장
    func saveBook(title: String, authors: String, price: String, content: String, thumbnail: String) {
        let book = BookInfoEntity(context: context)
        book.title = title
        book.authors = authors
        book.price = price
        book.content = content
        book.thumbnail = thumbnail
        
        do {
            try context.save()
            print("저장 성공")
        } catch {
            print("에러: \(error.localizedDescription)")
        }
    }
    /// coreData 전체 조회
    func fetchBooks() -> [BookInfoEntity] {
        let fetchRequest: NSFetchRequest<BookInfoEntity> = BookInfoEntity.fetchRequest()
        
        do {
            let books = try context.fetch(fetchRequest)
            return books
        } catch {
            print("에러: \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteData(title: String){
        let fetchRequest = BookInfoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        do{
            let result = try self.context.fetch(fetchRequest)
            for data in result as [NSManagedObject]{
                self.context.delete(data)
            }
            try self.context.save()
            print("삭제 성공")
        }catch{
            print("삭제 실패")
        }
    }
    
    func deleteAllBooks() {
        let fetchRequest: NSFetchRequest<BookInfoEntity> = BookInfoEntity.fetchRequest()
        
        do {
            let books = try context.fetch(fetchRequest)
            for book in books {
                context.delete(book)
            }
            try context.save()
            print("삭제 성공")
        } catch {
            print("삭제 실패")
        }
    }
}
