//
//  ViewController.swift
//  Bucket
//
//  Created by administrator on 12/12/2021.
//

import UIKit
import CoreData

class ViewController: UITableViewController {

    var tasksItems = [WelcomeElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllTasksFromApi()
        
    }
    
    func getAllTasksFromApi(){
        BucketListModel.getAllasks(completionHandler: {
            data, response, error in
            
            guard let myData = data else {return}
            
            do{
                let decoder = JSONDecoder()
                let result = try decoder.decode([WelcomeElement].self, from: myData)
                self.tasksItems = result
                self.updateTableView()
            } catch {
                print("getting error: \(error.localizedDescription)")
            }
        })
    }
    
    func updateTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasksItems[indexPath.row].objective
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            BucketListModel.deleteTask(id: tasksItems[indexPath.row].id, completionHandler: {
                data, response, error in
                self.getAllTasksFromApi()
            })
        }
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "Saving", sender: nil)
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "Saving", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let addViewController = segue.destination as! AddTableViewController
        addViewController.saveItemDeleagte = self
        if sender != nil {
            let index = sender as! Int
            let item = tasksItems[index]
            addViewController.index = item.id
            addViewController.item = item.objective
        }
    }
   
}


extension ViewController: SaveItemDelegate {
    func saveItem(item: String, at index: Int?) {
        if let at = index {
            BucketListModel.updateTask(objective: item, id: at, completionHandler: {
                data, response, error in
                self.getAllTasksFromApi()
            })
        }else {
            print(item)
            BucketListModel.addNewTask(objective: item, completionHandler: {
                data, response, error in
                print("adding - \(response)")
                self.getAllTasksFromApi()
            })
        }
    }
    
    
}
