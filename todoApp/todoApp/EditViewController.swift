//
//  EditViewController.swift
//  todoApp
//
//  Created by 山浦功 on 2018/10/06.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

enum ViewStyle {
    case create
    case update
}

class EditViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var navigationbar: UINavigationBar!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var memoTextView: UITextView!

    var todo: TodoEntity? = nil
    var style: ViewStyle = .create

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func setup() {
        navigationbar.delegate = self as UINavigationBarDelegate
        self.datePicker.addTarget(self, action: #selector(pickerValueChanged(_:)), for: .valueChanged)
        switch style {
        case .create:
            self.navigationbar.topItem?.title = "新規作成"
            self.titleTextField.text = ""
            self.dateLabel.text = datePicker.date.toStringJP()
            self.memoTextView.text = ""
        case .update:
            self.navigationbar.topItem?.title = "編集"
            self.titleTextField.text = todo?.title
            self.dateLabel.text = todo?.date.toStringJP()
            self.datePicker.date = todo?.date ?? Date()
            self.memoTextView.text = todo?.memo ?? "nil"
        }
    }

    @IBAction func pickerValueChanged(_ sender: UIDatePicker) {
        dateLabel.text = sender.date.toStringJP()
    }

    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func doneAction(_ sender: Any) {
        guard titleTextField.text == "" else {
            switch style {
            case .create:
                TodoModel.create(t: titleTextField.text!, d: datePicker.date, m: memoTextView.text) { _ in
                    let navigationVC = self.presentingViewController as! UINavigationController
                    let indexVC = navigationVC.viewControllers[0] as! IndexViewController
                    indexVC.updateUI()
                }
            case .update:
                TodoModel.update(id: (todo?.id)!, t: titleTextField.text!, d: datePicker.date, m: memoTextView.text) { _ in
                    let navigationVC = self.presentingViewController as! UINavigationController
                    let detailVC = navigationVC.topViewController as! DetailViewController
                    detailVC.todo = self.todo
                    detailVC.updateUI()
                }
            }
            self.dismiss(animated: true, completion: nil)
            return
        }
    }
}

extension EditViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
