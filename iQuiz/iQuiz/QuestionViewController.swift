//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Xiang Li on 2/16/19.
//  Copyright © 2019 Xiang Li. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

  
    @IBOutlet weak var choiceA: UIButton!
    @IBOutlet weak var choiceD: UIButton!
    @IBOutlet weak var choiceC: UIButton!
    @IBOutlet weak var choiceB: UIButton!
    var choices: [UIButton]! = nil
    
    var correctAnswerText: String = ""
    var userSelectionIndex: Int = -1
    var quizContent: [Quiz]? = nil
    var subjectIndex: Int = -1
    var totalAnswered: Int = 0
//    var questionText: String = ""
    var userAnswerText: String = ""
    var correctAnswerIndex: Int = -1
    var answeredRight: Bool = false
    var rightNum: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        choices = [choiceA, choiceB, choiceC, choiceD]

        questionLabel.text = quizContent?[subjectIndex].questions[totalAnswered].text
//        questionText = questionLabel.text!

        for i in 0...3 {
            choices[i].setTitle(quizContent?[subjectIndex].questions[totalAnswered].answers[i], for: .normal)
        }
    }
    
    @IBAction func selectA(_ sender: UIButton) {
        colorHelper(userSlection: 0)
    }
    
    @IBAction func selectB(_ sender: UIButton) {
        colorHelper(userSlection: 1)
    }

    @IBAction func selectC(_ sender: UIButton) {
        colorHelper(userSlection: 2)
    }
    
    @IBAction func selectD(_ sender: UIButton) {
        colorHelper(userSlection: 3)
    }
    
    func colorHelper(userSlection index: Int) {
        choices[index].backgroundColor = UIColor.blue
        correctAnswerIndex = Int(quizContent![subjectIndex].questions[totalAnswered].answer)!
        correctAnswerText = quizContent![subjectIndex].questions[totalAnswered].answers[correctAnswerIndex - 1]
        for i in 0...3 {
            if i != index {
                choices[i].backgroundColor = UIColor.lightGray
            } else {
                userSelectionIndex = i
                userAnswerText = quizContent![subjectIndex].questions[totalAnswered].answers[i]
            }
        }

    }

    
    
    @IBAction func submitAnswer(_ sender: UIButton) {
        performSegue(withIdentifier: "toAnswer", sender: self)
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAnswer" {
            let vc = segue.destination as! AnswerViewController
//            vc.questionText = questionText
            vc.correctAnswerText = correctAnswerText
            vc.userAnswerText = userAnswerText
            vc.correctAnswerIndex = correctAnswerIndex
            vc.userSelectionIndex = userSelectionIndex
            vc.totalAnswered = totalAnswered
            vc.quizContent = quizContent
            vc.subjectIndex = subjectIndex
            vc.rightNum = rightNum
        }
    }

}
