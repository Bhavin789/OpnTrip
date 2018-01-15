//
//  UploadViewController.swift
//  Oinnfi
//
//  Created by Bhavin on 12/12/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit
import MediaPlayer

class UploadViewController: UIViewController {

    @IBOutlet weak var languageField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lengthField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var maturityField: UITextField!
    @IBOutlet weak var pathLabel: UILabel!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var chooseFileButton: UIButton!
    
    var bannerTitle = [String]()
    var bannerID = [String]()
    var bannerImage = [String]()
    var bannerDetails = NSArray()
    let categoryPicker = UIPickerView()
    var song: MPMediaItem?
    var catId = ""
    var languageId = ""
    var lengthId = ""
    var contentId = ""
    var artworkImage: UIImage?
    var artWorkData: Data?
    var trackName = ""
    var albumName = ""
    var dataDictionary = [String: Any]()
    var lengthArray = [[String: String]]()
    var languageArray = [[String: String]]()
    var contentArray = [[String: String]]()
    
    let categories = ["high", "low"]
    let language = ["Hindi", "English","Gujrati", "German", "French", "Russian", "Others"]
    let maturity = ["All Audience Age < 13", "Mature Age - 18+", "Teen Audience Age - 13 to 18"]
    let lenght = ["Long", "Short", "Medium"]
    
    var currentTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        let lengthDic1 = ["name": "Long", "id": "63"]
        let lengthDic2 = ["name": "Short", "id": "61"]
        let lengthDic3 = ["name": "Medium", "id": "62"]
        lengthArray = [lengthDic1, lengthDic2, lengthDic3]
        
        let languageDic1 = ["name": "Hindi", "id": "56"]
        let languageDic2 = ["name": "English", "id": "55"]
        let languageDic3 = ["name": "Gujrati", "id": "140"]
        let languageDic4 = ["name": "French", "id": "65"]
        let languageDic5 = ["name": "German", "id": "64"]
        let languageDic6 = ["name": "Russian", "id": "66"]
        let languageDic7 = ["name": "Others", "id": "57"]
        languageArray = [languageDic1, languageDic2, languageDic3, languageDic4, languageDic5, languageDic6, languageDic7]
        
