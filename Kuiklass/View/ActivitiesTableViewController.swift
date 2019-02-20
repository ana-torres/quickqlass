//
//  ActivitiesTableViewController.swift
//  Kuiklass
//
//  Created by Ana Torres Piedra on 19/01/2019.
//  Copyright © 2019 Ana Torres. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import RAMAnimatedTabBarController

class ActivitiesTableViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let idCell = "activityCell"
    let xibCell = "ActivityTableViewCell"
    var activities : [Activity] = []
    var ref: DatabaseReference?
    var importInfo = ImportInfo.shared
//
//
//
//    @objc func addTapped(){
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        tableView.register(UINib(nibName: xibCell, bundle: nil), forCellReuseIdentifier: idCell)
        
        let user = Auth.auth().currentUser
        ref = Database.database().reference(withPath: "courses").child(user!.uid).child((importInfo.currentCourse?.key)!).child("activities").child("category").child("exercises")
    
        ref?.queryOrdered(byChild: "completed").queryEqual(toValue: false).observe(.value, with: { snapshot in
            var newItems: [Activity] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let taskItem = Activity(snapshot: snapshot) {
                    newItems.append(taskItem)
                }
            }
            
            self.activities = newItems
            self.tableView.reloadData()
        })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath) as! ActivityTableViewCell
        let myActivity = activities[indexPath.row]
        
        cell.setActivityData(myActivity.name, myActivity.date, myActivity.completed)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = activities[indexPath.row]
            item.ref?.removeValue()
        }
        
        if editingStyle == .insert {
            let item = activities[indexPath.row]
            // Actualizar en firebase la tarea a completada
            item.ref?.updateChildValues(["completed": true])
        }
    }
    
    // Botones de scroll horizontal en el tableView
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .destructive, title: "Eliminar") { (action, indexPath) in
            self.deleteAction(indexPath: indexPath)
        }
        let completeButton = UITableViewRowAction(style: .normal, title: "Completar") { (action, indexPath) in
            self.tableView.dataSource?.tableView!(self.tableView, commit: .insert, forRowAt: indexPath)
        
        }
        
        deleteButton.backgroundColor = UIColor(red:0.75, green:0.10, blue:0.20, alpha:1.0)
        completeButton.backgroundColor = UIColor(red:0.31, green:0.80, blue:0.66, alpha:1.0)
        return [deleteButton, completeButton]
    }
    private func deleteAction(indexPath:IndexPath) {
        let alert = UIAlertController(title:"Eliminar",
                                      message: "¿Eliminamos la actividad?",
                                      preferredStyle: .alert)
        let deleteAction = UIAlertAction(title:"Sí", style: .default) { (action) in
            self.tableView.dataSource?.tableView!(self.tableView, commit: .delete, forRowAt: indexPath)
        }
        let cancelAction = UIAlertAction(title:"No", style: .default)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated:true)
    }
    
    //UIColor(red:0.94, green:0.75, blue:0.35, alpha:1.0) amarillo editar
    
    
}


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
