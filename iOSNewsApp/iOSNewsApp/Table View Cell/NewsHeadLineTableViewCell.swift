import UIKit

class NewsHeadLineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsHeadLineImage: UIImageView!
    @IBOutlet weak var topHeadLineLabel: UILabel!
    @IBOutlet weak var newsTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
