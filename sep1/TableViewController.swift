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
        
        //Collect new person from server
        //CLOSURE METHODE
        restService.getRestPerson( onCompletion: {(person: Person?) -> Void in
            
            if(person != nil){
                person?.image = "asdf"
                let database = DataBaseHelper.sharedInstance
                database.create(firstname: (person?.firstName!)!, lastname: (person?.lastName!)!, imageUrl: (person?.image!)!, email: (person?.email!)!, address: (person?.street!)!, city: (person?.city!)!, state: (person?.state!)!, phone: (person?.phone!)!, cell: (person?.cell!)!)
                
                // Reload the tableview
                self.tableView.reloadData()
            }
            

            print("REFRESHED INSIDE ONCOMPLETE")
        });
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
        let row = indexPath.row
        cell.firstName?.text = persons[row].firstName
        cell.lastName?.text = persons[row].lastName
        
        return cell
    }
    
    func getRestPerson() {
        let person = Person()
        
        //var personemail = ""
        let url : String = "https://randomuser.me/api/"

        Alamofire.request(url,
                          method: .get,
                          encoding: URLEncoding.default).responseJSON { response in
                            if let json = response.result.value as? Dictionary<String, Any>{
                                //                                print("json: \(json)")
                                for field in json["results"] as? [AnyObject] ?? []{
                                    
                                    //Full name
                                    if let fullName = field["name"] as? [String : AnyObject]{
                                        //First name
                                        if let firstName = fullName["first"] as? String{
                                            person.firstName = firstName;
                                        }
                                        //Last name
                                        if let lastName = fullName["last"] as? String{
                                            person.lastName = lastName;
                                            
                                        }
                                    }
                                    //Location
                                    if let location = field["location"] as? [String : AnyObject]{
                                        //street
                                        if let street = location["street"] as? String{
                                            person.street = street;
                                        }
                                        if let city = location["city"] as? String{
                                            person.city = city;
                                        }
                                        if let state = location["state"] as? String{
                                            person.state = state;
                                        }
                                    }
                                    //Email
                                    if let email = field["email"] as? String{
                                        print(email);
                                        person.email = email;
                                    }
                                    //Phone
                                    if let phone = field["phone"] as? String{
                                        person.phone = phone;
                                    }
                                    //Cell
                                    if let cell = field["cell"] as? String{
                                        person.cell = cell;
                                    }
                                    
                                }
                                
                                self.persons.append(person)
                                self.tableView.reloadData()
                            
                            }
        }
        
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
