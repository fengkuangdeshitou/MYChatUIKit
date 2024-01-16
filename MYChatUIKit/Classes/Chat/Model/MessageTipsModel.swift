
// Copyright (c) 2022 NetEase, Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import Foundation
import NIMSDK

@objcMembers
public class MessageTipsModel: NSObject, MessageModel {
    public  var offset: CGFloat = 0

    public func cellHeight() -> CGFloat {
        CGFloat(height) + offset
      }

    public var tipTimeStamp: TimeInterval?

    public var isReplay: Bool = false

    public var pinToAccount: String?
    public var pinFromAccount: String?
    public var isPined: Bool = false
    public var pinAccount: String?
    public var pinShowName: String?
    public var replyText: String?
    public var type: MessageType = .tip
    public var message: NIMMessage?
    public var contentSize: CGSize = .zero
    public var height: Float = 28
    public var shortName: String?
    public var fullName: String?
    public var avatar: String?
    public var text: String?
    public var isRevoked: Bool = false
    public var replyedModel: MessageModel?
    public var isRevokedText: Bool = false
    public weak var tipMessage: NIMMessage?

  func commonInit(message: NIMMessage?) {
    if let msg = message {
      if msg.messageType == .notification {
        text = NotificationMessageUtils.textForNotification(message: msg)
        type = .notification
      } else if msg.messageType == .tip {
        text = msg.text
        type = .tip
      }

      tipMessage = msg
      tipTimeStamp = msg.timestamp
    }

    var font: UIFont = .systemFont(ofSize: NEKitChatConfig.shared.ui.messageProperties.timeTextSize)

      var maxWidth = 0.0
        let orientation = UIApplication.shared.statusBarOrientation
        if (orientation == .portrait || orientation == .portraitUpsideDown) {
            maxWidth = chat_text_maxW
        }else{
            maxWidth = 311 - 4 * chat_content_margin
        }
      
        contentSize = String.getTextRectSize(text ?? "",
                                             font: font,
                                             size: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
        height = Float(max(contentSize.height + chat_content_margin, 28))
      }

    public required init(message: NIMMessage?) {
        super.init()
        commonInit(message: message)
    }

    public init(message: NIMMessage?, initType: MessageType = .tip, initText: String? = nil) {
        super.init()
        type = initType
        text = initText
        commonInit(message: message)
    }

  public func resetNotiText() {
    if let msg = tipMessage {
      if msg.messageType == .notification {
        text = NotificationMessageUtils.textForNotification(message: msg)
        type = .notification
      }
    }
  }
}
