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
    
    let defaults = UserDefaults.standard
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var settingButton: UIBarButtonItem!
    var subjectsTitles: [String] = []
    var shortDescription: [String] = []
    var images = ["science.jpg", "marvel.png", "math.png"]
    var quizContent: [Quiz]? = nil
    var jsonUrl = "http://tednewardsandbox.site44.com/questions.json"
    // my own json url: https://api.myjson.com/bins/vhkue
    var userInput: UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    
    @IBAction func settingsAction(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Enter a URL to retrieve data online", preferredStyle: .alert)
        
        alert.addTextField { (textField : UITextField!) -> Void in
            self.userInput = textField
            self.userInput.placeholder = "Enter URL here"
        }
        
        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: nil))        
        alert.addAction(UIAlertAction(title: "check now", style: .default, handler: {
            (act: UIAlertAction) in
            //self.parseJson("https://api.myjson.com/bins/vhkue")
            if (self.userInput.text != nil) {
                self.parseJson(self.userInput.text!)
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
    
    // fetch json data
    func parseJson(_ jsonUrl: String) {
        guard let url = URL(string: jsonUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else { self.downloadFailAlert(); return }
            self.defaults.set(data, forKey: "initialQuizContent")
            do {
                self.quizContent = try JSONDecoder().decode([Quiz].self, from: data)
                self.contentHelper()
                
            } catch {
                self.downloadFailAlert()
            }
            DispatchQueue.main.async() {
                self.tableView.reloadData()
            }
        }.resume()
    }
    
    func contentHelper() {
        if !self.subjectsTitles.isEmpty {
            self.subjectsTitles.removeAll()
            self.shortDescription.removeAll()
        }
        for quiz in self.quizContent! {
            self.subjectsTitles.append(quiz.title)
            self.shortDescription.append(quiz.desc)
        }
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
        if Reachability.isConnectedToNetwork() {
            parseJson(jsonUrl)
        }else{
            noInternetAlert()
            do  {
                let defaultData = defaults.object(forKey: "initialQuizContent")
                self.quizContent = try JSONDecoder().decode([Quiz].self, from: defaultData as! Data)
                self.contentHelper()
            } catch {
                self.downloadFailAlert()
            }
            DispatchQueue.main.async() {
                self.tableView.reloadData()
            }
        }
    }
    
    func noInternetAlert() {
        let alert = UIAlertController(title: "Warning", message: "No internet, will use local data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func downloadFailAlert() {
        let alert = UIAlertController(title: "Warning", message: "Download Failed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}



