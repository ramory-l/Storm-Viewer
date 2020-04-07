//
//  ViewController.swift
//  Project1
//
//  Created by Mikhail Strizhenov on 05.04.2020.
//  Copyright © 2020 Mikhail Strizhenov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items.sorted() {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(appRecommendation))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.imageNumber = indexPath.row + 1
            vc.numberOfImages = pictures.count
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    @objc func appRecommendation() {
        let alert = UIAlertController(title: "Like our app?", message: "Please, recommend our app to other people!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Sure!", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

