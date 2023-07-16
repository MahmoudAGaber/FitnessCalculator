//
//  BMIResultViewController.swift
//  FitnessCalulator
//
//  Created by MAG on 15/07/2023.
//

import UIKit

class BMIResultViewController: UIViewController {

    @IBOutlet var backView: UIView!
    @IBOutlet var contentView: UIView!


    init(){
        super.init(nibName: "BMIResultViewController", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
    }

    func configView(){
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 10
    }

    func appear(sender: UIViewController){
        sender.present(self, animated: false){
            self.show()
        }
    }

    private func show(){

    }


}
