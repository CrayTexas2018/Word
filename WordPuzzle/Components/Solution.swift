//
//  Solution.swift
//  WordPuzzle
//
//  Created by Cray Jaeger on 6/3/18.
//  Copyright © 2018 Cray Jaeger. All rights reserved.
//

import Foundation

public struct Solution
{
    let solution_id : Int
    var solution_text : String
    let solution_hint: String
    var solution_solved: Bool
    var tile_sequence: [Int]
    
    init(solution_id : Int, solution_text: String, solution_hint: String, solution_solved: Bool = false, tile_sequence: [Int] = [])
    {
        self.solution_id = solution_id
        self.solution_text = solution_text
        self.solution_hint = solution_hint
        self.solution_solved = solution_solved
        self.tile_sequence = tile_sequence
    }
    
    public func getSolutionId(solution: Solution) -> Int
    {
        return solution.solution_id
    }
    
    public func getSolutionText(solution: Solution) -> String
    {
        return solution.solution_text
    }
    
    public func getSolutionHint(solution: Solution) -> String
    {
        return solution.solution_hint
    }
}

public class SolutionRepo
{
    public func getSolutions(puzzle_id: Int) -> [Solution]
    {
        var s1 = getSolution(solution_id: 1)
        var s2 = getSolution(solution_id: 2)
        var s3 = getSolution(solution_id: 3)
        var s4 = getSolution(solution_id: 4)
        var s5 = getSolution(solution_id: 5)
        var s6 = getSolution(solution_id: 6)
        
        s2.solution_text = "apple"
        s3.solution_text = "headphones"
        s4.solution_text = "keyboard"
        s5.solution_text = "water"
        s6.solution_text = "fajitas"
        
        return [s1, s2, s3, s4, s5, s6]
    }
    
    public func getSolution(solution_id: Int) -> Solution
    {
        let s = Solution(solution_id: solution_id, solution_text: "computer", solution_hint: "Solution Hint")
        
        return s
    }
}
