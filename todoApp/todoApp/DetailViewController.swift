//
//  DetailViewController.swift
//  todoApp
//
//  Created by 山浦功 on 2018/10/06.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var memoTextView: UITextView!

    var todo: TodoEntity? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func setup() {
        navigationItem.title = "詳細"
        navigationController?.delegate = self as! UINavigationControllerDelegate
        self.updateUI()
    }

    private func updateUI() {
        titleLabel.text = todo?.title ?? "nil"
        dateLabel.text = todo?.date.toStringJP() ?? "nil"
        memoTextView.text = todo?.memo ?? "nil"
        navigationController?.isToolbarHidden = false
    }

    @IBAction func editAction(_ sender: Any) {
        let updateVC = storyboard?.instantiateViewController(withIdentifier: "create&edit") as! EditViewController
        updateVC.style = .update
        updateVC.todo = todo
        present(updateVC, animated: true, completion: nil)
    }

    @IBAction func deleteAction(_ sender: Any) {
        TodoModel.delete(id: (todo?.id)!) { _ in
            let indexVC = self.navigationController?.viewControllers[0] as! IndexViewController
            indexVC.updateUI()
        }
        navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let indexVC = viewController as? IndexViewController else { return }
        indexVC.updateUI()
    }
}