        let contentDic1 = ["name": "All Audience Age < 13", "id": "58"]
        let contentDic2 = ["name": "Mature Age - 18+", "id": "60"]
        let contentDic3 = ["name": "Teen Audience Age - 13 to 18", "id": "59"]
        contentArray = [contentDic1, contentDic2, contentDic3]

        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "Arial", size: 18.0)!]
        self.navigationItem.title = "Upload"
        self.setNeedsStatusBarAppearanceUpdate()
        
        uploadButton.addTarget(self, action: #selector(uploadToServer), for: .touchUpInside)
        languageField.delegate = self
        nameTextField.delegate = self
        lengthField.delegate = self
        categoryField.delegate = self
        maturityField.delegate = self
        
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor(red: 193/255, green: 193/255, blue: 193/255, alpha: 1).cgColor
        createCategoryPicker()
        createToolbar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData(){
        print("HI There")
        
        print("hi")
        let request = NSMutableURLRequest(url: NSURL(string: "http://www.opntrip.com/restfulapi/request.php?authkey=VR9RP1K2VU1YZ6FQNDDGJGWQWVX3IW1X&service=\("menu")")! as URL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request.url!) { (data, response, error) -> Void in
            
            if let data = data {
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let res = jsonResult["items"] as? NSArray{
                            self.bannerDetails = res
                            for banner in res{
                                if let banner = banner as? [String: Any]{
                                    
                                    if let bannerName = banner["text"] as? String, let bannerImageUrl = banner["image"] as? String, let bannerId = banner["id"] as? String{
                                        print(bannerName)
                                        self.add(bannerName)
                                        print(bannerName)
                                        self.bannerImage.append(bannerImageUrl)
                                        self.bannerID.append(bannerId)
                                    }
                                }
                            }
                            
                        }
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
        print("Task completed")
    }
    
    func add(_ str: String){
        print("printing")
        bannerTitle.append(str)
        print("The count is ")
        print(bannerTitle.count)
    }
    
    
    func createCategoryPicker(){
       // let categoryPicker = UIPickerView()
        categoryPicker.delegate = self
        
        categoryField.inputView = categoryPicker
        languageField.inputView = categoryPicker
        maturityField.inputView = categoryPicker
        lengthField.inputView = categoryPicker
    }
    
    func createToolbar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        toolbar.setItems([cancelButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.tintColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        
        categoryField.inputAccessoryView = toolbar
        languageField.inputAccessoryView = toolbar
        maturityField.inputAccessoryView = toolbar
        lengthField.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard(){
        print("called")
        view.endEditing(true)
       // print(currentTextField)
        currentTextField.resignFirstResponder()
    }
    
    @objc func handleCancel(){
        view.endEditing(true)
        currentTextField.text = ""
        categoryPicker.removeFromSuperview()
        
       // categoryPicker.delegate = nil
        
    }
    
    @IBAction func pickAudioForIndex_iPhone() {
        if (UIDevice.current.model == "iPhone Simulator") {
            //showAlertMessage("There is no Audio file in the Device")
            let mediaPicker = MPMediaPickerController(mediaTypes: .any)
            mediaPicker.delegate = self
            mediaPicker.allowsPickingMultipleItems = false
            // this is the default
            present(mediaPicker, animated: true) {() -> Void in }
        }
        else {
            let mediaPicker = MPMediaPickerController(mediaTypes: .any)
            mediaPicker.delegate = self
            mediaPicker.allowsPickingMultipleItems = false
            // this is the default
            present(mediaPicker, animated: true) {() -> Void in }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("begin")
        currentTextField = textField
        clearView()
    }
    
    @objc func uploadToServer(){
        if nameTextField.text?.count == 0 {
            showAlertMessage("Please fill story name")
            return
        }
        if descriptionTextView.text?.count == 0 {
            showAlertMessage("please fill description for story")
            return
        }
        if categoryField.text?.count == 0 {
            showAlertMessage("Please select a category for story")
            return
        }
        if languageField.text?.count == 0 {
            showAlertMessage("Please select language for story")
            return
        }
        if maturityField.text?.count == 0 {
            showAlertMessage("Please select Content Maturity for story")
            return
        }
        if lengthField.text?.count == 0 {
            showAlertMessage("Please select story length")
            return
        }
        if pathLabel.text?.count == 0 {
            showAlertMessage("Please select a story form your device")
            return
        }
        
        guard let str = UserDefaults.standard.value(forKey: "UserID") else{
            UserDefaults.standard.set("1234", forKey: "UserID")
            return
        }
        
        
        var dataDictionary = ["category": catId, "pname": nameTextField.text, "long_desc": descriptionTextView.text, "custid": str, "token": "VR9RP1K2VU1YZ6FQNDDGJGWQWVX3IW1X", "feature_10_value": languageId, "feature_11_value": contentId, "feature_12_value": lengthId, "respformat": "json"]
        
    }
    
    func urlForNewImage() -> String {
        return "\(documentPath())/\(uuid()).jpg"
    }
    
    func urlForNewMp3() -> String {
        return "\(documentPath())/\(uuid()).mp3"
    }
    
    func documentPath() -> String {
        let strPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return strPath
    }
    
    func uuid() -> String {
        let uuidRef: CFUUID = CFUUIDCreate(nil)
        let uuidStringRef: CFString = CFUUIDCreateString(nil, uuidRef)
        return (uuidStringRef as? String) ?? ""
    }
    
    func showAlertMessage(_ string:String){
        let alert = UIAlertController(title: "OpenTrip", message: string, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UploadViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, MPMediaPickerControllerDelegate{
    
    func btnMediaPickerAction(_ sender: UIButton) {
        let mediaPicker: MPMediaPickerController = MPMediaPickerController.self(mediaTypes:MPMediaType.music)
        mediaPicker.delegate = self
        mediaPicker.allowsPickingMultipleItems = false
        self.present(mediaPicker, animated: true, completion: nil)
    }
    
    // MPMediaPickerController Delegate methods
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        
        let albumDictionary  = NSMutableDictionary()
        var item: MPMediaItem? = mediaItemCollection.items[0]
        if let name = item?.title{
            trackName = name
            albumDictionary["trackName"] = trackName
        }
        
        if let name = item?.albumTitle{
            albumName = name
            albumDictionary["albumName"] = albumName
        }
        
        var artwork = item?.value(forProperty: MPMediaItemPropertyArtwork) as? MPMediaItemArtwork
        if((artwork) != nil){
            artworkImage = artwork?.image(at: CGSize(width: 30, height: 30))
        }
        
        if let image = artworkImage{
           artWorkData = UIImagePNGRepresentation(image)
        }
        
        var assetURL = item?.value(forProperty: MPMediaItemPropertyAssetURL) as? URL
        var songData = Data()
        
        var opts = [AnyHashable: Any]()
        if let url = assetURL{
            var asset = AVURLAsset(url: url, options: opts as! [String : Any])
            var reader = try? AVAssetReader(asset: asset)
           /* var output = AVAssetReaderTrackOutput(track: asset.tracks[0], outputSettings: nil)
            reader?.add(output)
            reader?.startReading()
            
            while reader?.status != .completed {
                var buffer: CMSampleBuffer? = output.copyNextSampleBuffer()
                if buffer == nil {
                    continue
                }
                var blockBuffer: CMBlockBuffer = CMSampleBufferGetDataBuffer(buffer!)!
                var size: size_t = CMBlockBufferGetDataLength(blockBuffer)
                var outBytes = malloc(size)
                CMBlockBufferCopyDataBytes(blockBuffer, 0, size, outBytes!)
                CMSampleBufferInvalidate(buffer!)
                songData.append(outBytes ?? UnsafeRawPointer, count: Int(size))
                free(outBytes)
            }*/
        }
        
        mediaPicker.dismiss(animated: true) {
            DispatchQueue.main.async {
                print("you picked: \(mediaItemCollection)")
                self.pathLabel.text = self.trackName
            }
        }
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (categoryField.isFirstResponder){
            return bannerTitle.count
        }else if(languageField.isFirstResponder){
            return languageArray.count
        }else if (maturityField.isFirstResponder){
            return contentArray.count
        }else{
            return lengthArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (categoryField.isFirstResponder){
            return bannerTitle[row]
        }else if(languageField.isFirstResponder){
            return languageArray[row]["name"]
        }else if (maturityField.isFirstResponder){
            return contentArray[row]["name"]
        }else{
            return lengthArray[row]["name"]
        }        //return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (categoryField.isFirstResponder){
            categoryField.text = bannerTitle[row]
        }else if(languageField.isFirstResponder){
            languageField.text = languageArray[row]["name"]
        }else if (maturityField.isFirstResponder){
            maturityField.text = contentArray[row]["name"]
        }else{
            lengthField.text = lengthArray[row]["name"]
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("resigned")
        return true
        
    }
    
    func clearView(){
        if (categoryField.isFirstResponder){
            categoryField.text = ""
        }else if(languageField.isFirstResponder){
            languageField.text = ""
        }else if (maturityField.isFirstResponder){
            maturityField.text = ""
        }else{
            lengthField.text = ""
        }
    }
}
