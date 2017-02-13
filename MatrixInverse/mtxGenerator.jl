#Maks Brandt & Dawid Wegner - zadanie P3.20
#Moduł udostępnia funkcje generujące losowe macierze, macierze z dużymi różnicami wartości elemntów oraz macierze źle uwarunkowane (Pei i Hilberta)

function asFloatMtx(mtx)
  mtxSize = size(mtx, 1)
  result = zeros(mtxSize, mtxSize)
  for i in 1:mtxSize
    for j in 1:mtxSize
      result[i, j] = mtx[i, j]
    end
  end
  return result
end

function getRandomInvMtx(mtxSize, minVal, maxVal)
  ATTEMPT_COUNT = 1000
  for i in 1:ATTEMPT_COUNT
    mtx = asFloatMtx(rand(minVal:maxVal, mtxSize, mtxSize))
    if checkIfInvertible(mtx)
      return mtx
    end
  end
  throw("Getting random invertible matrix: too many attempts")
end

function getRandomInvMtxArr(mtxSize, minVal, maxVal, arrSize)
  result = []
  for i in 1:arrSize
    push!(result, getRandomInvMtx(mtxSize, minVal, maxVal))
  end
  return result
end

function genRandomLargeDiffMtx(mtxSize, minVal, maxVal)
  result = zeros(mtxSize, mtxSize)
  for i in 1:mtxSize
    for j in 1:mtxSize
      if rand(1:2) == 1
        result[i, j] = rand() * (maxVal - minVal) + minVal
      else
        result[i, j] = rand()
      end
    end
  end
  return result
end

function getRandomLargeDiffMtx(mtxSize, minVal, maxVal)
  ATTEMPT_COUNT = 1000
  for i in 1:ATTEMPT_COUNT
    mtx = genRandomLargeDiffMtx(mtxSize, minVal, maxVal)
    if checkIfInvertible(mtx)
      return mtx
    end
  end
  throw("Getting random invertible matrix: too many attempts")
end

function getRandomLargeDiffMtxArr(mtxSize, minVal, maxVal, arrSize)
  result = []
  for i in 1:arrSize
    push!(result, getRandomLargeDiffMtx(mtxSize, minVal, maxVal))
  end
  return result
end

function getHibertMtx(mtxSize)
  result = zeros(mtxSize, mtxSize)
  for i in 1:mtxSize
    for j in 1:mtxSize
      result[i, j] = 1.0 / (i + j - 1)
    end
  end
  return result
end

function getPeiMtx(mtxSize)
  result = zeros(mtxSize, mtxSize)
  for i in 1:mtxSize
    for j in 1:mtxSize
      if i != j
        result[i, j] = 1.0
      else
        randEps = (rand() / 1000) - 0.001
        result[i, j] = 1.0 + randEps
      end
    end
  end
  return result
end
