//
//  QuizQuestions.swift
//  Show_your_knowledge
//
//  Created by Het Shah on 2025-03-27.
//

import Foundation

class Quiz {
    
    static var shared : Quiz = Quiz()
    var delagate : QuestionBankDelegate?
    
    var questions: [Questions] = [
        Questions(
            id: UUID(),
            text: "What is the capital of India?",
            answers: "Delhi",
            incorrect: ["Mumbai", "Bengaluru", "Ahemdabad"]
        ),
        Questions(
            id: UUID(),
            text: "7 + 3 * 2 - 4 / 2 = ?",
            answers: "11",
            incorrect: ["5", "13", "10"]
        ),
        Questions(
            id: UUID(),
            text: "How many days does the moon take to orbit around the Earth?",
            answers: "27",
            incorrect: ["1", "365", "60"]
        ),
        Questions(
            id: UUID(),
            text: "What is the 4th letter of the Greek alphabet?",
            answers: "Delta",
            incorrect: ["Gama", "Alpha", "octa"]
        )
    ]
    var currentQuestionIndex = 0
    var userAnswers: [String] = []
    var score = 0

   
    func calculateAverage() -> Double {
        guard !questions.isEmpty else {
            return 0.0
        }
        return Double(score) / Double(questions.count) * 100.0
    }
    
    func add(newQuiz: Questions) {

        if questions.contains(where: { $0.text.lowercased() == newQuiz.text.lowercased() }) {
            print("Duplicate question. Not added.")
            return
        }

    
        let allAnswers = newQuiz.incorrect + [newQuiz.answers]
        let uniqueAnswers = Set(allAnswers.map { $0.lowercased() })
        if uniqueAnswers.count != allAnswers.count {
            print("Duplicate options found in answers. Not added.")
            return
        }

        self.questions.append(newQuiz)
        print("Question added successfully:", newQuiz)
        delagate?.didAddedQuestion()
    }

    
    func update(updatedQuiz: Questions) {
//      checks if entered same ans in opitons
        if questions.contains(where: { $0.text.lowercased() == updatedQuiz.text.lowercased() && $0.id != updatedQuiz.id }) {
            print("Another question with the same text already exists. Update canceled.")
            return
        }
        let allAnswers = updatedQuiz.incorrect + [updatedQuiz.answers]
        let uniqueAnswers = Set(allAnswers.map { $0.lowercased() })
        if uniqueAnswers.count != allAnswers.count {
            print("Duplicate options found in answers. Update canceled.")
            return
        }
        if let index = self.questions.firstIndex(where: { $0.id == updatedQuiz.id }) {
            self.questions[index] = updatedQuiz
            print("Question updated successfully: \(updatedQuiz)")
            delagate?.didMadeChanges()
        } else {
            print("Question with ID \(updatedQuiz.id) not found for update.")
        }
    }

}
