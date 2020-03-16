import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newsHeadLineTableView: UITableView!
    
    let apiClient = APIClient()
    var news = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsHeadLineTableView.delegate = self
        newsHeadLineTableView.dataSource = self
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHeadLineCell", for: indexPath) as! NewsHeadLineTableViewCell
        
        cell.topHeadLineLabel.text = news[indexPath.item].title
        cell.newsTimeLabel.text = news[indexPath.item].publishedAt
        
        
        
        return cell
    }
    

    
}
