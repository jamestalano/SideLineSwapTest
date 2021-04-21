//
//  ViewController.swift
//  SideLineSwapTest
//
//  Created by Mobile on 4/20/21.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UICollectionViewDelegate, UISearchResultsUpdating {

    private var productModel : ProductDetailModel = ProductDetailModel()
    private var isLoading = false
    private var productCollectionView: UICollectionView!
    private let searchController = UISearchController(searchResultsController: nil)
    private var productModelData : Products = Products()
    private var currentSearchText = ""
    
    private let queue = DispatchQueue(label: "Serial queue")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white

        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 12, bottom: 0, right: 12)
        let widthOfCell = (self.view.frame.size.width - 32)/2
        layout.itemSize = CGSize(width: widthOfCell, height: widthOfCell + 40)
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 0
        
        productCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        productCollectionView?.register(ProductCollectionCell.self, forCellWithReuseIdentifier: "ProductCollectionCell")
        productCollectionView.backgroundColor = UIColor.white
        
        view.addSubview(productCollectionView ?? UICollectionView())
        
        productCollectionView.dataSource = self
        productCollectionView.delegate = self

        view.addSubview(searchController.view)
        
        searchController.searchResultsUpdater = self
        //searchController.searchBar.delegate = self

        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Products"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoading) , productModelData.data.count > 0 {
            isLoading = true
            if productModelData.meta.paging.has_next_page{
                queue.async {
                    self.productModel.loadJSONData(page: self.productModelData.meta.paging.page+1, keyword: self.currentSearchText){
                   (output) in
                        self.productModelData = self.productModelData + output
                    DispatchQueue.main.async{
                        self.productCollectionView.reloadData()

                    }
                    }
                }
                isLoading = false

            }
        }
        if productModelData.data.count <= 0 {
            queue.async {

                self.productModel.loadJSONData(page: 1, keyword: "") {
                    (output) in
                    self.productModelData = output
                    DispatchQueue.main.async{
                        self.productCollectionView.reloadData()

                    }
                }
            }

        }
    }

    func searchBar(_ searchBar: UISearchBar,
                            textDidChange searchText: String){
        //print("searchText \(searchText)")
        

    }
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if currentSearchText == text{
            
        } else{
            currentSearchText = text
            productModelData.remove()
            queue.async {
                self.productModel.loadJSONData(page: self.productModelData.meta.paging.page+1, keyword: self.currentSearchText) {
                    (output) in
                    self.productModelData = output
                    DispatchQueue.main.async{
                        self.productCollectionView.reloadData()
                    }
            }
            }
        }
        //print(text)
    }
}

extension ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionCell", for: indexPath) as! ProductCollectionCell
        
        if let productModelItem = productModelData.data[indexPath.row] as Product? {
            productCell.priceText.text = "$" + String(productModelItem.price)
            productCell.titleText.text = productModelItem.name
            productCell.sellerName.text = productModelItem.seller.username
            
            productCell.bg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            productCell.bg.sd_setImage(with: URL(string : productModelItem.primary_image.thumb_url), placeholderImage: UIImage(named: "default"))
        }
        return productCell
    }
    
    // set number of collection view cells.
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productModelData.data.count
    }
}

extension Products {
  static func + (left: Products, right: Products) -> Products {
    return Products(data: left.data + right.data, meta: right.meta)
  }
}
