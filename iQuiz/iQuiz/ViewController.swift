//
//  ViewController.swift
//  iQuiz
//
//  Created by Xiang Li on 2/13/19.
//  Copyright © 2019 Xiang Li. All rights reserved.
//

import UIKit





class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var settingButton: UIBarButtonItem!
    var subjectsTitles = ["Mathematics", "Marvel Super Heroes", "Science"]
    var shortDescription = ["The study of quantity, structure, space, and change", "Let's save the world", "A modern religion"]
    var images = ["math.jpg", "marvel.png", "science.png"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    
    @IBAction func settingsAction(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
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
    
    
    
    
}



