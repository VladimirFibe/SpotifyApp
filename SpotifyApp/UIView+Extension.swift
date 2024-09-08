import UIKit

extension UIView {
    var widht: CGFloat { frame.size.width }
    var height: CGFloat { frame.size.height }
    var left: CGFloat { frame.origin.x }
    var top: CGFloat { frame.origin.y }
    var right: CGFloat { frame.size.width + frame.origin.x }
    var bottom: CGFloat { frame.size.height + frame.origin.y }
}
