//
//  QuestionBankTableViewCell.swift
//  Show_your_knowledge
//
//  Created by Het Shah on 2025-03-27.
//

import UIKit

class QuestionBankTableViewCell: UITableViewCell {

    @IBOutlet weak var QuestionLabel: UILabel!
    
    
    @IBOutlet weak var CorrectAnswer: UILabel!
    
    @IBOutlet weak var Incorrect1: UILabel!
    
    @IBOutlet weak var Incorrect2: UILabel!
    
    @IBOutlet weak var Incorrect3: UILabel!
    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
