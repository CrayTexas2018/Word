//
//  PuzzleCell.swift
//  WordPuzzle
//
//  Created by Cray Jaeger on 6/3/18.
//  Copyright © 2018 Cray Jaeger. All rights reserved.
//

import UIKit

class PuzzleCell: UITableViewCell {
    @IBOutlet weak var PuzzleView: UIView!
    @IBOutlet weak var PuzzleNameLabel: UILabel!
    @IBOutlet weak var PuzzleDifficultyLabel: UILabel!
    @IBOutlet weak var PuzzlePlayButton: UIButton!
    
    var puzzleId : Int? = nil
    
    @IBAction func PuzzlePlayButtonPressed(_ sender: Any) {
        print("Button Pressed. Puzzle ID = ", puzzleId)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
