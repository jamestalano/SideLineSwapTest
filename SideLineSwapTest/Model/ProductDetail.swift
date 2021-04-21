//
//  ProductDetail.swift
//  SideLineSwapTest
//
//  Created by Mobile on 4/20/21.
//

import Foundation

struct Products:Codable{
    var data : [Product]
    var meta : Meta
    
    init() {
        self.data = [Product]()
        self.meta = Meta()
    }
    init(data : [Product], meta: Meta){
        self.data = data
        self.meta = meta
    }
    
    mutating func remove(){
        self.data.removeAll()
        self.meta.remove()
    }
}

struct Product:Codable{
    let id : Int
    let name : String
    let price : Float
    let url : String
    let seller : Seller
    let primary_image : PrimaryImages
}

struct Seller: Codable{
    let username : String
}

struct PrimaryImages : Codable{
    let thumb_url : String
}

struct Meta : Codable{
    var paging : Paging
    init(){
        paging = Paging()
    }
    mutating func remove(){
        self.paging.remove()
    }
}

struct Paging : Codable{
    var page : Int
    var total_count : Int?
    var total_pages : Int?
    var has_next_page : Bool
    
    init(){
        page = 0
        total_count = 0
        total_pages = 0
        has_next_page = false
    }
    mutating func remove(){
        self.page = 0
        self.total_count = 0
        self.total_pages = 0
        self.has_next_page = false
    }
}
