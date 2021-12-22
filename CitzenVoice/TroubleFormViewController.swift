//
//  TroubleFormViewController.swift
//  CitzenVoice
//
//  Created by Splhead on 20/12/21.
//

import UIKit

class TroubleFormViewController: UIViewController {

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textViewDetails: UITextView!
    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var buttonAction: UIButton!
    
    var trouble: Trouble?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let trouble = trouble {
            title = "Edição"
            textFieldName.text = trouble.name
            textFieldAddress.text = trouble.address
            textViewDetails.text = trouble.details
            
            if let image = trouble.image {
                imageViewPhoto.image = UIImage(data: image)
            }
            
            buttonAction.setTitle("Alterar", for: .normal)
        }
    }
    
    @IBAction func selectPhotoFrom(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecionar foto", message: "De onde você deseja escolher a foto", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera", style: .default) { _ in
                self.selectPicture(sourceType: .camera)
            }
            alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Biblioteca de Fotos", style: .default) { _ in
            self.selectPicture(sourceType: .photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let albumAction = UIAlertAction(title: "Álbum de fotos", style: .default) { _ in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(albumAction)
        
        let cancellationAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancellationAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func selectPicture(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        if trouble == nil {
            trouble = Trouble(context: context)
            trouble?.createdAt = Date()
        }
        
        trouble?.name = textFieldName.text
        trouble?.address = textFieldAddress.text
        trouble?.details = textViewDetails.text
        trouble?.image = imageViewPhoto.image?.jpegData(compressionQuality: 0.9)
        
        
        try? context.save()
        
        navigationController?.popViewController(animated: true)
    }
    

}

extension TroubleFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            imageViewPhoto.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}
