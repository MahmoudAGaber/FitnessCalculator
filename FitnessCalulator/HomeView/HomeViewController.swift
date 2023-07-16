//
//  ViewController.swift
//  FitnessCalulator
//
//  Created by MAG on 13/07/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var maleView: UIView!
    @IBOutlet var feMaleView: UIView!
    @IBOutlet var BMICalcualtorView: UIView!

    @IBOutlet var maleLabel: UILabel!
    @IBOutlet var maleSymboleImg: UIImageView!

    @IBOutlet var femaleLabel: UILabel!
    @IBOutlet var feMaleSymboleImg: UIImageView!

    @IBOutlet var hightLabel: UILabel!
    @IBOutlet var weigthLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!

    @IBOutlet var slider: UISlider!

    var weight = 70
    var age = 24
    var height = 185



    override func viewDidLoad() {
        super.viewDidLoad()
        slider.minimumValue = 0
        slider.maximumValue = 3
        slider.value = 1.85
        initUiWidget()

        NetworkServices.shared.getBIMCalculatro(){ result in
            switch result {
            case .success(let resposne):
                print(resposne)
            case .failure(let error):
                print(error)
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        let gestureMaleRec = UITapGestureRecognizer(target: self, action: #selector(maleViewTapped))
        maleView.addGestureRecognizer(gestureMaleRec)

        let gestureFemaleRec = UITapGestureRecognizer(target: self, action: #selector(femaleViewTapped))
        feMaleView.addGestureRecognizer(gestureFemaleRec)

        let gestureBMICalculatorRec = UITapGestureRecognizer(target: self, action: #selector(BMICalculatorTapped))
        BMICalcualtorView.addGestureRecognizer(gestureBMICalculatorRec)
    }

    @objc private func maleViewTapped(){
        maleLabel.textColor = .white
        maleSymboleImg.tintColor = .white

        femaleLabel.textColor = .opaqueSeparator
        feMaleSymboleImg.tintColor = .opaqueSeparator
    }

    @objc private func femaleViewTapped(){
        femaleLabel.textColor = .white
        feMaleSymboleImg.tintColor = .white

        maleLabel.textColor = .opaqueSeparator
        maleSymboleImg.tintColor = .opaqueSeparator
    }

    @objc private func BMICalculatorTapped(){
        let alertController = UIAlertController(title: "Alert", message: "This is a dialog!", preferredStyle: .alert)

        alertController.preferredContentSize = CGSize(width: 300, height: 200)
           // Add an action to the alert
           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alertController.addAction(okAction)

           // Present the alert controller
           present(alertController, animated: true, completion: nil)
    }


    func initUiWidget(){
        hightLabel.text = String(height)
        weigthLabel.text = String(weight)
        ageLabel.text = String(age)
    }


    @IBAction func hightSlider(_ sender: UISlider) {
        let value = sender.value
        let valuePerc = value * 100
        height = Int(valuePerc)
        hightLabel.text = String(height)
    }

    @IBAction func increaseWeightBtn(_ sender: Any) {
        weight = weight + 1
        weigthLabel.text = String(weight)
    }

    @IBAction func decreaseWeightBtn(_ sender: Any) {
        weight = weight - 1
        weigthLabel.text = String(weight)
    }


    @IBAction func increaseAgeBtn(_ sender: Any) {
        age = age + 1
        ageLabel.text = String(age)
    }

    @IBAction func decreaseAgeBtn(_ sender: Any) {
        age = age - 1
        ageLabel.text = String(age)
    }

}

