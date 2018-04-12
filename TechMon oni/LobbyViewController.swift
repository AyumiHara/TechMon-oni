//
//  LobbyViewController.swift
//  TechMon oni
//
//  Created by 原 あゆみ on 2018/04/13.
//  Copyright © 2018年 原あゆみ. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {
    
    var maxStamina : Float = 100
    var stamina : Float = 100
    var player : Player = Player()
    var staminaTimer : Timer!
    
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var staminaBar : UIProgressView!
    @IBOutlet var levelLabel : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        staminaBar.transform = CGAffineTransform(scaleX: 1.0, y: 4.0)
        
        nameLabel.text = player.name
        levelLabel.text = String(format: "LV. %d", player.level)
        
        stamina = maxStamina
        staminaBar.progress = stamina / maxStamina
      
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        TechDraUtil.playBGM(fileName: "lobby")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        TechDraUtil.stopBGM()
    }
    
    @objc func cureStamina() {
        if stamina < maxStamina {
            stamina = min(stamina + 1, maxStamina)
            staminaBar.progress = stamina / maxStamina
            staminaTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.cureStamina), userInfo: nil, repeats: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 /*   @IBAction func startBattle() {
        performSegue(withIdentifier: "startBattle", sender: nil)
    }
 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startBattle" {
            let battleVC = segue.destination as! ButtleViewController
            player.currentHP = player.maxHP
            battleVC.player = player
    }
    }
    
    @IBAction func startButtle() {
        if stamina >= 20 {
            stamina = stamina - 20
            staminaBar.progress = stamina / maxStamina
            performSegue(withIdentifier: "startBattle", sender: nil)
        } else {
            let alert = UIAlertController(title: "スタミナ不足", message: "スタミナが２０以上必要です", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true ,completion: nil)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
