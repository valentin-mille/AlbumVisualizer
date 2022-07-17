//
//  PhotoViewController.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/14/22.
//

import UIKit

class PhotoViewController: UIViewController {

    // MARK: - Properties
    var album: Album?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Photos"
        print("Current Album: ", album)
        // Do any additional setup after loading the view.
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
