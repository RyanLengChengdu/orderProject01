//
//  ddViewController.swift
//  project01
//
//  Created by 冷锐鹏 on 2022/3/24.
//

import UIKit

class ddViewController: UIViewController {
    var name : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        print("dsdsd")
    }
    //  此处要写 @objc才能被oc识别为swift代码
   @objc func setname(){
       print("dsdsd")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
