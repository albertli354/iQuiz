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
    var userSelection: Int = -1
    var totalAnswered: Int = 0
    var rightNum: Int = -1
    var questionText: String = ""
    var userAnswerText: String = ""
    
    @IBOutlet weak var answerView: UILabel!
    @IBOutlet weak var indicatorView: UILabel!
    @IBOutlet weak var currectAnswerView: UILabel!
    @IBOutlet weak var userAnswerView: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        answerView.text = questionText
        currectAnswerView.text = correctAnswerText
        userAnswerView.text = userAnswerText
    }


}
