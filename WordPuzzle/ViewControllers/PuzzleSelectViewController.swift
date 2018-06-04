//
//  PuzzleSelectViewController.swift
//  WordPuzzle
//
//  Created by Cray Jaeger on 6/3/18.
//  Copyright © 2018 Cray Jaeger. All rights reserved.
//

import UIKit

class PuzzleSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pack_id: Int! = nil
    var puzzleList: [String] = []
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return puzzleList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PuzzleCell") as! PuzzleCell
        cell.PuzzleNameLabel.text = puzzleList[indexPath.row]
        cell.PuzzleDifficultyLabel.text = "Easy"
        cell.puzzleId = (indexPath.row + 1);
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load puzzles from DB where pack_id = pack_id
        puzzleList = PuzzleRepo.getPuzzleNames(pack_id: pack_id!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
