//
//  UpdateViewController.swift
//  Show_your_knowledge
//
//  Created by Het Shah on 2025-03-27.
//

import UIKit

class UpdateViewController: UIViewController {

    var selectQuestion: Questions?
    var localModel: Quiz?
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var correctAnswerTextField: UITextField!
    @IBOutlet weak var incorrect1TextField: UITextField!
    @IBOutlet weak var incorrect2TextField: UITextField!
    @IBOutlet weak var incorrect3TextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        localModel = ((UIApplication.shared.delegate) as! AppDelegate).model
        // Do any additional setup after loading the view.
        setupUIForUpdate()
    }
    
    private func setupUIForUpdate() {
        guard let question = selectQuestion else { return } // Exit if no question to update
        questionTextField.text = question.text
        correctAnswerTextField.text = question.answers
        incorrect1TextField.text = question.incorrect[0]
        incorrect2TextField.text = question.incorrect[1]
        incorrect3TextField.text = question.incorrect[2]
         // Change button title to "Update"
    }
    
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

            if var question = selectQuestion {
                // Update existing question
                question.text = questionText
                question.answers = correctAnswer
                question.incorrect = answers
                localModel?.update(updatedQuiz: question)
            } else {
                let newQuestion = Questions(id: UUID(), text: questionText, answers: correctAnswer, incorrect: answers)
                localModel?.add(newQuiz: newQuestion)
            }

            dismiss(animated: true, completion: nil)
        }

        private func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
