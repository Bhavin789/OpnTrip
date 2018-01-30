//
//  BannerViewControllerCollectionViewController.swift
//  Oinnfi
//
//  Created by Bhavin on 15/12/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit

class BannerViewControllerCollectionViewController: UICollectionViewController {
    
    var bannerTitle = [String]()
    var bannerImage = [String]()
    var bannerDetails = NSArray()
    
    private let reuseIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let itemSize = UIScreen.main.bounds.width/2 - 3
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize + 10)
        
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
        collectionView?.collectionViewLayout = layout
        
        if revealViewController() != nil{
            print("not nil")
            menuButton.target = self.revealViewController()
            menuButton.action = Selector("revealToggle:")
        }
        
        getData()
        
        setUpView()
        
    }
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpView(){
        let rightCustomeView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 44))
        let savedSearch = UIButton(frame: CGRect(x: 20, y: 7, width: 30, height: 30))
        savedSearch.setBackgroundImage(UIImage(named: "house"), for: .normal)
        savedSearch.tag = 101
        savedSearch.setTitleColor(UIColor.white, for: .normal)
        savedSearch.addTarget(self, action: #selector(rightButtonPressed), for: .touchUpInside)
        rightCustomeView.addSubview(savedSearch)
        
        let rightBarBtn = UIBarButtonItem(customView: rightCustomeView)
        navigationItem.rightBarButtonItem = rightBarBtn
    }
    
    @objc func rightButtonPressed(){
        print("right Button pressed")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print(bannerTitle.count)
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return bannerTitle.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? BannerCollectionViewCell
    
        print(bannerTitle[indexPath.row])
        cell?.bannerLabel.text = bannerTitle[indexPath.row]
       // cell?.categoryButton.addTarget(self, action: #selector(handleCategory), for: .touchUpInside)
        // Configure the cell
    
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      //  print(bannerTitle.count)
        let listViewController = CategoryTableViewController()
        
        listViewController.categoryName = bannerTitle[indexPath.row]
     //   print(listViewController.categoryName!)
        let banner = bannerDetails[indexPath.row]
        if let banner = banner as? [String: Any]{
               // print(banner)
                if let id = banner["id"] as? String, let categoryItems = banner["items"] as? NSArray{
                    listViewController.categoryId = id
                    print(id)
                    //print(categoryItems)
                    listViewController.categoryItems = categoryItems
                }
            }
        navigationController?.pushViewController(listViewController, animated: true)
    }
    
     func getData(){
        print("HI There")
        
        print("hi")
        let request = NSMutableURLRequest(url: NSURL(string: "http://www.opntrip.com/restfulapi/request.php?authkey=VR9RP1K2VU1YZ6FQNDDGJGWQWVX3IW1X&service=\("menu")")! as URL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request.url!) { (data, response, error) -> Void in
            
            if let data = data {
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let res = jsonResult["items"] as? NSArray{
                            self.bannerDetails = res
                            for banner in res{
                                if let banner = banner as? [String: Any]{
                                 
                                    if let bannerName = banner["text"] as? String, let bannerImageUrl = banner["image"] as? String{
                                        print(bannerName)
                                        self.add(bannerName)
                                        self.bannerImage.append(bannerImageUrl)
                                    }
                                }
                            }
                            
                            DispatchQueue.main.async {
                                print("Reloading from get data")
                                self.collectionView?.reloadData()
                            }
                        }
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
        print("Task completed")
    }
    
    func add(_ str: String){
        print("printing")
        bannerTitle.append(str)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
