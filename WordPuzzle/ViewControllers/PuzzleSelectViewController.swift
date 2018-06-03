//
//  PuzzleSelectViewController.swift
//  WordPuzzle
//
//  Created by Cray Jaeger on 6/3/18.
//  Copyright © 2018 Cray Jaeger. All rights reserved.
//

import UIKit

class PuzzleSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    public var pack_id : Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load puzzles from DB where pack_id = pack_id
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
