//
//  IndexViewController.swift
//  todoApp
//
//  Created by 山浦功 on 2018/10/06.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import RealmSwift

class IndexViewController: UIViewController {

    @IBOutlet weak var todoTableView: UITableView!
    var todos: Results<TodoEntity>!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateUI()
    }

    private func setup() {
        todoTableView.delegate = self as? UITableViewDelegate
        todoTableView.dataSource = self as? UITableViewDataSource
    }

    @IBAction func toCreateView(_ sender: Any) {
        let createVC = self.storyboard?.instantiateViewController(withIdentifier: "create&edit") as! EditViewController
        createVC.style = .create
        present(createVC, animated: true, completion: nil)
    }

    func updateUI() {
        navigationController?.isToolbarHidden = true
        TodoModel.read { (tds) in
            self.todos = tds
        }
        todoTableView.reloadData()
    }
}

extension IndexViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoTableViewCell
        cell.setup(title: todos[indexPath.item].title, date: todos[indexPath.item].date)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailViewController
        detailVC.todo = todos[indexPath.item]
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
