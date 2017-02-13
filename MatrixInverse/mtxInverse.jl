#Maks Brandt & Dawid Wegner - zadanie P3.20
#Moduł udostępnia funkcje odwracające macierze za pomocą rozkładów LU i QR oraz funkcję sprawdzającą, czy macierz jest odwracalna

@enum InvMethod LUP_METHOD = 1 QR_GRAM = 2 QR_HOUSEHOLDER = 3 QR_GIVENS = 4

function qrMtxInverse(inMtx, qrMethod)
  mtxSize = size(inMtx, 1)
  (qMtx, rMtx) = qrMethod(inMtx)
  rInv = uTriangEquation(rMtx, eye(mtxSize, mtxSize))
  return rInv * qMtx'
end

function lupMtxInverse(inMtx)
  (lMtx, uMtx, pMtx) = lupDcmp(inMtx)
  return uTriangEquation(uMtx, lTriangEquation(lMtx, pMtx))
end

function mtxInverse(inMtx, invMethod)
  if invMethod == LUP_METHOD
    return lupMtxInverse(inMtx)
  elseif invMethod == QR_GRAM
    return qrMtxInverse(inMtx, gramQrDcmp)
  elseif invMethod == QR_HOUSEHOLDER
    return qrMtxInverse(inMtx, householderQrDcmp)
  elseif invMethod == QR_GIVENS
    return qrMtxInverse(inMtx, givensQrDcmp)
  else
    throw("Incorrect argument: invMethod")
  end
end

function checkIfInvertible(mtx)
  EPS = 10e-6
  mtxSize = size(mtx, 1)
  (lMtx, uMtx, pMtx) = lupDcmp(mtx)
  for i in 1:mtxSize
    if abs(lMtx[i, i]) < EPS || abs(uMtx[i, i]) < EPS
      return false
    end
  end
  return true
end
