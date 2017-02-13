#Maks Brandt & Dawid Wegner - zadanie P3.20
#Moduł udostępnia funkcje rozwiązujące równania liniowe z macierzami dolnotrójkątnymi/górnotrójkątnymi

function lTriangEquation(lMtx, pMtx)
  mtxSize = size(lMtx, 1)
  result = zeros(mtxSize, mtxSize)
  for i in 1:mtxSize
    result[1, i] = pMtx[1, i] / lMtx[1, 1]
    for j in 2:mtxSize
      elSum = sum(lMtx[j, 1:(j - 1)] .* result[1:(j - 1), i])
      result[j, i] = (pMtx[j, i] - elSum) / lMtx[j, j]
    end
  end
  return result
end

function uTriangEquation(uMtx, pMtx)
  mtxSize = size(uMtx, 1)
  result = zeros(mtxSize, mtxSize)
  for i in 1:mtxSize
    result[mtxSize, i] = pMtx[mtxSize, i] / uMtx[mtxSize, mtxSize]
    for j in (mtxSize - 1):(-1):1
      elSum = sum(uMtx[j, (j + 1):end] .* result[(j + 1):end, i])
      result[j, i] = (pMtx[j, i] - elSum) / uMtx[j, j]
    end
  end
  return result
end
