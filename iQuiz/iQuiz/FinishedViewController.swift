//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Xiang Li on 2/16/19.
//  Copyright © 2019 Xiang Li. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {
    var rightNum: Int = 0
    var totalAnswered: Int = 0
    
    @IBOutlet weak var descriptiveText: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addWords()
        scoreLabel.text = "\(rightNum) of \(totalAnswered) correct"
    }
    
    func addWords() {
        if (rightNum == totalAnswered) {
            descriptiveText.text = "Perfect! Your answers are all correct!"
        } else if (rightNum == 0) {
            descriptiveText.text = "Sorry, you should put more effort."
        } else {
            descriptiveText.text = "Good job!"
        }
    }
}
