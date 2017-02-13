#Maks Brandt & Dawid Wegner - zadanie P2.20
#Moduł udostępnia funkcję obliczjącą bazę dualną metodą macierzową 

function getMatrixFactor(baseScalar, dualScalar, baseSize)
  result = baseScalar[baseSize]
  for i in range(1, baseSize - 1)
    result -= (baseScalar[i] * dualScalar[i])
  end
  return result
end

function getFactorsMatrix(baseScalar, dualScalar, matrixFactor, baseSize)
  result = zeros(baseSize, baseSize)
  for i in range(1, baseSize - 1)
    for j in range(1, baseSize - 1)
      index = baseSize * (j - 1) + i
      result[index] = baseScalar[i] * dualScalar[j]
      if i == j
        result[index] += matrixFactor
      end
    end
  end
  for i in range(1, baseSize - 1)
    result[i * baseSize] = -dualScalar[i]
    result[i + baseSize * (baseSize - 1)] = -baseScalar[i]
  end
  result[baseSize * baseSize] = 1.0
  result *= (1 / matrixFactor)
  return result
end

function getFactors(base, dualBase, baseSize, scalarFunc)
  baseScalar = scalarProdArr(base[baseSize], base, scalarFunc)
  dualScalar = scalarProdArr(base[baseSize], dualBase, scalarFunc)
  matrixFactor = getMatrixFactor(baseScalar, dualScalar, baseSize)
  return getFactorsMatrix(baseScalar, dualScalar, matrixFactor, baseSize)
end

function countMatrixBase(base, dualBase, baseSize, factors)
  result = []
  for i in range(1, baseSize)
    vec = [0.0]
    for j in range(1, baseSize - 1)
      index = j + baseSize * (i - 1)
      sumVec = mulVec(factors[index], dualBase[j])
      vec = addVec(vec, sumVec)
    end
    sumVec = mulVec(factors[baseSize * i], base[baseSize])
    vec = addVec(vec, sumVec)
    push!(result, vec)
  end
  return result
end

function matrixMethod(base, scalarFunc)
  baseSize = length(base)
  baseNorm = getNormQuad(base[1], scalarFunc)
  result = [mulVec(1 / baseNorm, base[1])]
  for i in range(2, baseSize - 1)
    factors = getFactors(base, result, i, scalarFunc)
    result = countMatrixBase(base, result, i, factors)
  end
  return result
end

function matrixMethodTest()
  base = [[1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0]]
  scalarFunc = intScalarFunc(-1.0, 1.0)
  result = matrixMethod(base, scalarFunc)
  println(result)
  for i in range(1, 3)
    for j in range(1, 3)
      println(scalarFunc(base[i], result[j]))
    end
  end
end
