//
// Created by Mariano D'Agostino on 8/21/16.
// Copyright (c) 2016 Tictapps. All rights reserved.
//

import Foundation

public class TTError: TTGenericDTO {

    public var title: String?

    public var message: String?

    static public func errorFromMessage(_ message: String) -> TTError {
        let result = TTError()
        result.message = NSLocalizedString(message, comment: "")
        return result
    }

    static public func errorFromMessageAndTitle(_ message: String, title: String) -> TTError {
        let result = TTError.errorFromMessage(message)
        result.title = NSLocalizedString(title, comment: "")
        return result
    }

}
