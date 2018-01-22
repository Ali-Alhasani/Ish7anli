// Moath Othman
// MIT license

import Foundation
import UIKit
let viewkey = UnsafePointer<Any>(bitPattern: 64)

protocol LayoutSwizzlable: NSObjectProtocol {
    func handleSwitching()
}

protocol Taggable: NSObjectProtocol {
    var tag: Int {get set}
}

protocol TextAlignmented: NSObjectProtocol {
    var textAlignment: NSTextAlignment {get set}
}

extension LayoutSwizzlable where Self: TextAlignmented & Taggable {
    func handleSwitching() {
        if self.isKind(of: NSClassFromString("UITextFieldLabel")!) {
            return // handle special case with uitextfields
        }
        if self.tag < MOLH.shared.maximumLocalizableTag + 1 {
            if UIApplication.isRTL()  {
                if self.textAlignment == .right { return }
                self.textAlignment = .right
            } else {
                if self.textAlignment == .left { return }
                self.textAlignment = .left
            }
        }
    }
}
/// the type of text view , field , label
typealias TextViewType = Taggable & LayoutSwizzlable & TextAlignmented
/// Localize function
public protocol MOLHLocalizable {
    func localize()
}
/// reset bundles
public protocol MOLHResetable {
    func reset()
}

public extension UIApplication {
    public class func isRTL() -> Bool {
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }
}

open class MOLHViewController : UIViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        if self is MOLHLocalizable {
            (self as! MOLHLocalizable).localize()
        }
    }
}

open class MOLHTableViewController : UITableViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        if self is MOLHLocalizable {
            (self as! MOLHLocalizable).localize()
        }
    }
}

open class MOLHView : UIView {
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if self is MOLHLocalizable {
            (self as! MOLHLocalizable).localize()
        }
        
        if self is MOLHFontable {
            (self as! MOLHFontable).updateFont()
        }
        
    }
}

open class MOLH {
    fileprivate struct Shared  {
        static let shared = MOLH()
    }
    
    /// which bundle to fallback to if the current language has no bundle
    open var fallbackLocale = "Base"
    
    /// Prevent MOLH()
    fileprivate init() {}
   
    /// shared Instance , MOLH should be accessed through this shared
    public static let shared = Shared.shared
   
