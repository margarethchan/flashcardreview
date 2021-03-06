//
//  QuestionsTableViewController.swift
//  FlashcardReview
//
//  Created by C4Q on 2/17/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class QuestionsTableViewController: UITableViewController {

    @IBOutlet weak var quizBarButton: UIBarButtonItem!
    
    var category: String?
    
    var allQuestionsInDatabase: [Card] = [] {
        didSet {
            print("===== All Questions in Database: \(allQuestionsInDatabase) =====")
        }
    }
    
    var questions: [Card] = [] {
        didSet {
            tableView.reloadData()
            print("\(questions.count) cards set in \(category ?? "")")
            if questions.count >= 1 {
                quizBarButton.isEnabled = true
            } else {
                quizBarButton.isEnabled = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = category
    
        
        let currentUser = AuthUserService.manager.getCurrentUser()
        DBService.manager.getCardsFromCategory(fromUserID: (currentUser?.uid)!, category: category!) { (categoryCards) in
            self.questions = categoryCards
        }
        
        DBService.manager.getAllCards { (cards) in
            self.allQuestionsInDatabase = cards
        }
    }



    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath)
        let card = questions[indexPath.row]
        cell.textLabel?.text = card.question
        cell.detailTextLabel?.text = card.answer
        var status = ""
        if card.correct == false {
            status = "Need to Practice"
            cell.imageView?.image = #imageLiteral(resourceName: "x mark")
        } else {
            status = "Perfect"
            cell.imageView?.image = #imageLiteral(resourceName: "check mark")
        }
        
        return cell
    }





    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            switch id {
            case "AddCard":
                guard let destination = segue.destination as? NewCardViewController else { return }
                let selectedCategory = category
                destination.category = selectedCategory
            case "CardsToQuiz":
                guard let destination = segue.destination as? QuizViewController else { return }
                let selectedCategory = category
                let cardsForCategory = questions
                destination.category = selectedCategory
                destination.questions = cardsForCategory
            default:
                break
            }
        }
    }
 

}
