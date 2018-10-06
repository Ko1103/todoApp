//
//  TodoModel.swift
//  todoApp
//
//  Created by 山浦功 on 2018/10/06.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import RealmSwift

class TodoModel {

    class func read(completion: @escaping (Results<TodoEntity>) -> Void) {
        let realm = try! Realm()
        let todos = realm.objects(TodoEntity.self)
        completion(todos)
    }

    class func create(t: String, d: Date, m: String, completion:  @escaping (TodoEntity) -> Void) {
        let realm = try! Realm()
        let id = (realm.objects(TodoEntity.self).last?.id ?? 0) + 1
        var todo: TodoEntity = TodoEntity()
        try! realm.write {
            todo = realm.create(TodoEntity.self, value: ["id":id,"title":t, "date":d,"memo":m], update: false)
        }
        completion(todo)
    }

    class func update(id: Int, t: String, d: Date, m: String, completion: @escaping (TodoEntity?) -> Void){
        let realm = try! Realm()
        guard let todo = realm.objects(TodoEntity.self).first(where: {$0.id == id}) else {  return }
        try! realm.write {
            todo.title = t
            todo.date = d
            todo.memo = m
        }
        completion(todo)
    }

    class func delete(id: Int, completion: @escaping (TodoEntity) -> Void) {
        let realm = try! Realm()
        guard let todo = realm.objects(TodoEntity.self).first(where: { $0.id == id }) else { return }
        try! realm.write {
            realm.delete(todo)
        }
        completion(todo)
    }
}
