//
//  Tile.swift
//  WordPuzzle
//
//  Created by Cray Jaeger on 6/3/18.
//  Copyright © 2018 Cray Jaeger. All rights reserved.
//

import Foundation

public struct Tile
{
    let tile_id: Int
    let tile_text: String
    let tile_tag: Int
    var is_selectable: Bool
    
    init(tile_id: Int, tile_text: String, is_selectable: Bool = true, tile_tag: Int = 0)
    {
        self.tile_id = tile_id
        self.tile_text = tile_text
        self.is_selectable = is_selectable
        self.tile_tag = tile_tag
    }
    
    public func getTileId(tile: Tile) -> Int
    {
        return tile.tile_id
    }
    
    public func getTileText(tile: Tile) -> String
    {
        return tile.tile_text
    }
    
    public func getTileSelectable(tile: Tile) -> Bool
    {
        return tile.is_selectable
    }
}

public class TileRepo
{
    public func getTile(tile_id: Int) -> Tile
    {
        return Tile(tile_id: tile_id, tile_text: "Tile Text Here")
    }
    
    public func getTiles(puzzle_id: Int) -> [Tile]
    {
        let t1 = getTile(tile_id: 1)
        let t2 = getTile(tile_id: 2)
        
        return [t1, t2]
    }
}
