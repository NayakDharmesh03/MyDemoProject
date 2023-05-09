//
//  ViewController.swift
//  NewAppProject
//
//  Created by Bhautik Dudhat on 24/04/23.
//

import UIKit

class ViewController: UIViewController {
// Commit by Darshan
    @IBOutlet weak var viewcontroller: UITableView!
    let viewcolors = [UIColor.yellow, UIColor.red,UIColor.green, UIColor.blue]

    var ExerciseNames = ["Running",
                         "Stretching",
                         "Push-Ups",
                         "Pull-ups"
                        ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
extension ViewController :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewcolors.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = viewcontroller.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VCTableCell
        cell.selectionStyle = .none
        cell.colorview.backgroundColor = viewcolors[indexPath.row]
        
        return cell
    }
    
    
}
