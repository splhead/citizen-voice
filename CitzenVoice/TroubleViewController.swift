//
//  ViewController.swift
//  CitzenVoice
//
//  Created by Splhead on 17/12/21.
//

import UIKit

class TroubleViewController: UIViewController {
    
    var trouble: Trouble?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let troubleFormViewController = segue.destination as? TroubleFormViewController {
            troubleFormViewController.trouble = trouble
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareScreen()
    }
    
    func prepareScreen() {
        
    }
}

