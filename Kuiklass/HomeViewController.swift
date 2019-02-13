//
//  HomeViewController.swift
//  Kuiklass
//
//  Created by Ana Torres Piedra on 10/01/2019.
//  Copyright © 2019 Ana Torres. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import RAMAnimatedTabBarController

class HomeViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var courseTable: UICollectionView!
    
    var xibCell = "CourseCollectionViewCell"
    var idCell = "CourseCell"

    var items: [Course]?
    var ref: DatabaseReference!
    let importInfo = ImportInfo.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = Auth.auth().currentUser

        self.courseTable.delegate = self
        self.courseTable.dataSource = self
        
        ref = Database.database().reference(withPath: "courses")
        courseTable.backgroundColor = UIColor.white
        courseTable.alwaysBounceVertical = true
        
        self.courseTable?.register(UINib(nibName: xibCell, bundle: nil), forCellWithReuseIdentifier: idCell)
        
        ref?.child(user!.uid).observe(.value, with: { snapshot in
            var newItems: [Course] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let courseItem = Course(snapshot: snapshot) {
                    newItems.append(courseItem)
                }
                
            }
            
            self.items = newItems
            self.courseTable.reloadData()
            self.courseTable.collectionViewLayout.invalidateLayout()
        })
        
    }
    
    @IBAction func logout (_ sender: Any){
        try! Auth.auth().signOut()
        
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Login")
        self.present(controller, animated: true, completion: nil)
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCell, for: indexPath) as! CourseCollectionViewCell
        
        cell.setUpViews()
        
        cell.courseName.text = self.items?[indexPath.row].name
        cell.courseDescription.text = self.items?[indexPath.row].description
        
        let url = URL(string: self.items?[indexPath.row].image ?? "")
        cell.courseImage.kf.setImage(with: url)
        cell.courseImage.contentMode = .scaleAspectFit
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWith()
        return CGSize(width: width, height: width)
    }
    
    // Realizo un calculo para saber que dimensiones tienen que tener las celdas
    func calculateWith() -> CGFloat {
        let estimateWidth = 160.0
        let cellMarginSize = 15.0
        
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
        
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize - 9) * (cellCount - 1) - margin) / cellCount
        
        return width
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "activities", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "activities"{

            let destViewController = segue.destination as! TabController
            

            if let itemIndex = courseTable.indexPathsForSelectedItems?.first?.item {
                let selectedItem = self.items?[itemIndex]
                destViewController.activities = selectedItem!.activities
                importInfo.currentCourse = selectedItem?.ref
                
            }

        }
    }
}
