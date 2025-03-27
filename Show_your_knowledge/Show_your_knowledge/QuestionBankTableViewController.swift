//
//  QuestionBankTableViewController.swift
//  Show_your_knowledge
//
//  Created by Het Shah on 2025-03-27.
//

import UIKit

class QuestionBankTableViewController:UITableViewController, QuestionBankDelegate {
    func didAddQuestion() {
        questions = localModel?.questions ?? []
        tableView.reloadData()
    }
    
    func didUpdateQuestion() {
        questions = localModel?.questions ?? []
        tableView.reloadData()
    }
    var localModel: Quiz?
    var questions: [Questions] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        localModel = ((UIApplication.shared.delegate) as! AppDelegate).model
        questions = localModel?.questions ?? []
        Quiz.shared.delagate = self
    }

    // MARK: - Table View Data Source
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
           return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return localModel?.questions.count ?? 0
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuestionBankTableViewCell
        let question = questions[indexPath.row]
        
        cell.QuestionLabel?.text = question.text
        cell.CorrectAnswer?.text = question.answers
        cell.Incorrect1.text = question.incorrect[0]
        cell.Incorrect2.text = question.incorrect[1]
        cell.Incorrect3.text = question.incorrect[2]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "updateQuestion"{
            if let UpdateVC = segue.destination as? UpdateViewController{
                print("To Update View")
                let localModel = self.localModel
                let index  = tableView.indexPathForSelectedRow?.row ?? 0
                print(localModel?.questions[index])
                UpdateVC.selectQuestion = localModel?.questions[index]
                        
            }
                    
        }
    }
}
