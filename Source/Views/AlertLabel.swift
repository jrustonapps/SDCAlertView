import UIKit
import SafariServices

@objc(SDCAlertLabel)
final class AlertLabel: ActiveLabel {
    
    public var privacyPolicy : String?
    
    init() {
        super.init(frame: .zero)
        self.textAlignment = .center
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let customType = ActiveType.custom(pattern: "\\sPrivacy Policy\\b")
        self.enabledTypes = [.url, customType]
        self.customColor[customType] = UIColor.blue
        self.configureLinkAttribute = { (type, attributes, isSelected) in
            var atts = attributes
            atts[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue
            return atts
        }
        
        self.handleURLTap { (url) in
            UIApplication.shared.openURL(url)
        }
        
        self.handleCustomTap(for: customType) { (string) in
            
            if let privacyPolicy = self.privacyPolicy {
                UIApplication.shared.openURL(URL.init(string: privacyPolicy)!)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        self.preferredMaxLayoutWidth = self.bounds.width
        super.layoutSubviews()
    }
}
