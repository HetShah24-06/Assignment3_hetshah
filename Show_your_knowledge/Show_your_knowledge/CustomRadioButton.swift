//
//  CustomRadioButton.swift
//  Show_your_knowledge
//
//  Created by Het Shah on 2025-03-27.
//

import UIKit

class CustomRadioButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRadioButton()
    }
        
    required init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
        setupRadioButton()
    }
        
        
        
    private func setupRadioButton(){
        self.setImage(UIImage(systemName: "circle"), for: .normal)
        self.setImage(UIImage(systemName: "circle.inset.filled"), for: .selected)
        self.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
        
    @objc private func buttonClicked(){
        isSelected = !isSelected
    }
        
    func onUnselect(){
        isSelected = false
    }

}
