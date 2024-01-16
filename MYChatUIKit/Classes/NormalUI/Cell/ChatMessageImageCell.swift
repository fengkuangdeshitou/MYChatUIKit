
// Copyright (c) 2022 NetEase, Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import NIMSDK
import UIKit

@objcMembers
open class ChatMessageImageCell: NormalChatMessageBaseCell {
  public let contentImageViewLeft = UIImageView()
  public let contentImageViewRight = UIImageView()
  override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    delegate = self
    commonUI()
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  open func commonUI() {
    commonUIRight()
    commonUILeft()
  }

  open func commonUILeft() {
    contentImageViewLeft.translatesAutoresizingMaskIntoConstraints = false
    contentImageViewLeft.contentMode = .scaleAspectFill
    contentImageViewLeft.clipsToBounds = true
    contentImageViewLeft.accessibilityIdentifier = "id.thumbnail"
//    contentImageViewLeft.addCustomCorner(
//      conrners: [.bottomLeft, .bottomRight, .topRight],
//      radius: 8,
//      backcolor: .white
//    )
    bubbleImageLeft.addSubview(contentImageViewLeft)
    NSLayoutConstraint.activate([
      contentImageViewLeft.rightAnchor.constraint(equalTo: bubbleImageLeft.rightAnchor, constant: 0),
      contentImageViewLeft.leftAnchor.constraint(equalTo: bubbleImageLeft.leftAnchor, constant: 0),
      contentImageViewLeft.topAnchor.constraint(equalTo: bubbleImageLeft.topAnchor, constant: 0),
      contentImageViewLeft.bottomAnchor.constraint(
        equalTo: bubbleImageLeft.bottomAnchor,
        constant: 0
      ),
    ])
  }

  open func commonUIRight() {
    contentImageViewRight.translatesAutoresizingMaskIntoConstraints = false
    contentImageViewRight.contentMode = .scaleAspectFill
    contentImageViewRight.clipsToBounds = true
    contentImageViewRight.accessibilityIdentifier = "id.thumbnail"
//    contentImageViewRight.addCustomCorner(
//      conrners: [.topLeft, .bottomLeft, .bottomRight],
//      radius: 8,
//      backcolor: .white
//    )

    bubbleImageRight.addSubview(contentImageViewRight)
    NSLayoutConstraint.activate([
      contentImageViewRight.rightAnchor.constraint(equalTo: bubbleImageRight.rightAnchor, constant: 0),
      contentImageViewRight.leftAnchor.constraint(equalTo: bubbleImageRight.leftAnchor, constant: 0),
      contentImageViewRight.topAnchor.constraint(equalTo: bubbleImageRight.topAnchor, constant: 0),
      contentImageViewRight.bottomAnchor.constraint(
        equalTo: bubbleImageRight.bottomAnchor,
        constant: 0
      ),
    ])
  }

  override open func showLeftOrRight(showRight: Bool) {
    super.showLeftOrRight(showRight: showRight)
    contentImageViewLeft.isHidden = showRight
    contentImageViewRight.isHidden = !showRight
  }

  override open func setModel(_ model: MessageContentModel) {
    super.setModel(model)
    guard let isSend = model.message?.isOutgoingMsg else {
      return
    }
    let contentImageView = isSend ? contentImageViewRight : contentImageViewLeft
      contentImageView.layer.cornerRadius = 8
    if let m = model as? MessageImageModel, let imageUrl = m.imageUrl {
      if imageUrl.hasPrefix("http") {
        contentImageView.sd_setImage(
          with: URL(string: imageUrl),
          placeholderImage: nil,
          options: .retryFailed,
          progress: nil,
          completed: nil
        )
      } else {
        contentImageView.image = UIImage(contentsOfFile: imageUrl)
      }
    } else {
      contentImageView.image = nil
    }
  }
}

extension ChatMessageImageCell : ChatBaseCellDelegate {
    public func didTapAvatarView(_ cell: UITableViewCell, _ model: MessageContentModel?) {
        
    }
    
    public func didLongPressAvatar(_ cell: UITableViewCell, _ model: MessageContentModel?) {
        
    }
    
    public func didTapMessageView(_ cell: UITableViewCell, _ model: MessageContentModel?) {
        if let model = model as? MessageImageModel {
            if let imageUrl = model.imageUrl {
                let showController = PhotoBrowserController(
                    urls: [imageUrl], url: imageUrl
                )
                showController.modalPresentationStyle = .overFullScreen
                UIApplication.shared.keyWindow?.rootViewController?.present(showController, animated: false)
            }
        }
        if let model = model as? MessageVideoModel {
            if let object = model.message?.messageObject as? NIMVideoObject {
                let videoPlayer = VideoPlayerViewController()
                videoPlayer.modalPresentationStyle = .overFullScreen
                if let path = object.path, FileManager.default.fileExists(atPath: path) == true {
                  let url = URL(fileURLWithPath: path)
                  videoPlayer.videoUrl = url
                  videoPlayer.totalTime = object.duration
                  UIApplication.shared.keyWindow?.rootViewController?.present(videoPlayer, animated: true, completion: nil)
                }
            }
        }
    }
    
    public func didLongPressMessageView(_ cell: UITableViewCell, _ model: MessageContentModel?) {
        
    }
    
    public func didTapResendView(_ cell: UITableViewCell, _ model: MessageContentModel?) {
        
    }
    
    public func didTapReeditButton(_ cell: UITableViewCell, _ model: MessageContentModel?) {
        
    }
    
    public func didTapReadView(_ cell: UITableViewCell, _ model: MessageContentModel?) {
        
    }
    
}
