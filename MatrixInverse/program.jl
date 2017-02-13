#Maks Brandt & Dawid Wegner - zadanie P3.20
#Moduł główny, który służył do przeprowadzenia testów opisanych w sprawozdaniu

include("triangEquation.jl")
include("lupDcmp.jl")
include("gramSchmidtQr.jl")
include("householderQr.jl")
include("givensQr.jl")
include("mtxInverse.jl")
include("mtxGenerator.jl")
include("test.jl")

function formatEstError(estError)
  MAX_ERROR = 10 ^ 9
  result = 0
  while estError < MAX_ERROR
    estError *= 10
    result += 1
  end
  return -result + round(Int, log(10, MAX_ERROR))
end

function printInvMethod(invMethod)
  if invMethod == LUP_METHOD
    println("Odwracanie macierzy za pomocą rozkładu LU:")
  elseif invMethod == QR_GRAM
    println("Odwracanie macierzy za pomocą rozkładu QR (Gram-Schmidt):")
  elseif invMethod == QR_HOUSEHOLDER
    println("Odwracanie macierzy za pomocą rozkładu QR (transformacje Householdera): ")
  elseif invMethod == QR_GIVENS
    println("Odwracanie macierzy za pomocą rozkładu QR (rotacje Givensa): ")
  else
    throw("Incorrect argument: method")
  end
end

function timeTest(invMethod, testRange, iterCount)
  printInvMethod(invMethod)
  for i in testRange
    totalTime = 0
    for j in 1:iterCount
      mtx = getRandomInvMtx(i, -100, 100)
      startTime = now()
      mtxInverse(mtx, invMethod)
      totalTime += Int(now() - startTime)
    end
    println("Rozmiar macierzy: ", i, ", czas: ", totalTime, " ms")
  end
end

function mtxPrecisionTest(invMethod, mtx)
  leftErrorSum = BigFloat(0)
  rightErrorSum = BigFloat(0)
  mtxSize = size(mtx, 1)
  mtxInv = mtxInverse(mtx, invMethod)
  leftErr = mtx * mtxInv - eye(mtxSize, mtxSize)
  rightErr = mtxInv * mtx - eye(mtxSize, mtxSize)
  for i in 1:mtxSize
    for j in 1:mtxSize
      leftErrorSum += BigFloat(leftErr[i, j]) ^ 2
      rightErrorSum += BigFloat(rightErr[i, j]) ^ 2
    end
  end
  return (sqrt(leftErrorSum), sqrt(rightErrorSum))
end

function mtxArrPrecisionTest(invMethod, mtxArr)
  leftEstError = BigFloat(0)
  rightEstError = BigFloat(0)
  for mtx in mtxArr
    (lError, rError) = mtxPrecisionTest(invMethod, mtx)
    leftEstError += lError
    rightEstError += rError
  end
  leftEstError /= length(mtxArr)
  rightEstError /= length(mtxArr)
  print(", błąd rzędu: ")
  println(formatEstError(leftEstError), ", ", formatEstError(rightEstError))
end

function methodPrecisionTest(sizeRange, mtxGenFunc)
  methodArr = [LUP_METHOD, QR_GRAM, QR_HOUSEHOLDER, QR_GIVENS]
  for method in methodArr
    printInvMethod(method)
    for mtxSize in sizeRange
      print("Rozmiar macierzy: ", mtxSize)
      mtxArr = mtxGenFunc(mtxSize)
      mtxArrPrecisionTest(method, mtxArr)
    end
    println()
  end
end


mtx = zeros(6, 6)
for i in 1:6
  for j in 1:6
    if i == j
      mtx[i, j] = 1.0
    elseif i < j
      mtx[i, j] = -1.0
    else
      mtx[i, j] = 0.0
    end
  end
end

println(mtxInverse(mtx, LUP_METHOD))
