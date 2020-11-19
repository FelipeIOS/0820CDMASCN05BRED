//
//  AddCreditCardVC.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 11/11/20.
//

import UIKit


protocol AddCreditCardVCDelegte: class {
    
    func success(value: CartoesElement?)
}

class AddCreditCardVC: UIViewController {

    weak var delegate: AddCreditCardVCDelegte?
   
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberCardTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var flagSegmented: UISegmentedControl!
    
    @IBOutlet weak var photoButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    private var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configDelegates()
        self.configLayoutScreen()
        self.configDatePicker()
    
        // Do any additional setup after loading the view.
    }
    
    private func configDatePicker() {
        self.datePicker = UIDatePicker()
        
        self.datePicker.datePickerMode = .date
        
        if #available(iOS 13.4, *) {
            self.datePicker.preferredDatePickerStyle = .wheels
        }
        
        self.datePicker.backgroundColor = UIColor.red
        self.datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        let localizacao = Locale(identifier: "pt_BR")
        self.datePicker.locale = localizacao
        
        let currentDate = Date()
        self.datePicker.minimumDate = currentDate
        self.datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 5, to: currentDate)
        
        self.dateTextField.inputView = self.datePicker
        
        self.configToolBar()
    }
    
    private func configToolBar() {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.tintColor = UIColor.black
        toolbar.backgroundColor = UIColor.red
        toolbar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelClick))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Pronto", style: .plain, target: self, action: #selector(doneClick))
        
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        self.dateTextField.inputAccessoryView = toolbar
    }
    
    @objc private func cancelClick() {
        self.dateTextField.resignFirstResponder()
    }
    
    @objc private func doneClick() {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        self.dateTextField.text = dateFormatter.string(from: self.datePicker.date)
        self.dateTextField.resignFirstResponder()
    }
    
    private func configDelegates() {
        self.nameTextField.delegate = self
        self.numberCardTextField.delegate = self
        self.dateTextField.delegate = self
    }
    
    private func configLayoutScreen() {
        
        self.saveButton.layer.cornerRadius = 4
        self.photoButton.layer.cornerRadius = 4
        
        self.nameTextField.layer.borderWidth = 0.5
        self.numberCardTextField.layer.borderWidth = 0.5
        self.dateTextField.layer.borderWidth = 0.5
        
        self.nameTextField.layer.borderColor = UIColor.red.cgColor
        self.numberCardTextField.layer.borderColor = UIColor.red.cgColor
        self.dateTextField.layer.borderColor = UIColor.red.cgColor
       
        self.nameTextField.layer.cornerRadius = 4
        self.numberCardTextField.layer.cornerRadius = 4
        self.dateTextField.layer.cornerRadius = 4
    }
    
    @IBAction func tappedSelectFlagSegmented(_ sender: UISegmentedControl) {
    }
    
    @IBAction func tappedPhotoButton(_ sender: UIButton) {
     
        self.getImage(fromSourceType: .photoLibrary)
    }

    @IBAction func tappedSaveButton(_ sender: UIButton) {
        
        if self.checkFields(){
           
            let alert = UIAlertController(title: "Sucesso", message: "Deu certo :), cartão add com sucesso", preferredStyle: .alert)
            
            let button = UIAlertAction(title: "OK", style: .default) { (success) in
               
                self.delegate?.success(value: self.saveCreditCard())
                self.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(button)

            self.present(alert, animated: true, completion: nil)
        }else {
            
            let alert = UIAlertController(title: "Alerta", message: "Vc precisa preeencher todos os campos", preferredStyle: .alert)
            
            let buttonOK = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(buttonOK)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    private func saveCreditCard() -> CartoesElement? {
        
        let card: CartoesElement? = CartoesElement(id: String(Int.random(in: 1...1000)), nome: self.nameTextField.text ?? "", data: self.dateTextField.text ?? "", numero: self.numberCardTextField.text ?? "", bandeira: Flag.loadFlag(index: self.flagSegmented.selectedSegmentIndex).rawValue)
        
        return card
    }
    
     
    
    private func checkFields() -> Bool {
        
        if  self.nameTextField.text?.isEmpty ?? true {
            return false
        }else if self.numberCardTextField.text?.isEmpty ?? true {
            return false
        }else if self.dateTextField.text?.isEmpty ?? true {
            return false
        }else if self.flagSegmented.selectedSegmentIndex == -1 {
            return false
        }
        
        return true
    }
    

    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            
            self.present(imagePickerController, animated: true, completion: nil)
            
        }
        
    }
    
    
}

extension AddCreditCardVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let urlImage:NSURL? = info[UIImagePickerController.InfoKey.imageURL] as? NSURL
        
        print("urlImage:\(urlImage)")
        
        print("=========\(info)")
        picker.dismiss(animated: true, completion: nil)
        
    }
}

extension AddCreditCardVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        switch textField {
        case self.nameTextField:
            self.numberCardTextField.becomeFirstResponder()
        case self.numberCardTextField:
            self.dateTextField.becomeFirstResponder()
        case self.dateTextField:
            self.dateTextField.resignFirstResponder()
        default:break
        }
        
        return true
    }
}
