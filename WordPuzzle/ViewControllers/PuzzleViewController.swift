//
//  PuzzleViewController.swift
//  
//
//  Created by Cray Jaeger on 6/3/18.
//

import UIKit

class PuzzleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var textArea: UITextField!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var hintTable: UITableView!
    
    var puzzleId: Int = 0
    var puzzle: Puzzle = Puzzle(puzzle_id: 0, puzzle_name: "Error", solutions: [], tiles: [])
    var tileSequence: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load Puzzle
        puzzle = PuzzleRepo.getPuzzle(puzzle_id: puzzleId)
        // Load Tiles
        puzzle.tiles = TileUtility.loadTiles(solutions: puzzle.solutions)
        // Draw Tiles
        drawTiles(tiles: puzzle.tiles)
    }
    
    private func drawTiles(tiles: [Tile])
    {
        // Always have 5 rows, this determines columns
        let tileDimensions = TileUtility.getTileDimensions(rows: 5, tileHeight: 50, tileCount: CGFloat(tiles.count), view: self.view)
        
        // original x
        var currentX: CGFloat = 7.5
        // original y
        var currentY: CGFloat = self.view.frame.size.height - (tileDimensions["tileHeight"]! * tileDimensions["rows"]!) - tileDimensions["spacing"]!  - tileDimensions["padding"]!
        var multiplier: Int = 0
        var firstRow = true
        for tile in tiles
        {
            // Make a new row
            if (multiplier % Int(tileDimensions["columns"]!) == 0 && !firstRow)
            {
                multiplier = 0
                currentX = 7.5
                currentY += 5 + tileDimensions["tileHeight"]!
            }
            firstRow = false
            // Create button to host tile info
            let button = UIButton(type: UIButtonType.system) as UIButton
            // Get button coordinates
            let coordinates = TileUtility.getTileCoordinates(currentX: currentX, currentY: currentY, multiplier: CGFloat(multiplier), tileWidth: tileDimensions["tileWidth"]!, tileHeight: tileDimensions["tileHeight"]!)
            // Set button coordinates
            button.frame = CGRect(x: coordinates["xPos"]!, y: coordinates["yPos"]!, width: coordinates["buttonWidth"]!, height: coordinates["buttonHeight"]!)
            // Style button
            button.backgroundColor = UIColor.lightGray
            button.setTitle(tile.getTileText(tile: tile), for: UIControlState.normal)
            button.tintColor = UIColor.black
            button.tag = tile.getTileId(tile: tile)
            button.addTarget(self, action: #selector(PuzzleViewController.tileButtonPressed(_:)), for: .touchUpInside)
            // Add Button to view
            self.view.addSubview(button)
            // Adjust coordinates
            currentX += tileDimensions["spacing"]! / tileDimensions["columns"]!
            multiplier += 1
        }
    }
    
    @objc func tileButtonPressed(_ sender:UIButton!)
    {
        let currentText: String! = textArea.text
        let buttonText: String! = sender.currentTitle
        textArea.text = currentText + buttonText
        sender.isEnabled = false
        tileSequence.append(sender.tag)
    }
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        releaseTiles(puzzle: puzzle, tileSequence: tileSequence)
        textArea.text = ""
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        // See if text area text = solution
        let userText = textArea.text
        var i = 0
        for solution in puzzle.solutions {
            if (userText == solution.getSolutionText(solution: solution))
            {
                // Mark the solution
                puzzle.solutions[i].solution_solved = true
                // Record the tiles used (for release)
                puzzle.solutions[i].tile_sequence = tileSequence
                //Reset tile sequence
                tileSequence.removeAll()
                // Clear the text field
                textArea.text = ""
            }
            else
            {
                print("Wrong!")
            }
            i += 1
        }
        hintTable.reloadData()
    }
    
    // hint tableview number of rows
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return puzzle.solutions.count
    }
    
    // Create cells for hint tableview
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SolutionCell") as! SolutionCell
        cell.hintLabel.text = puzzle.solutions[indexPath.row].getSolutionHint(solution: puzzle.solutions[indexPath.row])
        cell.solutionLabel.text = puzzle.solutions[indexPath.row].getSolutionText(solution: puzzle.solutions[indexPath.row])
        cell.releaseButton.tag = puzzle.solutions[indexPath.row].getSolutionId(solution: puzzle.solutions[indexPath.row]) + 100
        cell.releaseButton.addTarget(self, action: #selector(self.releaseSolution), for: .touchUpInside)
        
        if (puzzle.solutions[indexPath.row].solution_solved)
        {
            cell.solutionLabel.textColor = UIColor.red
        }
        else
        {
            cell.solutionLabel.textColor = UIColor.green
        }
        
        return cell
    }
    
    // Player presses release button
    @objc func releaseSolution(sender:UIButton)
    {
        releaseTiles(puzzle: puzzle, tileSequence: puzzle.solutions[sender.tag - 101].tile_sequence)
        puzzle.solutions[sender.tag - 101].tile_sequence.removeAll()
        puzzle.solutions[sender.tag - 101].solution_solved = false
        hintTable.reloadData()
        print("Button Pressed")
    }
    
    /*
     If player wants to unsolve solution, in order to re-enable used tiles
    */
    private func releaseTiles(puzzle: Puzzle, tileSequence: [Int])
    {
        for tile in puzzle.tiles
        {
            if tileSequence.contains(tile.getTileId(tile: tile))
            {
                if let button = self.view.viewWithTag(tile.getTileId(tile: tile)) as? UIButton
                {
                    button.isEnabled = true
                }
            }
        }
    }
}






