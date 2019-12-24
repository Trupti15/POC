//
//  CountryInfo.swift
//  CountryFacts
//
//  Created by Trupti sahoo on 23/12/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation

struct CountryInfo: Codable {
    
    var title: String?
    var facts: [Facts]?
    
    enum CodingKeys: String, CodingKey {
        case title, facts = "rows"
    }
    
    init(title: String, facts: [Facts]) {
        self.title = title
        self.facts = facts
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        facts = try values.decodeIfPresent([Facts].self, forKey: .facts)
    }
    
}

struct Facts: Codable {
    
    var title: String?, description: String?, imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case title,description
        case imageUrl = "imageHref"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
    }
    
}
