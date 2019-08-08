//
//  ViewController.swift
//  millionare
//
//  Created by Aaron Still on 6/29/19.
//  Copyright © 2019 Aaron Still. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    enum BusinessType {
        case lemonadeStand
        case carWash
        case lawnCare
    }
    
    enum LemonadeStandValue: Int {
        case two = 5
        case three = 10
        case four = 15
        case five = 20
    }
    
    enum CarWashValue: Int {
        case one = 35
        case two = 50
        case three = 75
        case four = 100
        case five = 125
    }
    
    enum lawnCareValue: Int {
        case one = 150
        case two = 175
        case three = 200
        case four = 250
        case five = 300
    }
    
    enum BusinessLevel: Int {
        case one = 1
        case two = 2
        case three = 3
        case four = 4
        case five = 5
    }
    
    @IBOutlet weak var backArrow: UIButton!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var buisnessLevelLabel: UILabel!
    @IBOutlet weak var buisnessButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var upgradeButton: UIButton!
    @IBOutlet weak var addHelper: UIButton!
    @IBOutlet weak var storeButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var perClick: UILabel!
    @IBOutlet weak var perSecond: UILabel!
    
    var storeOpen = false
    var money = 0
    var amountPerSale = 1
    var businessLevelList = BusinessLevel.one
    var lemonadeStandUpgrade = LemonadeStandValue.two
    var carWashUpgrade = CarWashValue.one
    var lawnCareUpgarde = lawnCareValue.one
    var costOfNextUpgrade = 50
    var timer = Timer()
    var numberOfHelpers = 1
    var helperCost = 1
    var helperMultiplier = 1
    var helperLimit = 5
    var typeOfBusiness = BusinessType.lemonadeStand
    
    func openStore() {
        storeOpen = true
        buisnessButton.alpha = 0
        buisnessLevelLabel.alpha = 0
        moneyLabel.alpha = 0
        storeButton.alpha = 0
        
        upgradeButton.alpha = 1
        addHelper.alpha = 1
        backArrow.alpha = 1
        addHelper.setTitle("Buy Helper $\(helperCost)", for: .normal)
        upgradeButton.setTitle("Upgrade $\(costOfNextUpgrade)", for: .normal)
    }
    
    func closeStore() {
        storeOpen = false
        buisnessButton.alpha = 1
        buisnessLevelLabel.alpha = 1
        moneyLabel.alpha = 1
        storeButton.alpha = 1
        
        upgradeButton.alpha = 0
        addHelper.alpha = 0
        backArrow.alpha = 0
        messageLabel.text = "Just keep taping, taping, taping!"
    }
    
    func makeUiAppear() {
        buisnessButton.alpha = 1
        buisnessLevelLabel.alpha = 1
        moneyLabel.alpha = 1
        storeButton.alpha = 1
        perClick.alpha = 1
        perSecond.alpha = 1
        messageLabel.text = "Just keep taping, taping, taping!"
        startButton.alpha = 0
    }
    
    func makeSale() {
        money += amountPerSale
        moneyLabel.text = String("$\(money)")
    }
    
    func updateLabels() {
        buisnessLevelLabel.text = "\(businessLevelList.rawValue)"
        upgradeButton.setTitle("Upgrade $\(costOfNextUpgrade)", for: .normal)
        moneyLabel.text = String("$\(money)")
        perClick.text = "$ Per Click: \(amountPerSale)"
    }
    
    func activateHelpers(on: Bool) {
        
        if on {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (_) in
                
                guard let strongSelf = self else { return }
                strongSelf.money += strongSelf.numberOfHelpers * strongSelf.helperMultiplier
                strongSelf.moneyLabel.text = "$\(strongSelf.money)"
                
            })
        } else {
            timer.invalidate()
        }
    }
    
    func upgradeLemonadeStand() {
        guard money >= costOfNextUpgrade else {
            return
        }
        
        switch lemonadeStandUpgrade {
            
        case LemonadeStandValue.two:
            costOfNextUpgrade = 250
            amountPerSale = LemonadeStandValue.two.rawValue
            businessLevelList = BusinessLevel.two
            lemonadeStandUpgrade = LemonadeStandValue.three
        case LemonadeStandValue.three:
            costOfNextUpgrade = 500
            amountPerSale = LemonadeStandValue.three.rawValue
            businessLevelList = BusinessLevel.three
            lemonadeStandUpgrade = LemonadeStandValue.four
        case LemonadeStandValue.four:
            costOfNextUpgrade = 1000
            amountPerSale = LemonadeStandValue.four.rawValue
            businessLevelList = BusinessLevel.four
            lemonadeStandUpgrade = LemonadeStandValue.five
            
        case LemonadeStandValue.five:
            costOfNextUpgrade = 10000
            amountPerSale = LemonadeStandValue.five.rawValue
            businessLevelList = BusinessLevel.five
            lemonadeStandUpgrade = LemonadeStandValue.five
            typeOfBusiness = .carWash
        }
    }
    
    func upgradeCarWash() {
        guard money >= costOfNextUpgrade else {
            return
        }
        
        switch carWashUpgrade {
        case CarWashValue.one:
            buisnessButton.setImage(#imageLiteral(resourceName: "car"), for: .normal)
            costOfNextUpgrade = 25000
            amountPerSale = CarWashValue.one.rawValue
            businessLevelList = BusinessLevel.one
            carWashUpgrade = CarWashValue.two
        case CarWashValue.two:
            costOfNextUpgrade = 50000
            amountPerSale = CarWashValue.two.rawValue
            businessLevelList = BusinessLevel.two
            carWashUpgrade = CarWashValue.three
        case CarWashValue.three:
            costOfNextUpgrade = 100000
            amountPerSale = CarWashValue.three.rawValue
            businessLevelList = BusinessLevel.three
            carWashUpgrade = CarWashValue.four
        case CarWashValue.four:
            costOfNextUpgrade = 175000
            amountPerSale = CarWashValue.four.rawValue
            businessLevelList = BusinessLevel.four
            carWashUpgrade = CarWashValue.five
        case CarWashValue.five:
            costOfNextUpgrade = 250000
            amountPerSale = CarWashValue.five.rawValue
            businessLevelList = BusinessLevel.five
            carWashUpgrade = CarWashValue.five
            typeOfBusiness = .lawnCare
        }
    }
    
    func upgradeLawnCare(){
        guard money >= costOfNextUpgrade else {
            return
        }
        
        switch lawnCareUpgarde {
        case lawnCareValue.one:
            buisnessButton.setImage(#imageLiteral(resourceName: "lawn"), for: .normal)
            costOfNextUpgrade = 300000
            amountPerSale = lawnCareValue.one.rawValue
            businessLevelList = BusinessLevel.one
            lawnCareUpgarde = lawnCareValue.two
        case lawnCareValue.two:
            costOfNextUpgrade = 350000
            amountPerSale = lawnCareValue.two.rawValue
            businessLevelList = BusinessLevel.two
            lawnCareUpgarde = lawnCareValue.three
        case lawnCareValue.three:
            costOfNextUpgrade = 400000
            amountPerSale = lawnCareValue.three.rawValue
            businessLevelList = BusinessLevel.three
            lawnCareUpgarde = lawnCareValue.four
        case lawnCareValue.four:
            costOfNextUpgrade = 500000
            amountPerSale = lawnCareValue.four.rawValue
            businessLevelList = BusinessLevel.four
            lawnCareUpgarde = lawnCareValue.five
        case lawnCareValue.five:
            costOfNextUpgrade = 650000
            amountPerSale = lawnCareValue.five.rawValue
            businessLevelList = BusinessLevel.five
            lawnCareUpgarde = lawnCareValue.five
        }
    }
    
    @IBAction func buisnessButton(_ sender: UIButton) {
        makeSale()
    }
    
    @IBAction func storeButton(_ sender: UIButton) {
        openStore()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        closeStore()
    }
    
    @IBAction func upgradeButton(_ sender: UIButton) {
        
        money -= costOfNextUpgrade
        if typeOfBusiness == .lemonadeStand {
            upgradeLemonadeStand()
        } else if typeOfBusiness == .carWash {
            upgradeCarWash()
        } else if typeOfBusiness == .lawnCare {
            upgradeLawnCare()
        }
        updateLabels()
<<<<<<< Updated upstream
        
        
        perClick.text = "$ Per Click: \(amountPerSale)"
    }
    
    // Start button goes here!!!
    
=======
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        activateHelpers(on: true)
        makeUiAppear()
    }
    
    @IBAction func purchaseHelperButton(_ sender: UIButton) {
        if money >= helperCost && numberOfHelpers < helperLimit {
            money -= helperCost
            numberOfHelpers += 1
            helperCost = helperCost * 2
            addHelper.setTitle("Buy Helper $\(helperCost)", for: .normal)
        } else if money < helperCost {
            messageLabel.text = "Not enough money"
        } else {
            messageLabel.text = "Helper limit reached!"
        }
        perSecond.text = "$ Per Second: \(numberOfHelpers * helperMultiplier)"
    }
>>>>>>> Stashed changes
}
