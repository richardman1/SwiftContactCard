//
//  TableViewController.swift
//  sep1
//
//  Created by Richard de Jongh on 08/09/16.
//  Copyright © 2016 Richard de Jongh. All rights reserved.
//

import UIKit
import Alamofire

class TableViewController: UITableViewController {
    
    // Lege array
    var persons: [Person] = []
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Connect to db
        
        let restService = RestApiManager.sharedInstance
        
        
        for _ in 0..<20{
            restService.getRestPerson( onCompletion: {(person: Person?) -> Void in
                
                if(person != nil){
                    let database = DataBaseHelper.sharedInstance
                    database.create(firstname: (person?.firstName!)!, lastname: (person?.lastName!)!, imageUrl: (person?.largeImg!)!, email: (person?.email!)!, address: (person?.street!)!, city: (person?.city!)!, state: (person?.state!)!, phone: (person?.phone!)!, cell: (person?.cell!)!)
                    
                    self.persons.append(person!)
                    // Reload the tableview
                    self.tableView.reloadData()
                }
                
                
                print("REFRESHED INSIDE ONCOMPLETE")
            });

        }
        //Collect new person from server
        //CLOSURE METHODE
                print("REFRESHED OUTSIDE")
        
        //self.fillArrayWithDummyData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return persons.count
}
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonTableViewCell
        
         //Configure the cell...
        let row = persons[indexPath.row]
        cell.firstName?.text = row.firstName
        cell.lastName?.text = row.lastName
        
        //Set cell image
        Alamofire.request(row.mediumImg!, method: .get).responseData{ (response : DataResponse<Data>)
            in
            switch(response.result){
            case .success(_):
                let image = UIImage(data: response.result.value!)
                cell.imageThumbnail.image = image
                break;
                
            case .failure(_):
                break;
            }
        }
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        //check if segue is handled
        if(segue.identifier == "personDetail"){
            //get destination controller
            if let destination = segue.destination as? ViewController{
                //get selected row and lookup selected person in array
                if let indexPath = self.tableView.indexPathForSelectedRow{
                    //Pass person to detailed view
                    let person = persons[indexPath.row]
                    destination.person = person;
                }
            }
        }
    }
}
