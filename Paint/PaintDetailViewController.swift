import UIKit

class PaintDetailViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var redUISlider: UISlider!
    @IBOutlet weak var greenUiSlider: UISlider!
    @IBOutlet weak var blueUISlider: UISlider!
    
    // MARK: - Stored Properties
    var delegate: PaintDelegate?
    
    // FIXME: Temporary variable
    var paint: Paint!
    private var originalPaint: Paint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateColorView()
        originalPaint = paint
        redUISlider.value = paint.red
        greenUiSlider.value = paint.green
        blueUISlider.value = paint.blue
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if originalPaint != paint {
            delegate?.onPaintChanged(paint)
        }
    }
    
    @IBAction func onRedSliderChanged(_ sender: UISlider) {
        paint.red = sender.value
        //delegate?.onPaintChanged(paint)
        updateColorView()
    }
    
    @IBAction func onGreenSliderChanged(_ sender: UISlider) {
        paint.green = sender.value
        //delegate?.onPaintChanged(paint)
        updateColorView()
    }
    
    @IBAction func onBlueSliderChanged(_ sender: UISlider) {
        paint.blue = sender.value
        //delegate?.onPaintChanged(paint)
        updateColorView()
    }
    
    @IBAction func onDarken(_ sender: Any) {
        paint.darken()
        //delegate?.onPaintChanged(paint)
        updateColorView()
        updateSliders()
    }
    
    @IBAction func onBrightness(_ sender: Any) {
        paint.brighten()
        //delegate?.onPaintChanged(paint)
        updateColorView()
        updateSliders()
    }
    
    @IBAction func onRandomize(_ sender: Any) {
        paint.randomize()
        //delegate?.onPaintChanged(paint)
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
