#Maks Brandt & Dawid Wegner - zadanie P3.20
#Moduł udostępnia funkcję obliczającą rozkład LU macierzy

function getAbsMaxValInd(vec)
  ind = 0
  maxVal = -1.0
  for i in 1:length(vec)
    if abs(vec[i]) > maxVal
      maxVal = vec[i]
      ind = i
    end
  end
  return ind
end

function swapRow(mtx, rInd1, rInd2, rng)
  mtx[rInd1, rng], mtx[rInd2, rng] = mtx[rInd2, rng], mtx[rInd1, rng]
end

function lupDcmp(inMtx)
  mtxSize = size(inMtx, 1)
  lMtx = eye(mtxSize, mtxSize)
  uMtx = copy(inMtx)
  pMtx = eye(mtxSize, mtxSize)
  for i in 1:(mtxSize - 1)
    rInd = getAbsMaxValInd(uMtx[i:end, i]) + i - 1
    swapRow(lMtx, i, rInd, 1:(i - 1))
    swapRow(uMtx, i, rInd, i:mtxSize)
    swapRow(pMtx, i, rInd, 1:mtxSize)
    for j in (i + 1):mtxSize
      lMtx[j, i] = uMtx[j, i] / uMtx[i, i]
      uMtx[j, i:end] -= lMtx[j, i] * uMtx[i, i:end]
    end
  end
  return (lMtx, uMtx, pMtx)
end
