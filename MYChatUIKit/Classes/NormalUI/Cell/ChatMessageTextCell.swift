
// Copyright (c) 2022 NetEase, Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import UIKit

@objcMembers
open class ChatMessageTextCell: NormalChatMessageBaseCell {
    public var deleteMessageCompletiion:((_ message:MessageTextModel?)->Void)?
    public var revokeMessageCompletiion:((_ message:MessageTextModel?)->Void)?
  public lazy var contentLabelLeft: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.isEnabled = false
    label.numberOfLines = 0
    label.isUserInteractionEnabled = false
    label.font = .systemFont(ofSize: NEKitChatConfig.shared.ui.messageProperties.messageTextSize)
    label.backgroundColor = .clear
    label.textAlignment = .justified
    label.accessibilityIdentifier = "id.messageText"
    return label
  }()

  public lazy var contentLabelRight: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.isEnabled = false
    label.numberOfLines = 0
    label.isUserInteractionEnabled = false
    label.font = .systemFont(ofSize: NEKitChatConfig.shared.ui.messageProperties.messageTextSize)
    label.backgroundColor = .clear
    label.textAlignment = .justified
    label.accessibilityIdentifier = "id.messageText"
    return label
  }()

  override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    delegate = self
    commonUI()
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  open func commonUI() {
    bubbleImageLeft.addSubview(contentLabelLeft)
    NSLayoutConstraint.activate([
      contentLabelLeft.rightAnchor.constraint(equalTo: bubbleImageLeft.rightAnchor, constant: -chat_content_margin),
      contentLabelLeft.leftAnchor.constraint(equalTo: bubbleImageLeft.leftAnchor, constant: chat_content_margin),
      contentLabelLeft.topAnchor.constraint(equalTo: bubbleImageLeft.topAnchor, constant: chat_content_margin),
      contentLabelLeft.bottomAnchor.constraint(equalTo: bubbleImageLeft.bottomAnchor, constant: -chat_content_margin),
    ])

    bubbleImageRight.addSubview(contentLabelRight)
    NSLayoutConstraint.activate([
      contentLabelRight.rightAnchor.constraint(equalTo: bubbleImageRight.rightAnchor, constant: -chat_content_margin),
      contentLabelRight.leftAnchor.constraint(equalTo: bubbleImageRight.leftAnchor, constant: chat_content_margin),
      contentLabelRight.topAnchor.constraint(equalTo: bubbleImageRight.topAnchor, constant: chat_content_margin),
      contentLabelRight.bottomAnchor.constraint(equalTo: bubbleImageRight.bottomAnchor, constant: -chat_content_margin),
    ])
  }

  override open func showLeftOrRight(showRight: Bool) {
    super.showLeftOrRight(showRight: showRight)
    contentLabelLeft.isHidden = showRight
    contentLabelRight.isHidden = !showRight
  }

  override open func setModel(_ model: MessageContentModel) {
    super.setModel(model)
    guard let isSend = model.message?.isOutgoingMsg else {
      return
    }
    let contentLabel = isSend ? contentLabelRight : contentLabelLeft
    if let m = model as? MessageTextModel {
      contentLabel.attributedText = m.attributeStr
    }
  }
}

extension ChatMessageTextCell : ChatBaseCellDelegate {
    
    open override var canBecomeFirstResponder: Bool{
        return true
    }
    
    public func didTapAvatarView(_ cell: UITableViewCell, _ model: MessageContentModel?) {
        
    }
    
    public func didLongPressAvatar(_ cell: UITableViewCell, _ model: MessageContentModel?) {
        
    }
    
    public func didTapMessageView(_ cell: UITableViewCell, _ model: MessageContentModel?) {
        if let model = model as? MessageTextModel {
            
            guard let isSend = model.message?.isOutgoingMsg else {
              return
            }
            let contentLabel = isSend ? contentLabelRight : contentLabelLeft
            
            let copy = UIMenuItem(title: "复制", action: #selector(copyAction))
            let delete = UIMenuItem(title: "删除", action: #selector(deleteAction))
            let revoke = UIMenuItem(title: "撤回", action: #selector(revokeAction))

            let menu = UIMenuController.shared
            if (isSend && (Date().timeIntervalSince1970 - model.message!.timestamp < 120)){
                menu.menuItems = [copy,delete,revoke]
            }else{
                menu.menuItems = [copy,delete]
            }
            menu.setTargetRect(contentLabel.bounds, in: contentLabel)
            menu.setMenuVisible(true, animated: true)
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
    
    public func copyAction () {
        UIPasteboard.general.string = self.contentModel?.message?.text
    }
    
    public func deleteAction () {
        if let deleteMessageCompletiion = deleteMessageCompletiion {
            if let m = contentModel as? MessageTextModel {
                deleteMessageCompletiion(m)
            }
        }
    }
    
    public func revokeAction () {
        if let revokeMessageCompletiion = revokeMessageCompletiion {
            if let m = contentModel as? MessageTextModel {
                revokeMessageCompletiion(m)
            }
        }
    }
}
