//
//  ButtonTableViewCell.swift
//  ProjectCoreData
//
//  Created by Pete Parks on 4/22/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import UIKit



class ButtonTableViewCell: UITableViewCell {

    
    // MARK: Outlets
    @IBOutlet weak var primaryLabelOutelt: UILabel!
    @IBOutlet weak var completeButtonOutlet: UIButton!
    
    var delegate: ButtonTableViewCellDelegate?
    
    // MARK: Action

    @IBAction func buttonTappedAction(_ sender: UIButton) {
        guard let thedelegate = self.delegate else { return }
        thedelegate.buttonCellButtonTapped(self)
    }
    
    
    
    func updateButton(isComplete: Bool) {  // TODO why does homework notes have: updateButton(_ isComplete: Bool) function
        
        if isComplete {
            //completeButtonOutlet set to check marked iamge
            completeButtonOutlet.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        } else {
            //completeButtonOutlet set to open box
            completeButtonOutlet.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        }
        
    }
    
}

protocol ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
}

extension ButtonTableViewCell {
    func update(withTask task: Task) {

        //guard let task = withTask else { return }  // why don't we need a guard let????
        primaryLabelOutelt.text = task.name
        updateButton(isComplete: task.isComplete) // TODO why does homework notes have: updateButton(_ isComplete: Bool) function
    }
}


