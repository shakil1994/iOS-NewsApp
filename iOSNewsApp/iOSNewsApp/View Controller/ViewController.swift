import UIKit
import JGProgressHUD

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newsTableView: UITableView!
    let hud = JGProgressHUD(style: JGProgressHUDStyle.extraLight)
    
    let apiClient = APIClient()
    var source = [Source]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        getAllNewsSources()
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.black
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsSourceCell", for: indexPath) as! NewsSourceTableViewCell
        
        let newsSite = source[indexPath.row]
        
        cell.newsLabel.text = newsSite.name
        
        return cell
    }
    
    func getAllNewsSources() {
        showHUD()
        apiClient.getNewsSource { [weak self] response in
            switch response {
            case .success(let newsSource):
                DispatchQueue.main.async {
                    self?.hideHUD()
                    self?.source = newsSource.sources
                    self?.newsTableView.reloadData()
                    
                }
            case .failure(let error):
                switch error {
                    case .responseError(let desp):
                        print(desp)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "newsDetails", sender: indexPath)
    }
    
    private func showHUD(){
        hud.textLabel.text = "Loading ..."
        hud.show(in: self.newsTableView)
    }
    
    private func hideHUD(){
        hud.dismiss()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newsDetails" {
            if let vc = segue.destination as? NewsViewController {
                let indexPath = sender as! IndexPath
                let sc = source[indexPath.row].id
                vc.source = sc
            }
        }
    }

}

