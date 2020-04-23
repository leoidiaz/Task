//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Leonardo Diaz on 4/22/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    //MARK: - Properties
    var delegate: ButtonTableViewCellDelegate?
    
    //MARK: - Actions
    @IBAction func buttonTapped(_ sender: Any) {
        guard let delegate = delegate else { return }
        delegate.buttonCellButtonTapped(self)
    }
    
    func updateButton(_ isComplete: Bool){
        if isComplete {
            completeButton.setImage(UIImage(named: "complete"), for: .normal)
        } else {
            completeButton.setImage(UIImage(named: "incomplete"), for: .normal)
        }
    }
    
}

extension ButtonTableViewCell {
    func update(withTask task: Task){
        primaryLabel.text = task.name
        updateButton(task.isComplete)
    }
}

protocol ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
}
