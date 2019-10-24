//
//  ViewController.swift
//  Paint
//
//  Created by Julio Barrera on 9/17/19.
//  Copyright © 2019 Julio Barrera. All rights reserved.
//

import UIKit

class PaintDetailViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var redUISlider: UISlider!
    @IBOutlet weak var greenUiSlider: UISlider!
    @IBOutlet weak var blueUISlider: UISlider!
    
    
    // FIXME: Temporary variable
    var paint: Paint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateColorView()
        redUISlider.value = paint.red
        greenUiSlider.value = paint.green
        blueUISlider.value = paint.blue
    }
    
    @IBAction func onRedSliderChanged(_ sender: UISlider) {
        paint.red = sender.value
        updateColorView()
    }
    
    @IBAction func onGreenSliderChanged(_ sender: UISlider) {
        paint.green = sender.value
        updateColorView()
    }
    
    @IBAction func onBlueSliderChanged(_ sender: UISlider) {
        paint.blue = sender.value
        updateColorView()
    }
    
    @IBAction func onDarken(_ sender: Any) {
        paint.darken()
        updateColorView()
        updateSliders()
    }
    
    @IBAction func onBrightness(_ sender: Any) {
        paint.brighten()
        updateColorView()
        updateSliders()
    }
    
    @IBAction func onRandomize(_ sender: Any) {
        paint.randomize()
        updateColorView()
        updateSliders()
    }
    
    
    private func updateColorView() {
        colorView.backgroundColor = paint.color
        colorLabel.text = paint.hex
        colorLabel.textColor = paint.color.maxBright()
    }
    
    private func updateSliders() {
        redUISlider.setValue(paint.red, animated: true)
        greenUiSlider.setValue(paint.green, animated: true)
        blueUISlider.setValue(paint.blue, animated: true)
    }
}

extension UIColor {
    func maxBright() -> UIColor {
        var r:CGFloat = 0.0; var g:CGFloat = 0.0; var b:CGFloat = 0.0; var a:CGFloat = 0.0;
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            let d:CGFloat = 1.0 - max(r,g,b)
            return UIColor(red: r + d, green: g + d , blue: b + d, alpha: 1.0)

        }
        return self
    }
}
