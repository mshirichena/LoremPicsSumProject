//
//  ViewController.swift
//  LoremPicsumProject
//
//  Created by Field Employee on 12/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var PicSumTableView: UITableView!
    
    var picsumArray: [PicSum] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getTenPicSum()
    }
    
    func getRandomURL() -> String {
        let randomNum = Int.random(in: 1...250)
        return "https://picsum.photos/id/\(randomNum)/info"
    }
    
    private func getTenPicSum(){
        self.PicSumTableView.register(UINib(nibName: "LoremPicsumTableViewCell", bundle: nil), forCellReuseIdentifier: "LoremPicsumTableViewCell")
        self.PicSumTableView.dataSource = self
        let group = DispatchGroup()
        for _ in 1...10 {
            group.enter()
            
            NetworkingManager.shared.getDecodableObject(from: self.createRandomPicsumURL()) { (picsum: PicSum?, error) in
                guard let picsum = picsum else {return}
                self.picsumArray.append(picsum)
                group.leave()
            }
            //    }
            group.notify(queue: .main) {
                self.PicSumTableView.reloadData()
            }
        }
        
    }
    
    
    private func createRandomPicsumURL () -> String {
        let randomNumber = Int.random(in: 1...100)
        return "https://picsum.photos/id/\(randomNumber)/info"
    }
    private func generateAlert(from error: Error) -> UIAlertController {
        let alert = UIAlertController (
            title: "Error", message: "We ran into an error! Error Description: \(error.localizedDescription)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        return alert
    }
}
    extension ViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.picsumArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoremPicsumTableViewCell", for: indexPath) as!
                LoremPicsumTableViewCell
            cell.configure(with: self.picsumArray[indexPath.row])
            return  cell
        }
        
    }



