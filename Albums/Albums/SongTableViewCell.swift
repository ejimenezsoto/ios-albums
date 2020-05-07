//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Enzo Jimenez-Soto on 5/7/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: class {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var song: Song? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: SongTableViewCellDelegate?

    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    // MARK: - UI Methods
    @IBAction func addSong(_ sender: Any) {
        guard let title = songTitleTextField.text, !title.isEmpty,
            let duration = songDurationTextField.text, !duration.isEmpty else { return }
        
        delegate?.addSong(with: title, duration: duration)
    }
    
    override func prepareForReuse() {
        songTitleTextField.text = nil
        songDurationTextField.text = nil
        addSongButton.isHidden = false
    }
    
    // MARK: - Utility Methods
    private func updateViews() {
        guard let song = song else { return }
        
        songDurationTextField.text = song.name
        songTitleTextField.text = song.duration
        addSongButton.isHidden = true
    }
    
}
