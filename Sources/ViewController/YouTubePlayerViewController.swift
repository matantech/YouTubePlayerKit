#if os(macOS)
import AppKit
#else
import UIKit
#endif

// MARK: - YouTubePlayerBaseViewController

#if os(macOS)
/// The YouTubePlayerBase NSViewController
public class YouTubePlayerBaseViewController: NSViewController {}
#else
/// The YouTubePlayerBase UIViewController
public class YouTubePlayerBaseViewController: UIViewController {}
#endif

// MARK: - YouTubePlayerViewController

/// The YouTubePlayer ViewController
public final class YouTubePlayerViewController: YouTubePlayerBaseViewController {
    
    // MARK: Properties
    
    /// The YouTubePlayer
    public let player: YouTubePlayer

    public var closeButton: UIButton?
    
    // MARK: Initializer
    
    /// Creates a new instance of `YouTubePlayerViewController`
    /// - Parameters:
    ///   - player: The YouTubePlayer
    public init(
        player: YouTubePlayer
    ) {
        self.player = player
        super.init(nibName: nil, bundle: nil)
    }
    
    /// Creates a new instance of `YouTubePlayerViewController`
    /// - Parameters:
    ///   - source: The optional YouTubePlayer Source. Default value `nil`
    ///   - configuration: The YouTubePlayer Configuration. Default value `.init()`
    public convenience init(
        source: YouTubePlayer.Source? = nil,
        configuration: YouTubePlayer.Configuration = .init()
    ) {
        self.init(
            player: .init(
                source: source,
                configuration: configuration
            )
        )
    }
    
    /// Initializer with NSCoder is unavailable.
    /// Use `init(player:)`
    @available(*, unavailable)
    public required init?(
        coder aDecoder: NSCoder
    ) { nil }
    
    /// Deinit
    deinit {
        self.player.pause()
    }
    
    // MARK: View-Lifecycle
    
    /// Creates the view that the controller manages
    public override func loadView() {
        self.view = self.player.webView
        addCloseButton()
    }

    private func addCloseButton() {
        if let closeButton {
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        }
    }
    
    // MARK: Action
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}
