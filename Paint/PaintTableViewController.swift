//
//  PaintTableViewController.swift
//  Paint
//
//  Created by Julio Barrera on 22/10/19.
//  Copyright © 2019 Julio Barrera. All rights reserved.
//

import UIKit

class PaintTableViewController: UITableViewController {
    
    var paints: [Paint] = []
    var currentSelectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paints = makeRandomPaints()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paints.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier",
                                                       for: indexPath) as? PaintTableViewCell else {
            return UITableViewCell()
        }
        
        let paint = paints[indexPath.row]
        cell.paintView.backgroundColor = paint.color
        cell.redLabel.text = paint.redHex
        cell.greenLabel.text = paint.greenHex
        cell.blueLabel.text = paint.blueHex
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSelectedIndexPath = indexPath
        let paint = paints[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let paintDetailVC = storyboard.instantiateViewController(withIdentifier: "PaintDetailViewController") as! PaintDetailViewController
        paintDetailVC.delegate = self
        paintDetailVC.paint = paint
        navigationController?.present(paintDetailVC, animated: true)
    }
    
    private func makeRandomPaints() -> [Paint] {
        var paints = [Paint]()
        
        for _ in 0..<30 {
            var paint = Paint()
            paint.randomize()
            paints.append(paint)
        }
        
        return paints
    }
    
    fileprivate func updateCurrentSelectedCell(with paint: Paint) {
        guard let selectedIndexPath = currentSelectedIndexPath else {
            return
        }
        paints[selectedIndexPath.row] = paint
        tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
    }
}

extension PaintTableViewController: PaintDelegate {
    func onPaintChanged(_ paint: Paint) {
        updateCurrentSelectedCell(with: paint)
    }
    
}
