//
//  ListTableViewController.swift
//  RecordConsumption
//
//  Created by 林祔利 on 2023/5/9.
//

import UIKit

class ListTableViewController: UITableViewController {

    var Listes = [List]()
    
    
    @IBAction func unwindToAddViewController(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? AddViewController, let item = sourceViewController.item {
            if let indexPath = tableView.indexPathForSelectedRow {
                Listes[indexPath.row] = item
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }else{
                
                Listes.insert(item, at: 0)
                let indexPath = IndexPath(row: 0, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
            List.saveItem(listes: Listes)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //一進來就先載入檔案路徑
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let url = docDir.appendingPathComponent("list")
        print(url)
        
        if let Listes = List.loadItem(){
            self.Listes = Listes
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        Listes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        List.saveItem(listes: Listes)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Listes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ListTableViewCell.self)", for: indexPath) as! ListTableViewCell
        let list = Listes[indexPath.row]
        
        cell.ItemName.text = list.name
        cell.ItemPrice.text = "\(list.price)"
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        cell.ItemDate.text = formatter.string(for: list.date)
        
        if list.check {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        
        
        if let imageName = list.image {
            let imageURL = List.documentsDirectory.appendingPathComponent(imageName).appendingPathExtension("jpg")
            let image = UIImage(contentsOfFile: imageURL.path)
            
            print("成功\(imageURL)")
            cell.ItemImage.image = image
        }else{
            print("失敗")
            cell.ItemImage.image = nil
        }


        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? AddViewController ,let row =
            tableView.indexPathForSelectedRow?.row {
            controller.item = Listes[row]
        }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

}
