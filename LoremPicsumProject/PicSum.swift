//
//  PicSum.swift
//  LoremPicsumProject
//
//  Created by Field Employee on 12/10/20.
//

import Foundation

struct PicSum: Decodable{
    let id: String
    let LoremImageURL: URL
    
    enum CodingKeys: String, CodingKey  {
        case id
        case download_url
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.LoremImageURL = try container.decode(URL.self, forKey: .download_url)
        
    }
}
