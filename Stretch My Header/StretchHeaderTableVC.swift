//
//  StretchHeaderTableVC.swift
//  Stretch My Header
//
//  Created by Aaron Chong on 2/27/18.
//  Copyright © 2018 Aaron Chong. All rights reserved.
//

import UIKit

class StretchHeaderTableVC: UITableViewController {
    
    var newsArray = [NewsItem]()
    var headerMaskLayer: CAShapeLayer!
    
    private let kTableHeaderHeight: CGFloat = 300.0
    private let kTableHeaderCutAway: CGFloat = 80.0
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    
    
    struct NewsItem {
        
        var categories: String
        var headlines: String
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        loadCategoryAndHeadlines()
    
        let date = NSDate()
        let stringDate = formatDate(date: date)
        dateLabel.text = "\(stringDate)"
    
        let effectiveHeight = kTableHeaderHeight - kTableHeaderCutAway/2
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
        
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.black.cgColor
        headerView.layer.mask = headerMaskLayer
        updateHeaderView()
        
        
        
    }
    
    // MARK: ScrollView Delegate
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        
        let news = newsArray[indexPath.row]
        
        cell.categoryLabel.text = news.categories
        cell.headlineLabel.text = news.headlines
        colorCategories(cell: cell)
        
        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    
    // MARK: Private Functions

    private func loadCategoryAndHeadlines() {
        
        let news1 = NewsItem(categories: "World", headlines:  "Climate change protests, divestments meet fossil fuels realities")
        let news2 = NewsItem(categories: "Europe", headlines: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime'")
        let news3 = NewsItem(categories: "Middle East", headlines: "Airstrikes boost Islamic State, FBI director warns more hostages possible")
        let news4 = NewsItem(categories: "Africa", headlines: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim")
        let news5 = NewsItem(categories: "Asia Pacific", headlines: "Despite UN ruling, Japan seeks backing for whale hunting")
        let news6 = NewsItem(categories: "Americas", headlines: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria")
        let news7 = NewsItem(categories: "World", headlines: "South Africa in $40 billion deal for Russian nuclear reactors")
        let news8 = NewsItem(categories: "Europe", headlines: "'One million babies' created by EU student exchanges")
        
        newsArray = [news1, news2, news3, news4, news5, news6, news7, news8]
    }
    
    private func colorCategories(cell: NewsTableViewCell) {
        
        if cell.categoryLabel.text == "World" {
            cell.categoryLabel.textColor = .red
        }
        if cell.categoryLabel.text == "Americas" {
            cell.categoryLabel.textColor = .blue
        }
        if cell.categoryLabel.text == "Europe" {
            cell.categoryLabel.textColor = .green
        }
        if cell.categoryLabel.text == "Middle East" {
            cell.categoryLabel.textColor = .yellow
        }
        if cell.categoryLabel.text == "Africa" {
            cell.categoryLabel.textColor = .orange
        }
        if cell.categoryLabel.text == "Asia Pacific" {
            cell.categoryLabel.textColor = .purple
        }
    }
    
    private func formatDate(date: NSDate) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, YYYY"
        let date = dateFormatter.string(from: (date as Date))
        
        return date
    }
    
    private func updateHeaderView() {
        
        let effectiveHeight = kTableHeaderHeight - kTableHeaderCutAway/2
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.height, height: kTableHeaderHeight)
        if tableView.contentOffset.y < -effectiveHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y + kTableHeaderCutAway/2
        }
        headerView.frame = headerRect
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLine(to: CGPoint(x: 0, y: headerRect.height - kTableHeaderCutAway))
        headerMaskLayer?.path = path.cgPath
    }
}
