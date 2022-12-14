//
//  ChooseLevelViewController.swift
//  app_doan_xe
//
//  Created by Son on 09/10/2021.
//

import UIKit
import SwiftKeychainWrapper
import AVFoundation

class ChooseLevelViewController: UIViewController {
    
    
    @IBOutlet weak var coinLabel: UILabel!
    
    @IBOutlet weak var ChooseLevelCLV: UICollectionView!
    
    @IBAction func settingAction() {
    }
    @IBAction func rankAction() {
        
    }
    @IBAction func storeAction() {
    }
    @IBAction func backAction() {
        dismiss(animated: true)
    }
    
    var levelLabel: String = ""
//    var totalAnswered: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        ChooseLevelCLV.delegate = self
        ChooseLevelCLV.dataSource = self
        
        ChooseLevelCLV.register(UINib(nibName: ChooseLevelCLVCell.className, bundle: nil), forCellWithReuseIdentifier: ChooseLevelCLVCell.className)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "PlayViewController") as! PlayViewController
        
        coinLabel.text = "\(vc.coin)"
    }
}

//--------------

extension ChooseLevelViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"ChooseLevelCLVCell", for: indexPath) as! ChooseLevelCLVCell
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "PlayViewController") as! PlayViewController
        
        for indexLevel in 1...7 {
            if indexPath.item == indexLevel - 1 && indexLevel == 1 {
                cell.LevelLabel.text = "Level \(indexLevel)"
                
                cell.currentProgressLabel.text = "0/70"
                cell.currentProgressView.progress = Float(0/Float(70))
                cell.currentProgressView.layer.cornerRadius = 8
                cell.currentProgressView.clipsToBounds = true
//                if (KeychainWrapper.standard.integer(forKey: "number\(indexLevel)") == nil) {
//                    cell.currentProgressLabel.text = "0/70"
//                }
//                else{
//                    let completed = KeychainWrapper.standard.integer(forKey: "number\(indexLevel)")
//                    cell.currentProgressView.layer.cornerRadius = 8
//                    cell.currentProgressView.clipsToBounds = true
//                    cell.currentProgressLabel.text = String(completed!) + "/70"
//                    cell.currentProgressView.progress +=  Float(KeychainWrapper.standard.float(forKey: "number\(indexLevel)")! / Float(70))
//                    totalAnswered += KeychainWrapper.standard.integer(forKey: "number\(indexLevel)")!
//                }

                cell.unlockedLevelImage.image = UIImage(imageLiteralResourceName: "\(indexLevel)")
                cell.unlockedLevelImage.layer.cornerRadius = cell.unlockedLevelImage.frame.size.width / 2
                cell.unlockedLevelImage.clipsToBounds = true
                cell.lockedLevelLabel.text = ""
            } else {
                if indexPath.item == indexLevel - 1 && indexLevel > 1 {
                    cell.LevelLabel.text = "Level \(indexLevel)"
                    
                    if vc.totalAnswered < 40 * (indexLevel - 1) { //fix 21
                        let view = UIView()
                        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
                        cell.backgroundView = view
                        cell.lockedLevelLabel.text = "Guess \(40 * (indexLevel - 1)) icons to unlock" //fix 21
                        cell.unlockedLevelImage.isHidden = true
                        cell.lockedLevelImage.layer.cornerRadius = cell.unlockedLevelImage.frame.size.width / 2
                        cell.lockedLevelImage.clipsToBounds = true
                        cell.currentProgressView.layer.cornerRadius = 8
                        cell.currentProgressView.clipsToBounds = true
                        cell.currentProgressView.isHidden = true
                        cell.currentProgressLabel.text = "0/70" //fix
                        cell.currentProgressView.progress = Float(0/Float(70))
                    } else {
                        if vc.totalAnswered >= 40 * (indexLevel - 1) {    //fix 21
                            cell.currentProgressLabel.text = "0/70"
                            cell.currentProgressView.progress = Float(0/Float(70))  //fix
                            cell.currentProgressView.layer.cornerRadius = 8
                            cell.currentProgressView.clipsToBounds = true
                        } else {
                            //let completed = KeychainWrapper.standard.integer(forKey: "number\(indexLevel)")
                            cell.currentProgressView.layer.cornerRadius = 8
                            cell.currentProgressView.clipsToBounds = true
                            //cell.currentProgressLabel.text = String(completed!) + "/70"
                            //cell.currentProgressView.progress +=  KeychainWrapper.standard.float(forKey: "number\(indexLevel)")! * 7/1000
                            //totalAnswered += KeychainWrapper.standard.integer(forKey: "number\(indexLevel)")!
                        }
                        cell.unlockedLevelImage.image = UIImage(imageLiteralResourceName: "\(70 * indexPath.item + 1)")
                        cell.unlockedLevelImage.layer.cornerRadius = cell.unlockedLevelImage.frame.size.width / 2
                        cell.unlockedLevelImage.clipsToBounds = true
                        cell.unlockedLevelImage.isHidden = false
                        cell.lockedLevelLabel.text = ""
                        cell.currentProgressView.isHidden = false

                    }
                    
//                    if (KeychainWrapper.standard.integer(forKey: "number\(indexLevel)") == nil && totalAnswered < 21) { //fix 21
//                        let view = UIView()
//                        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
//                        cell.backgroundView = view
//                        cell.lockedLevelLabel.text = "Guess 21 icons to unlock" //fix 21
//                        cell.unlockedLevelImage.image = UIImage(imageLiteralResourceName: "lockedimg")
//                        cell.unlockedLevelImage.layer.cornerRadius = cell.unlockedLevelImage.frame.size.width / 2
//                        cell.unlockedLevelImage.clipsToBounds = true
//                        cell.currentProgressView.layer.cornerRadius = 8
//                        cell.currentProgressView.clipsToBounds = true
//                        cell.currentProgressView.isHidden = true
//                        cell.currentProgressLabel.text = "0/70" //fix
//                    }
//                    else {
//                        if (KeychainWrapper.standard.integer(forKey: "number\(indexLevel)") == nil && totalAnswered >= 21) {    //fix 21
//                            cell.currentProgressLabel.text = "0/70" //fix
//                        }
//
//                        else{
//                            let completed = KeychainWrapper.standard.integer(forKey: "number\(indexLevel)")
//                            cell.currentProgressView.layer.cornerRadius = 8
//                            cell.currentProgressView.clipsToBounds = true
//                            cell.currentProgressLabel.text = String(completed!) + "/70"
//                            cell.currentProgressView.progress +=  KeychainWrapper.standard.float(forKey: "number\(indexLevel)")! * 7/1000
//                            totalAnswered += KeychainWrapper.standard.integer(forKey: "number\(indexLevel)")!
//                        }
//                        cell.unlockedLevelImage.image = UIImage(imageLiteralResourceName: "\(70 * indexLevel + 1)")
//                        cell.unlockedLevelImage.layer.cornerRadius = cell.unlockedLevelImage.frame.size.width / 2
//                        cell.unlockedLevelImage.clipsToBounds = true
//                        cell.lockedLevelLabel.text = ""
//                        cell.currentProgressView.isHidden = false
//
//                    }
                }
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
//-----------------
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChooseQuestionViewController") as! ChooseQuestionViewController
        let playVC = storyboard?.instantiateViewController(withIdentifier: "PlayViewController") as! PlayViewController
        
        vc.level = indexPath.item + 1
                
        for i in 0...6 {
            if indexPath.item == i && playVC.totalAnswered >= 40 * i {
                vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
                self.present(vc, animated: true, completion: nil)
                break
            }
        }
    }
}
//--------------------

extension ChooseLevelViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: ChooseLevelCLV.frame.width, height: 76)
        }
        return CGSize(width: ChooseLevelCLV.frame.width, height: 76)
    }
}

