//
//  TileUtility.swift
//  WordPuzzle
//
//  Created by Cray Jaeger on 6/4/18.
//  Copyright © 2018 Cray Jaeger. All rights reserved.
//

import Foundation
import UIKit

public class TileUtility
{
    /*
     Takes in array of solutions, turns each solution text into array
     of characters. Takes random number, maxTiles (default 3), characters,
     and creates a new tile. Ex: swift -> [[s], [wi], [ft]]
    */
    public static func loadTiles(solutions: [Solution], maxTiles: UInt32 = 3) -> [Tile]
    {
        var tileList : [Tile] = []
        var tileId = 1
        for solution in solutions {
            // Take solution and substring a random 1-maxTile letter until there are no more letters
            var s = Array(solution.getSolutionText(solution: solution))
            while s.count > 0
            {
                var text: String = ""
                let n = Int(arc4random_uniform(maxTiles)) + 1
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
                tileList.append(Tile(tile_id: tileId, tile_text: text, is_selectable: true))
                tileId += 1
            }
        }
        return tileList
    }
    
    /*
     Given rows, tileHeight, and tileCount return all dimensions of a tile
     */
    public static func getTileDimensions(rows: CGFloat, tileHeight: CGFloat = 50, tileCount: CGFloat, view: UIView, tileSpacing: CGFloat = 7.5, tilePadding: CGFloat = 22.5) -> [String: CGFloat]
    {
        let columns : CGFloat = ceil(CGFloat(tileCount) / CGFloat(rows))
        let width : CGFloat = ((view.frame.size.width - 20) / columns)
        let height : CGFloat = tileHeight
        
        return ["rows": rows, "columns": columns, "tileWidth": width, "tileHeight": height, "spacing": tileSpacing, "padding": tilePadding]
    }
    
    public static func getTileCoordinates(currentX: CGFloat, currentY: CGFloat, multiplier: CGFloat, tileWidth: CGFloat, tileHeight: CGFloat) -> [String: CGFloat]
    {
        let xPostion:CGFloat = currentX + (multiplier * tileWidth)
        let yPostion:CGFloat = currentY
        let buttonWidth:CGFloat = tileWidth
        let buttonHeight:CGFloat = tileHeight
        
        return ["xPos": xPostion, "yPos": yPostion, "buttonWidth": buttonWidth, "buttonHeight": buttonHeight]
    }
}





