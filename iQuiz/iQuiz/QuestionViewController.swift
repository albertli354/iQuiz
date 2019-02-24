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
    
    @IBOutlet var choices: [UIButton]!
    var quizContent: [Quiz]? = nil
    var subjectIndex: Int? = nil
    
    var answeredNum: Int = 0
    var rightNum: Int = 0
    var wrongNum: Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func selectA(_ sender: Any) {
    }
    
    @IBAction func selectB(_ sender: Any) {
    }
    
    @IBAction func selectC(_ sender: Any) {
    }
    
    @IBAction func selectD(_ sender: Any) {
    }
    

    func colorHelper(_ index: Int) {
        <#function body#>
    }
    
}
