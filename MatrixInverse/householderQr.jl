#Maks Brandt & Dawid Wegner - zadanie P3.20
#Moduł udostępnia funkcję obliczającą rozkład QR macierzy za pomocą transformacji Householdera

function householderQrDcmp(inMtx)
  mtxSize = size(inMtx, 1)
  qMtx = eye(mtxSize, mtxSize)
  rMtx = copy(inMtx)
  for i in 1:mtxSize
    colNorm = norm(rMtx[i:end, i])
    colFac = rMtx[i, i] + colNorm
    mtxCol = rMtx[i:end, i] / colFac
    mtxCol[1] = 1.0
    transCol = colFac / colNorm * mtxCol
    rMtx[i:end, :] -= transCol * (mtxCol' * rMtx[i:end, :])
    qMtx[:, i:end] -= (qMtx[:, i:end] * mtxCol) * transCol'
  end
  return (qMtx, rMtx)
end
