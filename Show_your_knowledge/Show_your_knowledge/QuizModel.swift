//
//  QuizModel.swift
//  Show_your_knowledge
//
//  Created by Het Shah on 2025-03-27.
//

import Foundation

func update(updatedQuiz: Questions) {
    if let index = self.questions.firstIndex(where: { $0.id == updatedQuiz.id }) {
        self.questions[index] = updatedQuiz
        print("Question updated: \(updatedQuiz)")
        self.delagate?.didUpdateQuestion()
    } else {
        print("Question with ID \(updatedQuiz.id) not found for update.")
    }
}
}
