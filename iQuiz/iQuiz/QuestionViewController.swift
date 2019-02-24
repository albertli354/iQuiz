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
    var userSelection: Int = -1
    var quizContent: [Quiz]? = nil
    var subjectIndex: Int? = nil
    var totalAnswered: Int = 0
    var questionText: String = ""
    var userAnswerText: String = ""
//    var rightNum: Int = 0

    @IBOutlet weak var questionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        choices = [choiceA, choiceB, choiceC, choiceD]
        
        questionLabel.text = quizContent![subjectIndex!].questions[totalAnswered].text
        questionText = questionLabel.text!

        for i in 0...3 {
            choices[i].setTitle(quizContent![subjectIndex!].questions[totalAnswered].answers[i], for: .normal)
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
        for i in 0...3 {
            if i != index {
                choices[i].backgroundColor = UIColor.lightGray
            } else {
                userSelection = i
                userAnswerText = quizContent![subjectIndex!].questions[totalAnswered].answers[i]
            }
        }
    }

    
    
    @IBAction func submitAnswer(_ sender: UIButton) {
        performSegue(withIdentifier: "toAnswer", sender: self)
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AnswerViewController
        vc.questionText = questionText
        vc.correctAnswerText = correctAnswerText
        vc.userAnswerText = userAnswerText
    }

}
