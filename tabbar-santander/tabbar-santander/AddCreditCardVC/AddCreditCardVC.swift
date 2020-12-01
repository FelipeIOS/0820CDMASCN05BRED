//
//  AddCreditCardVC.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 11/11/20.
//

import UIKit

enum DateEnum: Int {
    case month = 0
    case year = 1
}

protocol AddCreditCardVCDelegte: class {
    
    func success(value: CartoesElement?)
}

class AddCreditCardVC: BaseViewController {

    
    
    //MARK:  Properties
    
    var mes: String?
    var ano: String?
    
    
    weak var delegate: AddCreditCardVCDelegte?
   
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberCardTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var flagSegmented: UISegmentedControl!
    
    @IBOutlet weak var photoButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    private var controller: AddCreditCardController = AddCreditCardController()
    
    
    private var dateView: UIPickerView?
    private var months: [String] = Calendar.current.monthSymbols
    private var years: [String] = []
    
    
    //MARK:  ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configDelegates()
        self.configLayoutScreen()
        self.configDateView()
    
        self.loadYears()
    
        self.showLoading()
    
        // Do any additional setup after loading the view.
    }
    
    //MARK: Private func
    

    
    private func loadYears() {
       
        let currentDate = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: currentDate)
        self.years = (currentYear...2100).map { String($0) }
        
    }
    
    private func configDateView() {
        self.dateView = UIPickerView()
        
        self.dateView?.delegate = self
        self.dateView?.dataSource = self
    
        self.dateView?.backgroundColor = UIColor.red
        self.dateView?.setValue(UIColor.white, forKeyPath: "textColor")
        self.dateTextField.inputView = self.dateView
        
        
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


        let monthSelected = self.dateView?.selectedRow(inComponent: 0) ?? 0
        let yearSelected  = self.dateView?.selectedRow(inComponent: 1) ?? 0
        
        
        self.dateTextField.text =  "\(self.months[monthSelected] )/\(self.years[yearSelected])"
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
    
    //MARK: Actions
    
    @IBAction func tappedSelectFlagSegmented(_ sender: UISegmentedControl) {
    }
    
    @IBAction func tappedPhotoButton(_ sender: UIButton) {
     
        self.getImage(fromSourceType: .photoLibrary)
    }

    @IBAction func tappedSaveButton(_ sender: UIButton) {
        
        if self.checkFields(){
           
            let alert = UIAlertController(title: "Sucesso", message: "Deu certo :), cartão add com sucesso", preferredStyle: .alert)
            
            let button = UIAlertAction(title: "OK", style: .default) { (success) in
               
                self.controller.saveCreditCard(name: self.nameTextField.text, date: self.dateTextField.text, number: self.numberCardTextField.text, flag: self.flagSegmented.selectedSegmentIndex)
                
                self.delegate?.success(value: self.controller.creditCardSaved)
               
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
    
   
    
    
}

//MARK: UIImagePickerControllerDelegate UINavigationControllerDelegate

extension AddCreditCardVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let urlImage:NSURL? = info[UIImagePickerController.InfoKey.imageURL] as? NSURL
        
        print("urlImage:\(urlImage)")
        
        print("=========\(info)")
        picker.dismiss(animated: true, completion: nil)
        
    }
}

//MARK: UITextFieldDelegate

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

//MARK: UIPickerViewDelegate UIPickerViewDataSource

extension AddCreditCardVC: UIPickerViewDelegate, UIPickerViewDataSource {
   
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == DateEnum.month.rawValue {
            return self.months.count
         }
     
        return self.years.count
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == DateEnum.month.rawValue {
            return months[row]
            
         } else {
            return  years[row]
         }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        if component == DateEnum.month.rawValue {
            self.mes = self.months[row]
            print(months[row])

         } else {
            self.ano = self.years[row]
            print(years[row])
         }
    }
    
}
