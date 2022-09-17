//
//  HomeViewController.swift
//  WhiteHousePetitions
//
//  Created by Shah Md Imran Hossain on 29/8/22.
//

import UIKit

class HomeViewController: UITableViewController {
    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadJson()
    }
    
    func loadJson() {
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            print("Showing all")
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            print("showing most recent")
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        guard let url = URL(string: urlString) else {
            print("urlString is not valid or nil")
            showError()
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let data = try? Data(contentsOf: url) else {
                print("fetching data from url is failed")
                self?.showError()
                return
            }
            
            // now, it's okay to parse json
            self?.parse(json: data)
        }
    }
    
    func showError() {
        DispatchQueue.main.async { [weak self] in
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(ac, animated: true)
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        guard let jsonPetitions = try? decoder.decode(Petitions.self, from: json) else {
            print("petitions json parsing failed")
            return
        }
        
        // Hurray! parsing done
        
        petitions = jsonPetitions.results
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - Table View Data source
extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let petition = petitions[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        
        return cell
    }
}

// MARK: - Table View Delegate
extension HomeViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
