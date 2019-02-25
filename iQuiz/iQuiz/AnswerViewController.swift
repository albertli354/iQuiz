//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Xiang Li on 2/16/19.
//  Copyright © 2019 Xiang Li. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

    var correctAnswerText: String = ""
    var userSelectionIndex: Int = -1
    var totalAnswered: Int = 0
    var rightNum: Int = 0
    var questionText: String = ""
    var userAnswerText: String = ""
    var correctAnswerIndex: Int = -1
    var answeredRight: Bool = false
    var quizContent: [Quiz]! = nil
    var subjectIndex: Int = -1
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    @IBOutlet weak var answerView: UILabel!
    @IBOutlet weak var indicatorView: UILabel!
    @IBOutlet weak var currectAnswerView: UILabel!
    @IBOutlet weak var userAnswerView: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        answerView.text = questionText
        currectAnswerView.text = correctAnswerText
        userAnswerView.text = userAnswerText
        setIndicator()
    }

    func setIndicator() {
        if (correctAnswerIndex - 1) == userSelectionIndex {
            rightNum += 1
            indicatorView.backgroundColor = UIColor.green
            indicatorView.text = "Congratulation, you are right"
        } else {
            indicatorView.backgroundColor = UIColor.lightGray
            indicatorView.text = "Sorry, you have to work harder"
        }
    }
    
    @IBAction func nextButton(_ sender: Any) {
        totalAnswered += 1
        if totalAnswered == (quizContent?[subjectIndex].questions.count)! {
            performSegue(withIdentifier: "toFinishView", sender: self)
        } else {
            performSegue(withIdentifier: "backToQuestion", sender: self)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToQuestion" {
            let vc = segue.destination as! QuestionViewController
            vc.totalAnswered = totalAnswered
            vc.rightNum = rightNum
        } else if (segue.identifier == "toFinishedView") {
            let vc = segue.destination as! FinishedViewController
        }
    }
    
    

}
