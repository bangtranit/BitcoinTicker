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
import SVProgressHUD

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var pricesLabel: UILabel!
    @IBOutlet weak var chooseBitcoinPickerView: UIPickerView!
    
    let baseURL : String = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let moneyArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var indexOfPickerView : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseBitcoinPickerView.dataSource = self
        chooseBitcoinPickerView.delegate = self
        getDataFromServices()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getDataFromServices(){
        SVProgressHUD .show()
        let currency : String = currencyArray[indexOfPickerView]
        let url : String = "\(baseURL)\(currency)"

        Alamofire.request(url, method: .get).validate().responseJSON { response in
            if response.result.isSuccess{
                let json : JSON = JSON(response.result.value!)
                print(json)
                self.updateCurrencyData(json: json)
            }else{
                print("erro \(response.result.error!)")
            }
            SVProgressHUD .dismiss()
        }
    }
    
    func updateCurrencyData(json : JSON){
        if let bitcoinResult = json["ask"].double{
            pricesLabel.text = "\(moneyArray[indexOfPickerView]) : \(bitcoinResult)"
        }else{
            pricesLabel.text = "Price Unavailable"
        }
    }
    
    // MARK Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        indexOfPickerView = row
        getDataFromServices()
    }
}

