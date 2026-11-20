-- Decompiled source supplied by the user.
-- Reference only: _UPVALUE0_ (cache) and _UPVALUE1_ (TEA key)
-- are not resolved. This file is intentionally not loaded by meta.xml.

function decrypt(_ARG_0_)
  if _UPVALUE0_[_ARG_0_] ~= nil then
    return _UPVALUE0_[_ARG_0_]
  end
  if fileExists(_ARG_0_) and fileOpen(_ARG_0_) then
    fileClose(fileExists(_ARG_0_) and fileOpen(_ARG_0_))
    _UPVALUE0_[_ARG_0_] = base64Decode(decodeString("tea", fileRead(fileExists(_ARG_0_) and fileOpen(_ARG_0_), fileGetSize(fileExists(_ARG_0_) and fileOpen(_ARG_0_))), _UPVALUE1_))
    return _UPVALUE0_[_ARG_0_] or false
  end
  _UPVALUE0_[_ARG_0_] = false
end
