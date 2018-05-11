//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Tran Thanh Bang on 2018/05/12.
//  Copyright © 2018年 Tran Thanh Bang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    

    @IBOutlet weak var pricesLabel: UILabel!
    @IBOutlet weak var chooseBitcoinPickerView: UIPickerView!
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let moneyArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var finalURL = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromServices(url: baseURL, method: .get, parameter: <#T##[String : String]#>)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getDataFromServices(url : String, method: HTTPMethod, parameter: [String : String]){
        Alamofire.request(url, method: method, parameters : parameter).validate().responseJSON { response in
            if response.result.isSuccess{
                let json : JSON = JSON(response.result)
                print(json)
            }else{
                print("erro \(response.result.error!)")
            }
        }
    }
    
    // MARK Picker View
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//
//    }
}

