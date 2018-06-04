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
    let solution_text : String
    let solution_hint: String
    
    init(solution_id : Int, solution_text: String, solution_hint: String)
    {
        self.solution_id = solution_id
        self.solution_text = solution_text
        self.solution_hint = solution_hint
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
        let s1 = getSolution(solution_id: 1)
        let s2 = getSolution(solution_id: 2)
        let s3 = getSolution(solution_id: 2)
        let s4 = getSolution(solution_id: 2)
        let s5 = getSolution(solution_id: 2)
        let s6 = getSolution(solution_id: 2)
        
        return [s1, s2, s3, s4, s5, s6]
    }
    
    public func getSolution(solution_id: Int) -> Solution
    {
        let s = Solution(solution_id: solution_id, solution_text: "computer", solution_hint: "Solution Hint")
        
        return s
    }
}
