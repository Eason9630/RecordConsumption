//
//  AddViewController.swift
//  RecordConsumption
//
//  Created by 林祔利 on 2023/5/9.
//

import UIKit

class AddViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var item: List?
    var selectPhoto = false
    @IBOutlet weak var PhotoImage: UIButton!
    @IBOutlet weak var ItemDate: UIDatePicker!
    @IBOutlet weak var ItemPrice: UITextField!
    @IBOutlet weak var ItemName: UITextField!

    @IBOutlet weak var havePay: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        PhotoImage.imageView?.contentMode = .scaleAspectFill
        if let item = item {
            ItemName.text = item.name
            ItemPrice.text = "\(item.price)"
            ItemDate.date = item.date
            havePay.isOn = item.check
            if let imageName = item.image {
                let imageURL = List.documentsDirectory.appendingPathComponent(imageName).appendingPathExtension("jpg")
                let image = UIImage(contentsOfFile: imageURL.path)
                PhotoImage.setImage(image, for: .normal)
            }
        }
        
    }
    
    @IBAction func selectPhoto(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = self
        present(controller, animated: true)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectImage = info[.originalImage] as? UIImage else{ return }
        selectPhoto = true
        PhotoImage.setImage(selectImage, for: .normal)
        
        dismiss(animated: true)
    }
    
    
    @IBAction func selectDate(_ sender: UIDatePicker) {
        let date = ItemDate.date
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let name = ItemName.text ?? ""
        let price = Double(ItemPrice.text!) ?? 0
        let date = ItemDate.date
        let havePay = havePay.isOn
        var imageName: String?
        
        if selectPhoto {
            if let item = item {
                imageName = item.image
            }
            if imageName == nil {
                imageName = UUID().uuidString
            }
            let imageData = PhotoImage.image(for: .normal)?.jpegData(compressionQuality: 0.9)
            let imageURL = List.documentsDirectory.appendingPathComponent(imageName!).appendingPathExtension("jpg")
            try? imageData?.write(to: imageURL)
            
        }else {
            imageName = item?.image
        }
        item = List(name: name, price: price, date: date, image: imageName, check: havePay)
        
    }


}
