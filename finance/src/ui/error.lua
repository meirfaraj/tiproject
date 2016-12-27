
--------------------------------------------------------------------------
--                            Error handling                            --
--------------------------------------------------------------------------

require("ui/widgets/sRichInput")
errorHandler = {}

function errorPopup(gc)
    -- TODO : add mask all active editors
    errorHandler.display = false

    errorDialog = Dialog(ASTxt(ERROR_TITLE_ID), 50, 20, "85", "80")

    local textMessage	=  ASTxt(ERROR_ID) .. errorHandler.errorLine .. ":"..errorHandler.errorMessage..")"
    
    local errorOKButton	= sButton("OK")
    
    for i, line in ipairs(textMessage:split("\n")) do
        local errorLabel = sLabel(line)
        errorDialog:appendWidget(errorLabel, 10, 27 + i*14-12)
    end
    
    errorDialog:appendWidget(errorOKButton,-10,-5)
    
    function errorDialog:postPaint(gc)
        nativeBar(gc, self, self.h-40)
    end
    
    errorOKButton:giveFocus()
    
    function errorOKButton:action()
        remove_screen(errorDialog)
        errorHandler.errorMessage = nil
    current_screen():onErrorDispEnd();
    end
    current_screen():onErrorDispStart();
    push_screen_direct(errorDialog)
end

function handleError(line, errMsg, callStack, locals)
    print(ASTxt(ERROR_TITLE_ID), errMsg)
    errorHandler.display = true
    errorHandler.errorMessage = errMsg
    errorHandler.errorLine = line
    errorHandler.callStack = callStack
    errorHandler.locals = locals
    platform.window:invalidate()
    return true -- go on....
end

if platform.registerErrorHandler then
    platform.registerErrorHandler( handleError )
end


