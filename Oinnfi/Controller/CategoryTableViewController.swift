//
//  CategoryTableViewController.swift
//  Oinnfi
//
//  Created by Bhavin on 18/12/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    private let cellIdentifier = "cell"
    
    var categoryName: String!
    var categoryId: String!
    var categoryItems: NSArray!
    var categoryItemsName = [String]()
    var categoryItemImageUrl = [String]()
    var categoryItemId = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "Arial", size: 18.0)!]
        self.navigationItem.title = categoryName!
        getItems()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func getItems(){
        for item in categoryItems{
            if let item = item as? [String: Any]{
                if let title = item["text"] as? String, let url = item["image"] as? String, let id = item["id"] as? String {
                    categoryItemsName.append(title)
                    categoryItemImageUrl.append(url)
                    categoryItemId.append(id)
                }
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
            print("The count is")
            print(self.categoryItemsName.count)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CategoryTableViewCell
        
        print(categoryItemImageUrl[indexPath.row])
        
            cell?.setElements(categoryItemImageUrl[indexPath.row],categoryItemsName[indexPath.row])
        // Configure the cell...

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listViewController = ListForAudioViewController()
        listViewController.name = categoryItemsName[indexPath.row]
        listViewController.cat_id = categoryItemId[indexPath.row]
        self.navigationController?.pushViewController(listViewController, animated: true)
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