    /**
     @description
     * set the maximum tag where a UIView subclass Deemed Localizable
     * if view Tag property is bigger than this number  the view will not be flipped
     */
    open var maximumLocalizableTag: Int = -1 {
        didSet {
            assert(maximumLocalizableTag <= -1, "Tag should be less than or equal -1 , since 0 will corrupt UIKit-Made UIs e.g. UIAlertView/Share...")
        }
    }
    /**
     @description
     * set special keywords "Keys"  that handled by external frameworks to be localized locally
     */
    public var specialKeyWords: [String] = []
    /**
     Activate Localization Helper
     
     **@param** swizzleExtensions Bool if you want to use run time swizzle with all Views like uilabel, default is false...
     
     **@note** swizzling extension could lead to issues if you are swizzling your UIViews **layoutSubviews** method from another place
     */
    open func activate(_ swizzleExtensions: Bool = false) {
        //invitable swizzlings first for the localzation itself (bundle switch) and the other for the direction (not needed if you support ios 9 and up)
        swizzle(class: Bundle.self, sel: #selector(Bundle.localizedString(forKey:value:table:)), override: #selector(Bundle.specialLocalizedStringForKey(_:value:table:)))
        swizzle(class:UIApplication.self, sel: #selector(getter: UIApplication.userInterfaceLayoutDirection), override: #selector(getter: UIApplication.cstm_userInterfaceLayoutDirection))
        
        if swizzleExtensions {
            swizzle(class:UIViewController.self, sel: #selector(UIViewController.viewDidLayoutSubviews), override: #selector(UIViewController.mirroringviewDidLoad))
            swizzle(class:UIControl.self, sel: #selector(UIControl.awakeFromNib), override: #selector(UIControl.cstmlayoutSubviews))
            swizzle(class:UITextField.self, sel: #selector(UITextField.layoutSubviews), override: #selector(UITextField.cstmlayoutSubviews))
            swizzle(class:UITextView.self, sel: #selector(UITextView.layoutSubviews), override: #selector(UITextView.cstmlayoutSubviews))
            swizzle(class:UILabel.self, sel: #selector(UILabel.layoutSubviews), override: #selector(UILabel.cstmlayoutSubviews))
        }
    }
    
    /// Set Language , Language parameter string identify the language e.x. en, ar,fr ...
    open class func setLanguageTo(_ language: String) {
        MOLHLanguage.setAppleLAnguageTo(language)
        if MOLHLanguage.isRTLLanguage() {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
   
    /**
     reset app which will perform transition and call reset on appdelegate if it's MOLHResetable
     */
    open class func reset() {
        var transition = UIViewAnimationOptions.transitionFlipFromRight
        if !MOLHLanguage.isRTLLanguage() {
            transition = .transitionFlipFromLeft
        }
        if let delegate = UIApplication.shared.delegate {
            if delegate is MOLHResetable {
                (delegate as!MOLHResetable).reset()
            }
            UIView.transition(with: ((delegate.window)!)!, duration: 0.5, options: transition, animations: {}) { (f) in
            }
        }
    }
}

extension UIApplication {
    @objc var cstm_userInterfaceLayoutDirection : UIUserInterfaceLayoutDirection {
        get {
            var direction = UIUserInterfaceLayoutDirection.leftToRight
            if MOLHLanguage.isRTLLanguage() {
                direction = .rightToLeft
            }
            return direction
        }
    }
}

extension Bundle {
    @objc func specialLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
        // check if its the main bundle then if the bundle of the current language is available
        // then try without locale
        // if not go back to base
        
        let translate =  { (tableName: String?) -> String in
            let currentLanguage = MOLHLanguage.currentLocaleIdentifier() // with locale
            let languageWithoutLocale = MOLHLanguage.currentAppleLanguage() // without locale
            var bundle = Bundle();
            // normal case where the lang with locale working
            if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
                bundle = Bundle(path: _path)!
            } // en case when its working wihout locale
            else if let _path = Bundle.main.path(forResource: languageWithoutLocale, ofType: "lproj") {
                bundle = Bundle(path: _path)!
            } // current locale not exist , so we fallback
            else if let _path = Bundle.main.path(forResource: MOLH.shared.fallbackLocale, ofType: "lproj") {
                bundle = Bundle(path: _path)!
            }
            return (bundle.specialLocalizedStringForKey(key, value: value, table: tableName))
        }
        // normal case
        if self == Bundle.main {
            return translate(tableName)
        } // case when the external frameworks has no locale proberty so you have to handle switching yourself
        else if MOLH.shared.specialKeyWords.contains(key) {
            return translate("Localizable")
        } // let the bundle handle the locale
        else {
            return (self.specialLocalizedStringForKey(key, value: value, table: tableName))
        }
    }
}

extension UIImage {
    public func flippedImage() -> UIImage?{
        if let _cgImag = self.cgImage {
            let flippedimg = UIImage(cgImage: _cgImag, scale:self.scale , orientation: UIImageOrientation.upMirrored)
            return flippedimg
        }
        return nil
    }
    
    public func flipIfNeeded() -> UIImage? {
        if MOLHLanguage.isRTL() {
            return self.flippedImage()
        }
        return self
    }
}

extension UIViewController {
    
    @objc func mirroringviewDidLoad() {
        mirroringviewDidLoad()
        if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft {
            loopThroughSubViewAndFlipTheImageIfItsNeeded(self.view.subviews)
        }
        // Do any additional setup after loading the view.
    }
    
    /**
     Loop through subviews recursivley ,finding any image , uibutton image,uislider image that needs to be flipped
     , meaning its tagged less than maximumLocalizableTag and flip it
     
     @param the view subviews to start with.
     
     @note note that we suppose that the original is left to right image by default , an image is only flipped if the
     currentLanguage is right to left
     
     @return nothing
     */
    func loopThroughSubViewAndFlipTheImageIfItsNeeded(_ subviews: [UIView]) {
        
        if subviews.count > 0  && MOLHLanguage.isRTLLanguage() {
            for subView in subviews where subView.tag <= MOLH.shared.maximumLocalizableTag  {
                // Flip UIImageView
                if subView.isKind(of: UIImageView.self)    {
                    let toRightArrow = subView as! UIImageView
                    if let _img = toRightArrow.image {
                        toRightArrow.image = UIImage(cgImage: _img.cgImage!, scale:_img.scale , orientation: UIImageOrientation.upMirrored)
                    }
                }
                // Flip UISlider thumb image
                if subView.isKind(of: UISlider.self) {
                    let toRightArrow = subView as! UISlider
                    if var _img = toRightArrow.thumbImage(for: UIControlState()) {
                        _img = UIImage(cgImage: _img.cgImage!, scale:_img.scale , orientation: UIImageOrientation.upMirrored)
                        toRightArrow.setThumbImage(_img, for: UIControlState())
                        toRightArrow.setThumbImage(_img, for: .selected)
                        toRightArrow.setThumbImage(_img, for: .highlighted)
                    }
                }
                // Flip UIButton image
                if subView.isKind(of: UIButton.self) {
                    let _subView = subView as! UIButton
                    var image = _subView.image(for: UIControlState())
                    image = image?.flippedImage()
                    _subView.setImage(image, for: UIControlState())
                    _subView.setImage(image, for: UIControlState.selected)
                    _subView.setImage(image, for: UIControlState.highlighted)
                }
                
                loopThroughSubViewAndFlipTheImageIfItsNeeded(subView.subviews)
            }
        }
    }
    
}

// MARK : - Extensions
extension UIControl {
    internal func handleSwitching() {
        if self.tag < MOLH.shared.maximumLocalizableTag + 1 {
            if UIApplication.isRTL()  {
                if self.contentHorizontalAlignment == .right { return }
                self.contentHorizontalAlignment = .right
            } else {
                if self.contentHorizontalAlignment == .left { return }
                self.contentHorizontalAlignment = .left
            }
        }
    }
    @objc public  func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
        handleSwitching()
    }
}

extension UITextField: TextViewType {
    public override func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
        handleSwitching()
    }
}

extension UITextView: TextViewType {
    @objc public  func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
        handleSwitching()
    }
}

extension UILabel: TextViewType {
    @objc public  func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
        handleSwitching()
    }
}


// MARK: - SubClasses
/**
 `MOLHControl is a UIControl Subclass`
 
 Any UIControl that wants to be localizable should be subclass of this class
 @auther Moath Othman
 */
open class MOLHControl: UIControl {
    override open func layoutSubviews() {
        super.layoutSubviews()
        handleSwitching()
    }
}
/**
 MOLHLabel is a UILabel Subclass
 Any Label that wants to be localizable should be subclass of this class§
 @auther Moath Othman
 */
open class MOLHLabel: UILabel {
    override open func layoutSubviews() {
        super.layoutSubviews()
        handleSwitching()
    }
}
/**
 MOLHTextView is a UITextView Subclass
 Any TextView that wants to be localizable should be subclass of this class§
 @auther Moath Othman
 */
open class MOLHTextView: UITextView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        handleSwitching()
    }
}
/**
 MOLHTextField is a UITextField Subclass
 Any TextField that wants to be localizable should be subclass of this class§
 @auther Moath Othman
 */
open class MOLHTextField: UITextField {
    override open func layoutSubviews() {
        super.layoutSubviews()
        handleSwitching()
    }
}

// MARK: - Utility
/// Exchange the implementation of two methods for the same Class override will replace sel
private func swizzle(class cls: AnyClass, sel: Selector, override: Selector) {
    let origMethod: Method = class_getInstanceMethod(cls, sel)!;
    let overrideMethod: Method = class_getInstanceMethod(cls, override)!;
    if (class_addMethod(cls, sel, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, override, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}

