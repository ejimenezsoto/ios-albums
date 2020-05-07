//
//  Album.swift
//  Albums
//
//  Created by Enzo Jimenez-Soto on 5/7/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

import  Foundation

class Album: Codable, CustomStringConvertible {
    
    // MARK: - Properties
    var description: String {
        return "'\(name)' by \(artist)"
    }
    
    var id: String
    var name: String
    var artist: String
    var coverArtURLs: [URL]
    var genres: [String]
    var songs: [Song]
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case artist
        case coverArtURLs = "coverArt"
        case genres
        case songs
        
        enum CoverArtCodingKeys: String, CodingKey {
            case url
        }
    }
    
    // MARK: - Initializers
    init(name: String, artist: String, genres: [String], coverArtURLs: [URL]) {
        self.name = name
        self.artist = artist
        self.genres = genres
        self.coverArtURLs = coverArtURLs
        self.id = UUID().uuidString
        self.songs = []
    }
    
    // MARK: - Codable
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        
        let artist = try container.decode(String.self, forKey: .artist)
        let id = try container.decode(String.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        
        
        var coverArtsContainer = try container.nestedUnkeyedContainer(forKey: .coverArtURLs)
        var coverArtURLStrings: [String] = []
        
        
        while !coverArtsContainer.isAtEnd {
            let coverArtContainer = try coverArtsContainer.nestedContainer(keyedBy: CodingKeys.CoverArtCodingKeys.self)
            let coverArtURLString = try coverArtContainer.decode(String.self, forKey: .url)
            coverArtURLStrings.append(coverArtURLString)
        }
        
        
        let coverArtURLs = coverArtURLStrings.compactMap() { URL(string: $0) }
        

        let genres = try container.decode([String].self, forKey: .genres)
        
        
        var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        var songs: [Song] = []
        
        
        while !songsContainer.isAtEnd {
            let song = try songsContainer.decode(Song.self)
            songs.append(song)
        }
        
        
        self.artist = artist
        self.name = name
        self.id = id
        self.coverArtURLs = coverArtURLs
        self.genres = genres
        self.songs = songs
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
    
        try container.encode(artist, forKey: .artist)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        
       
        var coverArtsContainer = container.nestedUnkeyedContainer(forKey: .coverArtURLs)
        
        
        for coverArtURL in coverArtURLs {
            var coverArtContainer = coverArtsContainer.nestedContainer(keyedBy: CodingKeys.CoverArtCodingKeys.self)
            try coverArtContainer.encode(coverArtURL.absoluteString, forKey: .url)
        }
        
        
        try container.encode(genres, forKey: .genres)
        try container.encode(songs, forKey: .songs)
    }
}

