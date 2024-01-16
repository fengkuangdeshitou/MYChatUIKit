
// Copyright (c) 2022 NetEase, Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import Foundation
import NECommonKit
import NIMSDK

@objcMembers
public class MessageTextModel: MessageContentModel {
  public var attributeStr: NSMutableAttributedString?
  public var textHeight: CGFloat = 0

  public required init(message: NIMMessage?) {
    super.init(message: message)
    type = .text

    attributeStr = NEEmotionTool.getAttWithStr(
      str: message?.text ?? "",
      font: UIFont.systemFont(ofSize: NEKitChatConfig.shared.ui.messageProperties.messageTextSize)
    )
    let color = message!.isOutgoingMsg ? UIColor.init(hexString: "#282828") : UIColor.init(hexString: "#D5D5D5")
    attributeStr?.addAttribute(NSAttributedString.Key.foregroundColor, value:color, range: NSMakeRange(0, attributeStr!.length))
    if let remoteExt = message?.remoteExt, let dic = remoteExt[yxAtMsg] as? [String: AnyObject] {
      dic.forEach { (key: String, value: AnyObject) in
        if let contentDic = value as? [String: AnyObject] {
          if let array = contentDic[atSegmentsKey] as? [AnyObject] {
            if let models = NSArray.yx_modelArray(with: MessageAtInfoModel.self, json: array) as? [MessageAtInfoModel] {
              models.forEach { model in
                if attributeStr?.length ?? 0 > model.end {
                  attributeStr?.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.ne_blueText, range: NSMakeRange(model.start, model.end - model.start + atRangeOffset))
                }
              }
            }
          }
        }
      }
    }

      var maxWidth = 0.0
      let orientation = UIApplication.shared.statusBarOrientation
      if (orientation == .portrait || orientation == .portraitUpsideDown) {
          maxWidth = chat_text_maxW
      }else{
          maxWidth = 311 - 70 - 20 - 2 * chat_content_margin
      }
      
    let textSize = attributeStr?.finalSize(.systemFont(ofSize: NEKitChatConfig.shared.ui.messageProperties.messageTextSize), CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)) ?? .zero

    textHeight = textSize.height
    contentSize = CGSize(width: textSize.width + chat_content_margin * 2, height: textHeight + chat_content_margin * 2)
      height = Float(contentSize.height + chat_content_margin) + fullNameHeight
  }
}
