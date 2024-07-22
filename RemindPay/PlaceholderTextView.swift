import UIKit

final class PlaceholderTextView: UITextView {

    var placeholderText: String? {
        didSet {
            setNeedsDisplay()
        }
    }

    private var placeholderLabel: UILabel?
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        backgroundColor = .white
        guard let placeholderText, placeholderLabel == nil else {
            return
        }
        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = .byTruncatingTail
        textContainer.maximumNumberOfLines = 2
        textContainer.heightTracksTextView = true
        let label = UILabel()
        placeholderLabel = label
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                          NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let size = placeholderText.size(withAttributes: attributes)
        label.attributedText = NSAttributedString(string: placeholderText, attributes: attributes)
        label.textColor = .lightGray
        label.frame = .init(x: textContainerInset.left , y: textContainerInset.top, width: size.width, height: size.height)
        addSubview(label)
    }

    func hidePlaceholder() {
        placeholderLabel?.isHidden = true
    }

    func showPlaceholder() {
        placeholderLabel?.isHidden = false
    }
}
