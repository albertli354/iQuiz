//
//  ViewController.swift
//  iQuiz
//
//  Created by Xiang Li on 2/13/19.
//  Copyright © 2019 Xiang Li. All rights reserved.
//

import UIKit

// struct for storing json data
struct Quiz: Decodable {
    let title: String
    let desc: String
    let questions: [Question]
}

struct Question: Decodable {
    let text: String
    let answer: String
    let answers: [String]
}


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var settingButton: UIBarButtonItem!
    var subjectsTitles: [String] = []
    var shortDescription: [String] = []
    var images = ["science.jpg", "marvel.png", "math.png"]
    var quizContent: [Quiz]? = nil
    var jsonUrl = "http://tednewardsandbox.site44.com/questions.json"
    var userInput: UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        parseJson()
    }
    
    
    @IBAction func settingsAction(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Enter a URL to retrieve data online", preferredStyle: .alert)
        
        alert.addTextField { (textField : UITextField!) -> Void in
            self.userInput = textField
            self.userInput.placeholder = "Enter URL here"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            (act: UIAlertAction) in
            if (self.userInput.text != nil) {
                self.jsonUrl = self.userInput.text!
            }
        
        }
        ))
    
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectsTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subject")!
        cell.textLabel?.text = subjectsTitles[indexPath.row]
        cell.detailTextLabel?.text = shortDescription[indexPath.row]
        cell.imageView?.image = UIImage(named: images[indexPath.row])
        return cell
    }
    
    //    fetch json data
    func parseJson() {
        guard let url = URL(string: jsonUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else { return }
            
            do {
                self.quizContent = try JSONDecoder().decode([Quiz].self, from: data)
                for quiz in self.quizContent! {
                    self.subjectsTitles.append(quiz.title)
                    self.shortDescription.append(quiz.desc)
                }
                
            }catch let jsonError {
                print("Error: \(jsonError)")
            }
            DispatchQueue.main.async() {
                self.tableView.reloadData()
            }
        }.resume()
    }
    
    // pass index to the question view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let subjectIndex = indexPath.row
            let questionView = segue.destination as! QuestionViewController
            questionView.quizContent = self.quizContent
            questionView.subjectIndex = subjectIndex
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
        }else{
            print("Internet Connection not Available!")
        }
    }
    
    
}



