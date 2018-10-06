//
//  TodoTableViewCell.swift
//  todoApp
//
//  Created by 山浦功 on 2018/10/06.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    func setup(title: String?, date: Date?) {
        titleLabel.text = title ?? "nil"
        dateLabel.text = date?.toStringJP() ?? "nil"
    }
}
