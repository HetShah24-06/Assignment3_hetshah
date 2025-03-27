//
//  RiddlesViewController.swift
//  Show_your_knowledge
//
//  Created by Het Shah on 2025-03-27.
//

import UIKit

class RiddlesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        @IBOutlet weak var questionLabel: UILabel!
        @IBOutlet weak var OptionOneRadio: CustomRadioButton!
        @IBOutlet weak var OptionTwoRadio: CustomRadioButton!
        @IBOutlet weak var OptionFourRadio: CustomRadioButton!
        @IBOutlet weak var OptionThreeRadio: CustomRadioButton!
        @IBOutlet weak var ProgressBar: UIProgressView!
        @IBOutlet weak var NextButton: UIButton!
        @IBOutlet weak var BackButton: UIButton!
        var quiz = Quiz.shared
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            loadQuestion()
            quiz = Quiz.shared
        }
        
        var currentQuestionIndex = 0
        var selectedAnswer: String?

        func setupUI() {
            BackButton.isHidden = true
            NextButton.isEnabled = false
            ProgressBar.progress = 0.0
        }

        func loadQuestion() {
            guard currentQuestionIndex < quiz.questions.count else {
                showResults()
                return
            }

                let question = quiz.questions[currentQuestionIndex]
                questionLabel.text = question.text
                let shuffledAnswers = question.shuffledAnswers()

                OptionOneRadio.setTitle(shuffledAnswers[0], for: .normal)
                OptionTwoRadio.setTitle(shuffledAnswers[1], for: .normal)
                OptionThreeRadio.setTitle(shuffledAnswers[2], for: .normal)
                OptionFourRadio.setTitle(shuffledAnswers[3], for: .normal)

                OptionOneRadio.isSelected = false
                OptionTwoRadio.isSelected = false
                OptionThreeRadio.isSelected = false
                OptionFourRadio.isSelected = false

                NextButton.isEnabled = false
                BackButton.isHidden = currentQuestionIndex == 0
                ProgressBar.progress = Float(currentQuestionIndex + 1) / Float(quiz.questions.count)
        }

        @IBAction func answerSelected(_ sender: CustomRadioButton) {
            selectedAnswer = sender.titleLabel?.text
            NextButton.isEnabled = true
            OptionOneRadio.isSelected = (sender == OptionOneRadio)
            OptionTwoRadio.isSelected = (sender == OptionTwoRadio)
            OptionThreeRadio.isSelected = (sender == OptionThreeRadio)
            OptionFourRadio.isSelected = (sender == OptionFourRadio)
        }

        @IBAction func nextButtonTapped(_ sender: UIButton) {
            if let selected = selectedAnswer, currentQuestionIndex < quiz.questions.count {
                if selected == quiz.questions[currentQuestionIndex].answers {
                    quiz.score += 1
                }
                quiz.userAnswers.append(selected)
            }

            currentQuestionIndex += 1
            loadQuestion()
        }

        @IBAction func backButtonTapped(_ sender: UIButton) {
            currentQuestionIndex -= 1
            if quiz.userAnswers.count > currentQuestionIndex {
                quiz.userAnswers.removeLast()
            }
            if quiz.score > 0 && quiz.userAnswers.count > 0 && quiz.userAnswers[currentQuestionIndex] != quiz.questions[currentQuestionIndex].answers{
                quiz.score -= 1
            }
            loadQuestion()
        }

        func showResults() {
            let alert = UIAlertController(title: "Quiz Results", message: "Your score: \(quiz.score) / \(quiz.questions.count)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            }))
            present(alert, animated: true, completion: nil)
        }
    }
