//
//  registerScreenViewController.swift
//  navigator1
//
//  Created by hassan sayed on 8/8/22.
//

import UIKit

class registerScreenViewController: UIViewController {

   
   var isAgree = false

    @IBOutlet weak var btSignUpOut: UIButton!
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var btAgreeWithOut: UIButton!
    @IBOutlet weak var txtPass: UITextField!
    
    @IBOutlet weak var txtPassConfirm: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addpohtoLeft(txtName, UIImage(systemName: "person.fill")!)
        addpohtoLeft(txtEmail, UIImage(systemName: "envelope.fill")!)
        addpohtoLeft(txtPass, UIImage(systemName: "lock.fill")!)
        addpohtoLeft(txtPassConfirm, UIImage(systemName: "lock.fill")!)
        addpohtoRigth(txtPass, UIImage(systemName: "eye.slash")!)
        addRigth(txtPassConfirm, UIImage(systemName: "eye.slash")!)
        btSignUpOut.layer.cornerRadius = (btSignUpOut.frame.height/2)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        txtEmail.text = "eve.holt@reqres.in"
        txtPass.text = "pistol"
        txtPassConfirm.text = "pistol"
    }
    func addpohtoLeft(_ textField: UITextField , _ img: UIImage){
        let leftImagView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width:30, height: textField.frame.height))
        leftImagView.image = img
        textField.leftView = leftImagView
        textField.leftViewMode = .always
        textField.layer.cornerRadius = (textField.frame.height/2)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textField.layer.masksToBounds = true
    }
    func addpohtoRigth(_ textField: UITextField , _ img: UIImage){
       
        let rigthImagView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width:30, height: textField.frame.height))
        rigthImagView.image = img
        textField.rightView = rigthImagView
        textField.rightViewMode = .always
        
        let tapGesturRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGesturRecognizer: )))
        rigthImagView.isUserInteractionEnabled = true
        rigthImagView.addGestureRecognizer(tapGesturRecognizer)
        
    }
    @objc func imageTapped(tapGesturRecognizer:UITapGestureRecognizer){
        let tappedImage = tapGesturRecognizer.view as! UIImageView
        var isIcon = false
        if(tappedImage.image == UIImage(systemName: "eye")){
        
        }else{
        isIcon = !isIcon
        }
        if isIcon{
            tappedImage.image = UIImage(systemName: "eye")
            txtPass.isSecureTextEntry = false
        }
        else{
            tappedImage.image = UIImage(systemName: "eye.slash")
            txtPass.isSecureTextEntry = true
        }
    }
   
    func addRigth(_ textField: UITextField , _ img: UIImage){
       
        let rigthImag = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width:30, height: textField.frame.height))
        rigthImag.image = img
        textField.rightView = rigthImag
        textField.rightViewMode = .always
       
        let tapGestur = UITapGestureRecognizer(target: self, action: #selector(image(tapGestur: )))
        rigthImag.isUserInteractionEnabled = true
        rigthImag.addGestureRecognizer(tapGestur)
        
    }
    @objc func image(tapGestur:UITapGestureRecognizer){
        let tapped = tapGestur.view as! UIImageView
        var isIcon = false
        if(tapped.image == UIImage(systemName: "eye")){
        
        }else{
        isIcon = !isIcon
        }
        if isIcon{
            tapped.image = UIImage(systemName: "eye")
            txtPassConfirm.isSecureTextEntry = false
        }
        else{
            tapped.image = UIImage(systemName: "eye.slash")
            txtPassConfirm.isSecureTextEntry = true
        }
    }
    
    
    
    @IBAction func btAgreeWith(_ sender: UIButton) {
        isAgree = !isAgree
        if isAgree {
            btAgreeWithOut.setImage( UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }
        if !isAgree {
            btAgreeWithOut.setImage( UIImage(systemName: "square"), for: .normal)
        }
        
    }
    
    func showAlert(msg: String) {
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func addUser(_ sender: UIButton) {
        guard let name = txtName.text, name != "" else {
            showAlert(msg: "Please enter your name")
            return
        }
        guard let email = txtEmail.text, email != "" else {
            showAlert(msg: "Please enter your email")
            return
        }
        guard let pass = txtPass.text, pass != "" else {
            showAlert(msg: "Please enter your password")
            return
        }
        guard let confirmPass = txtPassConfirm.text, confirmPass != "" else {
            showAlert(msg: "Please enter confirm password")
            return
        }
        guard pass == confirmPass else {
            showAlert(msg: "Password and confirm password isn't identical")
            return
        }
        
        NetworkManager.authoticateUser(email: email, pass: pass, url: "https://reqres.in/api/register") { response in
//            self.navigationController?.popViewController(animated: true)
            let alert = UIAlertController(title: "Done", message: "Successful Registration", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
           
        } onFailure: { error in
            self.showAlert(msg: error)
        }
        
    }
    @IBAction func btSignInback(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
   

}
