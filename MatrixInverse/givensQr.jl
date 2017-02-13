#Maks Brandt & Dawid Wegner - zadanie P3.20
#Moduł udostępnia funkcję obliczającą rozkład QR macierzy za pomocą rotacji Givensa

function updateQMtx(qMtx, sAngle, cAngle, ind)
  mtxSize = size(qMtx, 1)
  row1 = zeros(mtxSize)
  row2 = zeros(mtxSize)
  for i in 1:mtxSize
    row1[i] = qMtx[i, ind - 1] * cAngle - qMtx[i, ind] * sAngle
    row2[i] = qMtx[i, ind - 1] * sAngle + qMtx[i, ind] * cAngle
  end
  qMtx[:, ind - 1] = row1
  qMtx[:, ind] = row2
end

function updateRMtx(rMtx, sAngle, cAngle, ind)
  mtxSize = size(rMtx, 1)
  col1 = zeros(mtxSize)
  col2 = zeros(mtxSize)
  for i in 1:mtxSize
    col1[i] = rMtx[ind - 1, i] * cAngle - rMtx[ind, i] * sAngle
    col2[i] = rMtx[ind - 1, i] * sAngle + rMtx[ind, i] * cAngle
  end
  rMtx[ind - 1, :] = col1
  rMtx[ind, :] = col2
end

function givensQrDcmp(inMtx)
  mtxSize = size(inMtx, 1)
  qMtx = eye(mtxSize, mtxSize)
  rMtx = copy(inMtx)
  for i = 1:mtxSize
    for j = mtxSize:(-1):(i + 1)
        vNorm = norm([rMtx[j - 1, i], rMtx[j, i]])
        if vNorm <= 0
          continue
        end
        sAngle = -rMtx[j, i] / vNorm
        cAngle = rMtx[j - 1, i] / vNorm
        updateQMtx(qMtx, sAngle, cAngle, j)
        updateRMtx(rMtx, sAngle, cAngle, j)
      end
    end
    return (qMtx, rMtx)
end
