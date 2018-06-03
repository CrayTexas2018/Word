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
    var puzzle_id: Int
    var solutions: [Solution]
    var tiles: [Tile]
    
    init(puzzle_id: Int, solutions: [Solution], tiles: [Tile])
    {
        self.puzzle_id = puzzle_id
        self.solutions = solutions
        self.tiles = tiles
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
    public func getPuzzle(puzzle_id: Int) -> Puzzle
    {
        let solutionRepo: SolutionRepo = SolutionRepo()
        let tileRepo: TileRepo = TileRepo()
        
        return Puzzle(puzzle_id: puzzle_id, solutions: solutionRepo.getSolutions(puzzle_id: puzzle_id), tiles: tileRepo.getTiles(puzzle_id: puzzle_id))
    }
}
