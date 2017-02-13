#Maks Brandt & Dawid Wegner - zadanie P2.20
#Moduł udostępnia funkcję obliczjącą bazę dualną metodą iteracyjną (poprawiona metoda macierzowa)

function getOptFactor(baseScalar, dualScalar, baseSize)
  result = baseScalar[baseSize]
  for i in range(1, baseSize - 1)
    result -= (baseScalar[i] * dualScalar[i])
  end
  return result
end

function getFactorArr(baseScalar, optFactor, baseSize)
  result = zeros(baseSize)
  for i in range(1, baseSize - 1)
    result[i] = -baseScalar[i] / optFactor
  end
  result[baseSize] = 1 / optFactor
  return result
end

function countOptBase(base, dualBase, baseSize, scalarFunc)
  baseScalar = scalarProdArr(base[baseSize], base, scalarFunc)
  dualScalar = scalarProdArr(base[baseSize], dualBase, scalarFunc)
  optFactor = getOptFactor(baseScalar, dualScalar, baseSize)
  factorArr = getFactorArr(baseScalar, optFactor, baseSize)
  result = fill([0.0], baseSize)
  result[baseSize] = mulVec(factorArr[baseSize], base[baseSize])
  for i in range(1, baseSize - 1)
    vec = mulVec(factorArr[i], dualBase[i])
    result[baseSize] = addVec(result[baseSize], vec)
  end
  for i in range(1, baseSize - 1)
    vec = mulVec(dualScalar[i], result[baseSize])
    result[i] = subVec(dualBase[i], vec)
  end
  return result
end

function optMethod(base, scalarFunc)
  baseSize = length(base)
  baseNorm = getNormQuad(base[1], scalarFunc)
  result = [mulVec(1 / baseNorm, base[1])]
  for i in range(2, baseSize - 1)
    result = countOptBase(base, result, i, scalarFunc)
  end
  return result
end

function optMethodTest()
  base = [[1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0]]
  scalarFunc = intScalarFunc(-1.0, 1.0)
  result = optMethod(base, scalarFunc)
  println(result)
  for i in range(1, 3)
    for j in range(1, 3)
      println(scalarFunc(base[i], result[j]))
    end
  end
end
