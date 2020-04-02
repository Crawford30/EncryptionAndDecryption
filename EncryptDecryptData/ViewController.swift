//
//  ViewController.swift
//  EncryptDecryptData
//
//  Created by JOEL CRAWFORD on 4/2/20.
//  Copyright © 2020 JOEL CRAWFORD. All rights reserved.
//

import UIKit
import RNCryptor //for encryption and decryption

let defaults = UserDefaults.standard

let encryptionKey = "53N2@C7@pX2"
let loginpassword = "12345678"
let loginemail = "test@gmail.com"

class ViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    //MARK:- ENCRYPT FUNC
    func encrypt(plainText: String, password: String) -> String {
        
        //getting the data from the plain text
        let data:Data = plainText.data(using: .utf8)!
        
        let encryptedData = try RNCryptor.encrypt(data: data, withPassword: encryptionKey)
        
        //making encrypted value as a string
        
        let encryptedString: String = encryptedData.base64EncodedString()  //gettting base64  string of the encrpted data
        
        return encryptedString
    }
    
    
    
    //MARK:- DECRYPT FUNC
    
    func decrypt(encryptedText: String, password: String) -> String {
        do {
            let data:Data = Data(base64Encoded: encryptedText)! //getting base64 string of encrpted data
            
            let decryptedData = try RNCryptor.decrypt(data: data, withPassword: password) //getting data from encrpted base64 encoded string
            
            
            let decryptedString = String(data: decryptedData, encoding: .utf8) //getting original data(string)
            
            return decryptedString ?? ""
            
        } catch {
            
            return "Failed"
            
        }
    }
    
    
    
    //LOGIN
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        
        let encryptedEmail = self.encrypt(plainText:loginemail , password: encryptionKey)
        
        print(encryptedEmail)
        
        
        
        let encryptedPasword = self.encrypt(plainText:loginpassword , password: encryptionKey)
        
        print(encryptedPasword)
        
        
        
        //we save the encypted text to defaults
        defaults.set(encryptedEmail, forKey: "email")
        defaults.set(encryptedPasword, forKey: "password")
        
    }
    
    
    @IBAction func showDecryptedDataBtn(_ sender: UIButton) {
        
        
        let emailOutput = defaults.object(forKey:"email") as! String
        
        print(emailOutput)
        
        let passwordOutput = defaults.object(forKey:"password") as! String
        print(passwordOutput)
        
        
        
        //====Decrypting
        
        let decryptedEmail = self.decrypt(encryptedText: emailOutput, password: encryptionKey)
        print(decryptedEmail)
        
        
        
        let decryptedPassword = self.decrypt(encryptedText: passwordOutput, password: encryptionKey)
        
        print(decryptedPassword)
        
    }
    
    
    
    
}

