//
//  loginScreenViewController.swift
//  navigator1
//
//  Created by hassan sayed on 8/8/22.
//

import UIKit

class loginScreenViewController: UIViewController,UIViewControllerTransitioningDelegate {
   
    var isRemember = false
    var isIcon = false
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var btSignInOut: UIButton!
    @IBOutlet weak var btRememberMe: UIButton!
    @IBOutlet weak var txtPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       addpohto(txtName, UIImage(systemName: "person.fill")!)
        addpohto(txtPass, UIImage(systemName: "lock.fill")!)
        txtName.layer.cornerRadius = (txtName.frame.height/2)
        txtName.layer.borderWidth = 1
        txtName.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        txtName.layer.masksToBounds = true
        txtPass.layer.cornerRadius = (txtPass.frame.height/2)
        txtPass.layer.borderWidth = 1
        txtPass.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        txtPass.layer.masksToBounds = true
        txtPass.isSecureTextEntry = true
        btSignInOut.layer.cornerRadius = (btSignInOut.frame.height/2)
        
        let rigthImagView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width:30, height: txtPass.frame.height))
        rigthImagView.image = UIImage(systemName: "eye.slash")
        txtPass.rightView = rigthImagView
        txtPass.rightViewMode = .always
        let tapGesturRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGesturRecognizer:)))
        rigthImagView.isUserInteractionEnabled = true
        rigthImagView.addGestureRecognizer(tapGesturRecognizer)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.title = "Login"
        txtName.text = "eve.holt@reqres.in"
        txtPass.text = "pistol"
    }
    func showAlert(msg: String) {
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @objc func imageTapped(tapGesturRecognizer:UITapGestureRecognizer){
        let tappedImage = tapGesturRecognizer.view as! UIImageView
        isIcon = !isIcon
        if isIcon{
            tappedImage.image = UIImage(systemName: "eye")
            txtPass.isSecureTextEntry = false
        }
        else{
            tappedImage.image = UIImage(systemName: "eye.slash")
            txtPass.isSecureTextEntry = true
        }
    }
    func addpohto(_ textField: UITextField , _ img: UIImage){
        let leftImagView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width:30, height: textField.frame.height))
        leftImagView.image = img
        textField.leftView = leftImagView
        textField.leftViewMode = .always
    }

    @IBAction func btRemember(_ sender: UIButton) {
        isRemember = !isRemember
        if isRemember {
            btRememberMe.setImage( UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }
        if !isRemember {
            btRememberMe.setImage( UIImage(systemName: "square"), for: .normal)
        }
      /*  do {
        items = try
        context.fetch(User.fetchRequest())  } catch { }
        
        context.delete(items[0])
        do {
        try context.save() } catch {
        }*/

    }
    @IBAction func BTSignIn(_ sender: UIButton) {
        guard let email = txtName.text, email != "" else {
            showAlert(msg: "Please enter your email")
            return
        }
        guard let pass = txtPass.text, pass != "" else {
            showAlert(msg: "Please enter your password")
            return
        }
        NetworkManager.authoticateUser(email: email, pass: pass, url: "https://reqres.in/api/login") { response in
            
           
            
        } onFailure: { error in
            self.showAlert(msg: error)
        }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "homePageViewController") as! homePageViewController
        self.present(vc, animated: true, completion: nil)
    
    }
    
    @IBAction func btSignUp(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "registerScreenViewController") as! registerScreenViewController
        self.present(vc, animated: true, completion: nil)
    }
    
}
