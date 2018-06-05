//
//  Puzzle.swift
//  WordPuzzle
//
//  Created by Cray Jaeger on 6/2/18.
//  Copyright © 2018 Cray Jaeger. All rights reserved.
//

import Foundation

public struct Puzzle
{
    let puzzle_id: Int
    let puzzle_name: String
    var solutions: [Solution]
    let content_id: Int
    var tiles: [Tile]
    var puzzleSolved: Bool
    
    
    init(puzzle_id: Int, puzzle_name: String, solutions: [Solution], tiles: [Tile], content_id: Int = 1, puzzleSolved: Bool = false)
    {
        self.puzzle_id = puzzle_id
        self.puzzle_name = puzzle_name
        self.solutions = solutions
        self.tiles = tiles
        self.content_id = content_id
        self.puzzleSolved = puzzleSolved
    }
    
    public func getPuzzleId(puzzle: Puzzle) -> Int
    {
        return puzzle.puzzle_id
    }
    
    public func getPuzzleSolutions(puzzle: Puzzle) -> [Solution]
    {
        return puzzle.solutions
    }
    
    public func getPuzzleTiles(puzzle: Puzzle) -> [Tile]
    {
        return puzzle.tiles
    }
}

public class PuzzleRepo
{
//    public static func getPuzzles(pack_id: Int) -> [Puzzle]
//    {
//        // Return list of all puzzles in a pack
//        
//    }
    
    public static func getPuzzleNames(pack_id: Int) -> [String]
    {
        // Return list of all puzzle names in a pack
        return ["Puzzle 1", "Puzzle 2", "Puzzle 3", "Puzzle 4", "Puzzle 5"]
    }
    
    public static func getPuzzle(puzzle_id: Int) -> Puzzle
    {
        // Make DB call
        let puzzle_name = "Puzzle Name"
        let solutionRepo: SolutionRepo = SolutionRepo()
        let tileRepo: TileRepo = TileRepo()
        
        return Puzzle(puzzle_id: puzzle_id, puzzle_name: puzzle_name, solutions: solutionRepo.getSolutions(puzzle_id: puzzle_id), tiles: tileRepo.getTiles(puzzle_id: puzzle_id))
    }
}
