//
//  QuestionBuilderViewController.swift
//  Show_your_knowledge
//
//  Created by Het Shah on 2025-03-27.
//

import UIKit

class QuestionBuilderViewController: UIViewController {
    var localModel: Quiz?
    // MARK: - IBOutlets
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var correctAnswerTextField: UITextField!
    @IBOutlet weak var incorrect1TextField: UITextField!
    @IBOutlet weak var incorrect2TextField: UITextField!
    @IBOutlet weak var incorrect3TextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        localModel = ((UIApplication.shared.delegate) as! AppDelegate).model
    }
    
    

    // MARK: - IBActions
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func doneButtonTapped(_ sender: UIButton) {
        guard let questionText = questionTextField.text, !questionText.isEmpty,
              let correctAnswer = correctAnswerTextField.text, !correctAnswer.isEmpty,
              let incorrect1 = incorrect1TextField.text, !incorrect1.isEmpty,
              let incorrect2 = incorrect2TextField.text, !incorrect2.isEmpty,
              let incorrect3 = incorrect3TextField.text, !incorrect3.isEmpty else {
            showAlert(title: "Missing Information", message: "Please fill in all fields.")
            return
        }
        let answers = [incorrect1, incorrect2, incorrect3]
        let newQuestion = Questions(id: UUID(), text: questionText, answers: correctAnswer, incorrect: answers)
        localModel?.add(newQuiz: newQuestion)
        dismiss(animated: true, completion: nil)
    }

  
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
