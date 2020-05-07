//
//  Song.swift
//  Albums
//
//  Created by Enzo Jimenez-Soto on 5/7/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

import Foundation

struct Song: Codable {
    
    // MARK: - Properties
    var id: String
    var duration: String
    var name: String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case duration
        case name
        
        enum DurationCodingKeys: String, CodingKey {
            case duration
        }
        
        enum NameCodingKeys: String, CodingKey {
            case title
        }
    }
    
    // MARK: - Initializers
    init (title: String, duration: String, id: String) {
        self.name = title
        self.duration = duration
        self.id = id
    }
    
    // MARK: - Codable
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        
        let id = try container.decode(String.self, forKey: .id)
        
        
        let durationContainer = try container.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
        let duration = try durationContainer.decode(String.self, forKey: .duration)
        
        
        let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.NameCodingKeys.self, forKey: .name)
        let name = try nameContainer.decode(String.self, forKey: .title)
        
        
        self.id = id
        self.duration = duration
        self.name = name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        
        try container.encode(id, forKey: .id)
        
       
        var durationContainer = container.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        
        
        var nameContainer = container.nestedContainer(keyedBy: CodingKeys.NameCodingKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
        
    }
}
