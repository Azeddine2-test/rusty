-- DECOMPILATION DE REFERENCE UNIQUEMENT
-- Source fourni par l'utilisateur depuis Anubis.
-- ATTENTION : ce fichier n'est PAS charge par meta.xml.
-- Les upvalues _UPVALUE0_ (cache) et _UPVALUE1_ (cle TEA)
-- n'ont pas encore ete reconstituees. Ne pas utiliser en runtime.

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
