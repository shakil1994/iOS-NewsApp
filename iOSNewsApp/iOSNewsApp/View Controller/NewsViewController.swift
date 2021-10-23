import UIKit
import JGProgressHUD
import SDWebImage

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newsHeadLineTableView: UITableView!
    let hud = JGProgressHUD(style: JGProgressHUDStyle.extraLight)
    
    let apiClient = APIClient()
    var news = [Article]()
    var source: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsHeadLineTableView.delegate = self
        newsHeadLineTableView.dataSource = self
        getNewsArticles()    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHeadLineCell", for: indexPath) as! NewsHeadLineTableViewCell
        
        let imageUrl: NSURL? = NSURL(string: news[indexPath.item].urlToImage!)
        if let url = imageUrl {
            cell.newsHeadLineImage.sd_setImage(with: url as URL)
        }
        
        //cell.newsHeadLineImage.layer.cornerRadius = cell.newsHeadLineImage.frame.height / 2
        
        cell.topHeadLineLabel.text = news[indexPath.item].title
        cell.newsTimeLabel.text = news[indexPath.item].publishedAt
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "newsDetailsVC", sender: indexPath)
    }
    
    func getNewsArticles() {
        showHUD()
        if let source = source {
            apiClient.getNews(source: source) { response in
                switch response {
                case .success(let newsArticles):
                    DispatchQueue.main.sync {
                        self.hideHUD()
                        //print(newsArticles.articles[0].title)
                        self.news = newsArticles.articles
                        self.newsHeadLineTableView.reloadData()
                    }
                    
                case .failure(let error):
                    switch error {
                    case .responseError(let desp):
                        print(desp)
                    }
                }
            }
        }
    }
    
    private func showHUD(){
        hud.textLabel.text = "Loading ..."
        hud.show(in: self.newsHeadLineTableView)
    }
    
    private func hideHUD(){
        hud.dismiss()
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newsDetailsVC" {
            if let vc = segue.destination as? NewsDetailsViewController {
                let indexPath = sender as! IndexPath
                let sc = news[indexPath.item]
                vc.newsDetailsData = sc
            }
        }
    }
}
