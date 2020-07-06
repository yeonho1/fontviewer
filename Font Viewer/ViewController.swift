//
//  ViewController.swift
//  Font Viewer
//
//  Created by 이연호 on 2020/07/06.
//  Copyright © 2020 Yeonho Lee. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var fontFamiliesPopup: NSPopUpButton!
    @IBOutlet weak var fontTypesPopup: NSPopUpButton!
    @IBOutlet weak var sampleLabel: NSTextField!
    var selectedFontFamily: String?
    var fontFamilyMembers = [[Any]]()
    
    func setupUI() {
        fontFamiliesPopup.removeAllItems()
        fontTypesPopup.removeAllItems()
        sampleLabel.stringValue = ""
        sampleLabel.alignment = .center
    }
    
    func populateFontFamilies() {
        fontFamiliesPopup.removeAllItems()
        fontFamiliesPopup.addItems(withTitles: NSFontManager.shared.availableFontFamilies)
        handleFontFamilySelection(self)
    }
    
    func updateFontTypesPopup() {
        fontTypesPopup.removeAllItems()
        
        for member in fontFamilyMembers {
            if let fontType = member[1] as? String {
                fontTypesPopup.addItem(withTitle: fontType)
            }
        }
        fontTypesPopup.selectItem(at: 0)
        handleFontTypeSelection(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        setupUI()
        populateFontFamilies()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func handleFontFamilySelection(_ sender: Any) {
        if let fontFamily = fontFamiliesPopup.titleOfSelectedItem {
            selectedFontFamily = fontFamily
            if let members = NSFontManager.shared.availableMembers(ofFontFamily: fontFamily) {
                fontFamilyMembers.removeAll()
                fontFamilyMembers = members
                updateFontTypesPopup()
            }
            view.window?.title = "Font Viewer - " + fontFamily
        }
    }
    
    @IBAction func handleFontTypeSelection(_ sender: Any) {
        let selectedMember = fontFamilyMembers[fontTypesPopup.indexOfSelectedItem]
        if let postscriptName = selectedMember[0] as? String, let weight = selectedMember[2] as? Int, let traits = selectedMember[3] as? UInt, let fontFamily = selectedFontFamily {
            let font = NSFontManager.shared.font(
                withFamily: fontFamily,
                traits: NSFontTraitMask(rawValue: traits),
                weight: weight,
                size: 19.0
            )
            sampleLabel.font = font
            sampleLabel.stringValue = postscriptName
        }
    }
    
    @IBAction func displayAllFonts(_ sender: Any) {
        
    }


}

