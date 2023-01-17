//
//  ViewController.swift
//  Easycom Japan PH
//
//  Created by Michael Angelo Zafra on 1/16/23.
//

import UIKit
import JGProgressHUD

class ViewController: UIViewController {
    
    var entries:[Entry] = [Entry]()
    var segueData: Entry? = nil
    
    let cellReuseIdentifier = "cell"
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        let hud = JGProgressHUD()
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        getEntries(completion: {
            entries in
            self.entries = entries
            DispatchQueue.main.async {
                self.tableView.reloadData()
                hud.dismiss()
                print("Entries: \(self.entries.count)")
            }
        })
    }
    
    private func setupView() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let destVC = segue.destination as? UINavigationController,
                let targetController = destVC.topViewController as? DetailViewController {
                if let data = segueData {
                    targetController.data = data
                }
            }
        }
    }
}

extension ViewController : EntryCellDelegate {
    
    func shareURL(url:String) {
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        vc.popoverPresentationController?.sourceView = self.view
                
        self.present(vc, animated: true, completion: nil)
    }
    
    private func getEntries(completion:@escaping ([Entry]) -> ()) {
        guard let url = URL(string: "\(Constants.baseURL)/photos") else { return }

         let task = URLSession.shared.dataTask(with: url) { data, response, error in

             guard let data = data, error == nil else { return }
             
             do {
                 if let response = try? JSONDecoder().decode([Entry].self, from: data) {
                     completion(response)
                 }
             }

         }

         task.resume()
    }
}

// MARK: - Table
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.entries.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:EntryCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! EntryCell
        
        cell.delegate = self
        cell.idLbl.setTitle("ID: \(self.entries[indexPath.row].id ?? 0)", for: .normal)
        cell.lblTitle.text = self.entries[indexPath.row].title
        if let url = self.entries[indexPath.row].thumbnailUrl {
            cell.imageViewLogo.loadFrom(URLAddress: url)
            cell.url = url
        }
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        tableView.deselectRow(at: indexPath, animated: true)
        segueData = self.entries[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 178
    }
}
