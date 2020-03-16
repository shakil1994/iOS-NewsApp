import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    let apiClient = APIClient()
    var source = [Source]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        getAllNewsSources()
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
        
        apiClient.getNewsSource { [weak self] response in
            switch response {
            case .success(let newsSource):
                DispatchQueue.main.async {
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
        let vc = storyboard?.instantiateViewController(identifier: "NewsArticle" ) as! NewsViewController

        self.navigationController?.pushViewController(vc, animated: true)
    }

}

