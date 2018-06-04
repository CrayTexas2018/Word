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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set width of text area
        //setTextFieldWidth()
        // Load Puzzle
        let puzzle: Puzzle = loadPuzzle(puzzleId: puzzleId)
        // Load Hints
        let hints = loadHints(solutions: puzzle.solutions)
        // Load Solutions
        let solutions = loadSolutions(solutions: puzzle.solutions)
        // Load Tiles
        let tiles = loadTiles(solutions: puzzle.solutions)
        // Draw Tiles
        drawTiles(tiles: tiles)
    }
    
    private func loadPuzzle(puzzleId: Int) -> Puzzle
    {
        let puzzleRepo = PuzzleRepo()
        return puzzleRepo.getPuzzle(puzzle_id: puzzleId)
    }
    
    private func loadHints(solutions: [Solution]) -> [String]
    {
        var hintsList: [String] = []
        for solution in solutions {
            hintsList.append(solution.getSolutionHint(solution: solution))
        }
        
        return hintsList
    }
    
    private func loadSolutions(solutions: [Solution]) -> [String]
    {
        var solutionList: [String] = []
        for solution in solutions {
            solutionList.append(solution.getSolutionText(solution: solution))
        }
        
        return solutionList;
    }
    
    private func loadTiles(solutions: [Solution]) -> [Tile]
    {
        var tileList : [Tile] = []
        for solution in solutions {
            // Take solution and substring a random 1-3 letter until there are no more letters
            var s = Array(solution.getSolutionText(solution: solution))
            while s.count > 0
            {
                var text: String = ""
                let n = Int(arc4random_uniform(3)) + 1
                if (n > s.count)
                {
                    text += s
                    s.removeAll()
                }
                else
                {
                    for _ in 1...n
                    {
                        text += String(s[0])
                        s.remove(at: 0)
                    }
                }
                tileList.append(Tile(tile_id: 1, tile_text: text, is_selectable: true))
            }
        }
        return tileList
    }
    
    private func drawTiles(tiles: [Tile])
    {
        // Always have 4 rows, this determines columns
        let rows : CGFloat = 5
        let columns : CGFloat = ceil(CGFloat(tiles.count) / CGFloat(rows))
        let tileWidth : CGFloat = ((self.view.frame.size.width - 20) / columns)
        let tileHeight : CGFloat = 50
        
        var currentX: CGFloat = 7.5
        var currentY: CGFloat = self.view.frame.size.height - (tileHeight * rows) - 7.5 - 22.5
        
        print(columns, tileWidth, tileHeight, tiles.count)
        
        var i: Int = 0
        var firstRow = true
        for tile in tiles {
            if (i % Int(columns) == 0 && !firstRow)
            {
                i = 0
                currentX = 7.5
                currentY += 5 + tileHeight
            }
            firstRow = false
            
            let button = UIButton(type: UIButtonType.system) as UIButton
            
            let xPostion:CGFloat = currentX + (CGFloat(i) * tileWidth)
            let yPostion:CGFloat = currentY
            let buttonWidth:CGFloat = tileWidth
            let buttonHeight:CGFloat = tileHeight
            
            button.frame = CGRect(x:xPostion, y:yPostion, width:buttonWidth, height:buttonHeight)
            
            button.backgroundColor = UIColor.lightGray
            button.setTitle(tile.getTileText(tile: tile), for: UIControlState.normal)
            button.tintColor = UIColor.black
            button.addTarget(self, action: #selector(PuzzleViewController.buttonAction(_:)), for: .touchUpInside)
            
            self.view.addSubview(button)
            
            currentX += CGFloat(5) / columns
            i += 1
        }
    }
    
    private func setTextFieldWidth()
    {
        let screenWidth: CGFloat = self.view.frame.size.width
        let clearButtonWidth: CGFloat = clearButton.frame.size.width
        let submitButtonWidth: CGFloat = submitButton.frame.size.width
        let margin: CGFloat = 8
        textArea.frame.size.width = screenWidth - clearButtonWidth - submitButtonWidth - margin
        print(textArea.frame.size.width)
    }
    
    @objc func buttonAction(_ sender:UIButton!)
    {
        let currentText: String! = textArea.text
        let buttonText: String! = sender.currentTitle
        textArea.text = currentText + buttonText
        sender.isEnabled = false
    }
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        textArea.text = ""
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        //var puzzle = loadPuzzle(puzzleId: puzzleId)
        // See if text area text = solution
        let userText = textArea.text
        
        var i = 0
        for solution in puzzle.solutions {
            if (userText == solution.getSolutionText(solution: solution))
            {
                // Mark the solution
                puzzle.solutions[i].solution_solved = true
                // Record the tiles used (for release)
                
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
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return puzzle.solutions.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SolutionCell") as! SolutionCell
        cell.hintLabel.text = puzzle.solutions[indexPath.row].getSolutionHint(solution: puzzle.solutions[indexPath.row])
        cell.solutionLabel.text = puzzle.solutions[indexPath.row].getSolutionText(solution: puzzle.solutions[indexPath.row])
        cell.releaseButton.tag = puzzle.solutions[indexPath.row].getSolutionId(solution: puzzle.solutions[indexPath.row])
        cell.releaseButton.addTarget(self, action: #selector(self.releaseSolution), for: .touchUpInside)
        
        if (puzzle.solutions[indexPath.row].solution_solved)
        {
            cell.solutionLabel.textColor = UIColor.red
        }
        
        return cell
    }
    
    @objc func releaseSolution(sender:UIButton)
    {
     print("Button Pressed")
    }
}






