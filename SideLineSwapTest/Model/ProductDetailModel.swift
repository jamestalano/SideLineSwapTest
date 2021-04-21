//
//  ProductDetailModel.swift
//  SideLineSwapTest
//
//  Created by Mobile on 4/21/21.
//

import Foundation

class ProductDetailModel {
    
    private var urlString = "https://api.staging.sidelineswap.com/v1/facet_items"

    private var productsDictionary = Products ()
    
    func loadJSONData(page : Int, keyword : String, completionBlock: @escaping (Products) -> Void)  -> Void {
        var urlJSON : String
        if keyword == ""{
            urlJSON = urlString
            urlJSON += "?page="
            urlJSON += String(page)
        }
        else{
            urlJSON = urlString
            urlJSON += "?q="
            urlJSON += keyword
            urlJSON += "&page="
            urlJSON += String(page)
        }
        if let url = URL(string: urlJSON) {
            if (try? Data(contentsOf: url)) != nil {
                URLSession.shared.dataTask(with: url) { [self] data, response, error in
                      if let data = data {
                        
                        //Parse Json Data.
                        parse(json: data)
                        completionBlock(self.productsDictionary);
                        DispatchQueue.main.async {
                            // Put JSON data to collection view.
                        }
                       }
                   }.resume()
                }
            }
        /*
        if let url = URL(string: urlJSON) {
            if let data = try? Data(contentsOf: url) {
                // we're OK to parse!
                parse(json: data)
            }
        }*/
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        do{
            let jsonOffers =  try decoder.decode(Products.self, from: json)
            //print(jsonOffers)
            self.productsDictionary = jsonOffers
            
        } catch{
            print("parsing failed")
        }
    }
    
    init(){
    }
}
